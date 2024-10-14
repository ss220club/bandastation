import { useState } from 'react';
import { Button, Input, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const RuNamesSuggestPanel = (props) => {
  const { act, data } = useBackend();
  const suggested_list = data.suggested_list || [];
  const visible_name = data.visible_name;
  const [nominative, setNominative] = useState('');
  const [genitive, setGenitive] = useState('');
  const [dative, setDative] = useState('');
  const [accusative, setAccusative] = useState('');
  const [instrumental, setInstrumental] = useState('');
  const [prepositional, setPrepositional] = useState('');
  return (
    <Window theme="admin" title="Предложение перевода" width={400} height={250}>
      <Window.Content />
      <Section title={'Оригинал: ' + visible_name}>
        <LabeledList>
          <LabeledList.Item label="Именительный падеж">
            <Input
              width="225px"
              onChange={(e, value) => setNominative(value)}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Родительный падеж">
            <Input width="225px" onChange={(e, value) => setGenitive(value)} />
          </LabeledList.Item>
          <LabeledList.Item label="Дательный падеж">
            <Input width="225px" onChange={(e, value) => setDative(value)} />
          </LabeledList.Item>
          <LabeledList.Item label="Винительный падеж">
            <Input
              width="225px"
              onChange={(e, value) => setAccusative(value)}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Творительный падеж">
            <Input
              width="225px"
              onChange={(e, value) => setInstrumental(value)}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Предложный падеж">
            <Input
              width="225px"
              onChange={(e, value) => setPrepositional(value)}
            />
          </LabeledList.Item>
          <LabeledList.Item>
            <Button.Confirm
              confirmColor="green"
              confirmContent="Вы уверены?"
              disabled={
                !nominative ||
                !genitive ||
                !dative ||
                !accusative ||
                !instrumental ||
                !prepositional
              }
              onClick={() =>
                act('send', {
                  entries: [
                    nominative,
                    genitive,
                    dative,
                    accusative,
                    instrumental,
                    prepositional,
                  ],
                })
              }
            >
              Отправить
            </Button.Confirm>
          </LabeledList.Item>
        </LabeledList>
      </Section>
    </Window>
  );
};
