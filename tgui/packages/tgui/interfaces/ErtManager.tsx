import { useState } from 'react';
import {
  Box,
  Button,
  Icon,
  Input,
  LabeledList,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const PickTab = (index) => {
  switch (index) {
    case 0:
      return <SendERT />;
    case 1:
      return <ReadERTRequests />;
    case 2:
      return <DenyERT />;
    default:
      return "SOMETHING WENT VERY WRONG PLEASE AHELP, WAIT YOU'RE AN ADMIN, OH FUUUUCK! call a coder or something";
  }
};

export const ERTManager = (props) => {
  const { act, data } = useBackend();

  const [tabIndex, setTabIndex] = useState(0);

  return (
    <Window width={360} height={505}>
      <Window.Content>
        <Stack fill vertical>
          <ERTOverview />
          <Stack.Item>
            <Tabs fluid>
              <Tabs.Tab
                key="SendERT"
                selected={tabIndex === 0}
                onClick={() => {
                  setTabIndex(0);
                }}
                icon="ambulance"
              >
                Send ERT
              </Tabs.Tab>
              <Tabs.Tab
                key="ReadERTRequests"
                selected={tabIndex === 1}
                onClick={() => {
                  setTabIndex(1);
                }}
                icon="book"
              >
                Read ERT Requests
              </Tabs.Tab>
              <Tabs.Tab
                key="DenyERT"
                selected={tabIndex === 2}
                onClick={() => {
                  setTabIndex(2);
                }}
                icon="times"
              >
                Deny ERT
              </Tabs.Tab>
            </Tabs>
          </Stack.Item>
          {PickTab(tabIndex)}
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const ERTOverview = (props) => {
  const { act, data } = useBackend();
  const { securityLevelColor, securityLevel, ertRequestAnswered } = data;

  return (
    <Stack.Item>
      <Section title="Overview">
        <LabeledList>
          <LabeledList.Item label="Current Alert" color={securityLevelColor}>
            {securityLevel}
          </LabeledList.Item>
          <LabeledList.Item label="ERT Request">
            <Button.Checkbox
              checked={ertRequestAnswered}
              textColor={ertRequestAnswered ? null : 'bad'}
              content={ertRequestAnswered ? 'Answered' : 'Unanswered'}
              onClick={() => act('toggleErtRequestAnswered')}
              tooltip={
                'Checking this box will disable the next ERT reminder notification'
              }
              selected={null}
            />
          </LabeledList.Item>
        </LabeledList>
      </Section>
    </Stack.Item>
  );
};

const SendERT = (props) => {
  const { act, data } = useBackend();
  const { ertType } = data;
  let slotOptions = [0, 1, 2, 3, 4, 5];

  return (
    <Stack.Item grow>
      <Section
        fill
        scrollable
        title="Send ERT"
        buttons={
          <>
            <Button
              width={5}
              content="Amber"
              textAlign="center"
              color={ertType === 'Amber' ? 'orange' : ''}
              onClick={() => act('ertType', { ertType: 'Amber' })}
            />
            <Button
              width={5}
              content="Red"
              textAlign="center"
              color={ertType === 'Red' ? 'red' : ''}
              onClick={() => act('ertType', { ertType: 'Red' })}
            />
            <Button
              width={5}
              content="Gamma"
              textAlign="center"
              color={ertType === 'Gamma' ? 'orange' : ''}
              onClick={() => act('ertType', { ertType: 'Gamma' })}
            />
          </>
        }
      >
        <LabeledList>
          <LabeledList.Item label="Commander">
            <Button
              icon={commanderSlots ? 'toggle-on' : 'toggle-off'}
              selected={commanderSlots}
              content={commanderSlots ? 'Yes' : 'No'}
              onClick={() => act('toggleCom')}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Security">
            {slotOptions.map((a, i) => (
              <Button
                key={'securitySlots' + a}
                selected={securitySlots === a}
                content={a}
                onClick={() =>
                  act('setSec', {
                    setSec: a,
                  })
                }
              />
            ))}
          </LabeledList.Item>
          <LabeledList.Item label="Medical">
            {slotOptions.map((a, i) => (
              <Button
                key={'medicalSlots' + a}
                selected={medicalSlots === a}
                content={a}
                onClick={() =>
                  act('setMed', {
                    setMed: a,
                  })
                }
              />
            ))}
          </LabeledList.Item>
          <LabeledList.Item label="Engineering">
            {slotOptions.map((a, i) => (
              <Button
                key={'engineeringSlots' + a}
                selected={engineeringSlots === a}
                content={a}
                onClick={() =>
                  act('setEng', {
                    setEng: a,
                  })
                }
              />
            ))}
          </LabeledList.Item>
          <LabeledList.Item label="Paranormal">
            {slotOptions.map((a, i) => (
              <Button
                key={'paranormalSlots' + a}
                selected={paranormalSlots === a}
                content={a}
                onClick={() =>
                  act('setPar', {
                    set_par: a,
                  })
                }
              />
            ))}
          </LabeledList.Item>
          <LabeledList.Item label="Janitor">
            {slotOptions.map((a, i) => (
              <Button
                key={'janitorSlots' + a}
                selected={janitorSlots === a}
                content={a}
                onClick={() =>
                  act('setJan', {
                    setJan: a,
                  })
                }
              />
            ))}
          </LabeledList.Item>
          <LabeledList.Item label="totalSlots Slots">
            <Box color={totalSlots > ertSpawnpoints ? 'red' : 'green'}>
              {totalSlots} totalSlots, versus {ertSpawnpoints} ertSpawnpoints
            </Box>
          </LabeledList.Item>
          <LabeledList.Item label="Dispatch">
            <Button
              width={10.5}
              textAlign="center"
              icon="ambulance"
              content="Send ERT"
              onClick={() => act('dispatchErt')}
            />
          </LabeledList.Item>
        </LabeledList>
      </Section>
    </Stack.Item>
  );
};

const ReadERTRequests = (props) => {
  const { act, data } = useBackend();

  const { ertRequestMessages } = data;

  return (
    <Stack.Item grow>
      <Section fill>
        {ertRequestMessages && ertRequestMessages.length ? (
          ertRequestMessages.map((request) => (
            <Section
              key={decodeHtmlEntities(request.time)}
              title={request.time}
              buttons={
                <Button
                  content={request.sender_real_name}
                  onClick={() =>
                    act('view_player_panel', { uid: request.sender_uid })
                  }
                  tooltip="View player panel"
                />
              }
            >
              {request.message}
            </Section>
          ))
        ) : (
          <Stack fill>
            <Stack.Item
              bold
              grow
              textAlign="center"
              align="center"
              color="average"
            >
              <Icon.Stack>
                <Icon name="broadcast-tower" size={5} color="gray" />
                <Icon name="slash" size={5} color="red" />
              </Icon.Stack>
              <br />
              No ERT requests.
            </Stack.Item>
          </Stack>
        )}
      </Section>
    </Stack.Item>
  );
};

const DenyERT = (props) => {
  const { act, data } = useBackend();

  const [text, setText] = useState('');

  return (
    <Stack.Item grow>
      <Section fill>
        <Input
          placeholder="Enter ERT denial reason here,\nMultiline input is accepted."
          fluid
          value={text}
          onChange={(e, value) => setText(value)}
        />
        <Button.Confirm
          content="Deny ERT"
          fluid
          icon="times"
          mt={2}
          textAlign="center"
          onClick={() => act('denyErt', { reason: text })}
        />
      </Section>
    </Stack.Item>
  );
};
