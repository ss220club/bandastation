import { useBackend } from '../backend';
import {
  Box,
  Button,
  Flex,
  LabeledList,
  NoticeBox,
  Section,
} from '../components';
import { Window } from '../layouts';

export const CivCargoHoldTerminal = (props) => {
  const { act, data } = useBackend();
  const { pad, sending, status_report, id_inserted, id_bounty_info, picking } =
    data;
  const in_text = 'Приветствуем, многоуважаемый сотрудник.';
  const out_text = 'Чтобы начать, вставьте ID карту в консоль.';
  return (
    <Window width={580} height={375}>
      <Window.Content scrollable>
        <Flex>
          <Flex.Item>
            <NoticeBox color={!id_inserted ? 'default' : 'blue'}>
              {id_inserted ? in_text : out_text}
            </NoticeBox>
            <Section
              title="Платформа снабжения"
              buttons={
                <>
                  <Button
                    icon={'sync'}
                    tooltip={'Проверить содержимое'}
                    disabled={!pad || !id_inserted}
                    onClick={() => act('recalc')}
                  />
                  <Button
                    icon={sending ? 'times' : 'arrow-up'}
                    tooltip={sending ? 'Остановить отправку' : 'Отправить товары'}
                    selected={sending}
                    disabled={!pad || !id_inserted}
                    onClick={() => act(sending ? 'stop' : 'send')}
                  />
                  <Button
                    icon={id_bounty_info ? 'recycle' : 'pen'}
                    color={id_bounty_info ? 'green' : 'default'}
                    tooltip={id_bounty_info ? 'Заменить заказ' : 'Новый заказ'}
                    disabled={!id_inserted}
                    onClick={() => act('bounty')}
                  />
                  <Button
                    icon={'download'}
                    content={'Извлечь ID карту'}
                    disabled={!id_inserted}
                    onClick={() => act('eject')}
                  />
                </>
              }
            >
              <LabeledList>
                <LabeledList.Item label="Статус" color={pad ? 'good' : 'bad'}>
                  {pad ? 'Функционирует' : 'Не обнаружен'}
                </LabeledList.Item>
                <LabeledList.Item label="Грузовой отчёт">
                  {status_report}
                </LabeledList.Item>
              </LabeledList>
            </Section>
            {picking ? <BountyPickBox /> : <BountyTextBox />}
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

const BountyTextBox = (props) => {
  const { data } = useBackend();
  const { id_bounty_info, id_bounty_value, id_bounty_num } = data;
  const na_text = 'N/A, пожалуйста добавьте новый заказ.';
  return (
    <Section title="Информация о заказе">
      <LabeledList>
        <LabeledList.Item label="Описание">
          {id_bounty_info ? id_bounty_info : na_text}
        </LabeledList.Item>
        <LabeledList.Item label="Количество">
          {id_bounty_info ? id_bounty_num : 'N/A'}
        </LabeledList.Item>
        <LabeledList.Item label="Стоимость">
          {id_bounty_info ? id_bounty_value : 'N/A'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const BountyPickBox = (props) => {
  const { act, data } = useBackend();
  const { id_bounty_names, id_bounty_values } = data;
  return (
    <Section title="Пожалуйста выберите заказ:" textAlign="center">
      <Flex width="100%" wrap>
        <Flex.Item shrink={0} grow={0.5}>
          <Button
            fluid
            color="green"
            content={id_bounty_names[0]}
            onClick={() => act('pick', { value: 1 })}
          >
            <Box fontSize="14px">Оплата: {id_bounty_values[0]} cr</Box>
          </Button>
        </Flex.Item>
        <Flex.Item shrink={0} grow={0.5} px={1}>
          <Button
            fluid
            color="green"
            content={id_bounty_names[1]}
            onClick={() => act('pick', { value: 2 })}
          >
            <Box fontSize="14px">Оплата: {id_bounty_values[1]} cr</Box>
          </Button>
        </Flex.Item>
        <Flex.Item shrink={0} grow={0.5}>
          <Button
            fluid
            color="green"
            content={id_bounty_names[2]}
            onClick={() => act('pick', { value: 3 })}
          >
            <Box fontSize="14px">Оплата: {id_bounty_values[2]} cr</Box>
          </Button>
        </Flex.Item>
      </Flex>
    </Section>
  );
};
