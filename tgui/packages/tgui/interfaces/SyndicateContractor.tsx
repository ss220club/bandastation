import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Flex,
  Grid,
  Icon,
  LabeledList,
  Modal,
  NoticeBox,
  Section,
} from '../components';
import { FakeTerminal } from '../components/FakeTerminal';
import { NtosWindow } from '../layouts';

const CONTRACT_STATUS_INACTIVE = 1;
const CONTRACT_STATUS_ACTIVE = 2;
const CONTRACT_STATUS_BOUNTY_CONSOLE_ACTIVE = 3;
const CONTRACT_STATUS_EXTRACTING = 4;
const CONTRACT_STATUS_COMPLETE = 5;
const CONTRACT_STATUS_ABORTED = 6;

export const SyndicateContractor = (props) => {
  return (
    <NtosWindow width={500} height={600}>
      <NtosWindow.Content scrollable>
        <SyndicateContractorContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

type Data = {
  contracts_completed: number;
  contracts: ContractData[];
  dropoff_direction: string;
  earned_tc: number;
  error: string;
  extraction_enroute: BooleanLike;
  first_load: BooleanLike;
  info_screen: BooleanLike;
  logged_in: BooleanLike;
  ongoing_contract: BooleanLike;
  redeemable_tc: number;
};

type ContractData = {
  contract: string;
  dropoff: string;
  extraction_enroute: BooleanLike;
  id: number;
  message: string;
  payout_bonus: number;
  payout: number;
  status: number;
  target_rank: string;
  target: string;
};

export const SyndicateContractorContent = (props) => {
  const { data, act } = useBackend<Data>();
  const { error, logged_in, first_load, info_screen } = data;

  const terminalMessages = [
    'Запись биометрических данных...',
    'Анализ встроенной информации о синдикате...',
    'СТАТУС ПОДТВЕРЖДЕН',
    'Обращение к базе данных синдиката...',
    'Ожидание ответа...',
    'Ожидание ответа...',
    'Ожидание ответа...',
    'Ожидание ответа...',
    'Ожидание ответа...',
    'Ожидание ответа...',
    'Ответ получен, аккаунт 4851234...',
    'ПОДТВЕРДИТЬ АККАУНТ ' + Math.round(Math.random() * 20000),
    'Настройка личных аккаунтов...',
    'АККАУНТ КОНТРАТНИКА СОЗДАН',
    'Поиск доступных контрактов...',
    'Поиск доступных контрактов...',
    'Поиск доступных контрактов...',
    'Поиск доступных контрактов...',
    'КОНТРАКТЫ НАЙДЕНЫ',
    'ДОБРО ПОЖАЛОВАТЬ, АГЕНТ',
  ];

  const infoEntries = [
    'SyndTract v2.0',
    '',
    "Мы определили потенциально ценные цели, которые",
    'в настоящее время находятся в районе вашей миссии. Они могут',
    'хранить ценную информацию, которая может иметь важное',
    'значение для нашей организации.',
    '',
    'Ниже перечислены все доступные вам контракты. Вы',
    'должны довести заданную цель до назначенной',
    'зоны отправки, и связаться с нами через аплинк. Мы отправим',
    'специализированную капсулу для транспортировки, куда нужно поместить тело.',
    '',
    'Мы хотим, чтобы цели были живыми, мы платим меньшие',
    "суммы если цель будет мертва, вы просто не получите показанный",
    'бонус. Вы можете получить свою оплату через этот аплинк в',
    'форме телекристаллов, которые могут быть вложены в',
    'обычный аплинк Синдиката чтобы приобрести необходимое вам снаряжение.',
    'Мы предоставим вам эти кристаллы в тот момент, когда вы отправите',
    'цель к нам, телекристаллы можно получить в любое время через',
    'эту систему.',
    '',
    'Похищенные цели будут выкуплены обратно на станцию после того',
    'как их знания будут извлечены, мы предоставим вам',
    'часть выкупа. Вам следует помнить что они могут',
    'идентифицировать вас, когда они вернутся. Мы предоставляем вам',
    'стандартное снаряжение контрактника, которое поможет скрыть вашу',
    'личность.',
  ];

  const errorPane = !!error && (
    <Modal backgroundColor="red">
      <Flex align="center">
        <Flex.Item mr={2}>
          <Icon size={4} name="exclamation-triangle" />
        </Flex.Item>
        <Flex.Item mr={2} grow={1} textAlign="center">
          <Box width="260px" textAlign="left" minHeight="80px">
            {error}
          </Box>
          <Button content="Dismiss" onClick={() => act('PRG_clear_error')} />
        </Flex.Item>
      </Flex>
    </Modal>
  );

  if (!logged_in) {
    return (
      <Section minHeight="525px">
        <Box width="100%" textAlign="center">
          <Button
            content="ЗАРЕГИСТРИРОВАННЫЙ ПОЛЬЗОВАТЕЛЬ"
            color="transparent"
            onClick={() => act('PRG_login')}
          />
        </Box>
        {!!error && <NoticeBox>{error}</NoticeBox>}
      </Section>
    );
  }

  if (logged_in && first_load) {
    return (
      <Box backgroundColor="rgba(0, 0, 0, 0.8)" minHeight="525px">
        <FakeTerminal
          allMessages={terminalMessages}
          finishedTimeout={3000}
          onFinished={() => act('PRG_set_first_load_finished')}
        />
      </Box>
    );
  }

  if (info_screen) {
    return (
      <>
        <Box backgroundColor="rgba(0, 0, 0, 0.8)" minHeight="500px">
          <FakeTerminal allMessages={infoEntries} linesPerSecond={10} />
        </Box>
        <Button
          fluid
          content="ПРОДОЛЖИТЬ"
          color="transparent"
          textAlign="center"
          onClick={() => act('PRG_toggle_info')}
        />
      </>
    );
  }

  return (
    <>
      {errorPane}
      <StatusPane state={props.state} />
      <ContractsTab />
    </>
  );
};

export const StatusPane = (props) => {
  const { act, data } = useBackend<Data>();
  const { redeemable_tc, earned_tc, contracts_completed } = data;

  return (
    <Section
      title={
        <>
          Contractor Status
          <Button
            content="Посмотреть информацию еще раз"
            color="transparent"
            mb={0}
            ml={1}
            onClick={() => act('PRG_toggle_info')}
          />
        </>
      }
    >
      <Grid>
        <Grid.Column size={0.85}>
          <LabeledList>
            <LabeledList.Item
              label="Доступные ТК"
              buttons={
                <Button
                  content="Claim"
                  disabled={redeemable_tc <= 0}
                  onClick={() => act('PRG_redeem_TC')}
                />
              }
            >
              {String(redeemable_tc)}
            </LabeledList.Item>
            <LabeledList.Item label="Заработанные ТК">
              {String(earned_tc)}
            </LabeledList.Item>
          </LabeledList>
        </Grid.Column>
        <Grid.Column>
          <LabeledList>
            <LabeledList.Item label="Выполненные контракты">
              {String(contracts_completed)}
            </LabeledList.Item>
            <LabeledList.Item label="Текущий статус">ACTIVE</LabeledList.Item>
          </LabeledList>
        </Grid.Column>
      </Grid>
    </Section>
  );
};

const ContractsTab = (props) => {
  const { act, data } = useBackend<Data>();
  const { contracts, ongoing_contract, extraction_enroute, dropoff_direction } =
    data;

  return (
    <>
      <Section
        title="Доступные контракты"
        buttons={
          <Button
            content="Вызвать траспортировочный под"
            disabled={!ongoing_contract || extraction_enroute}
            onClick={() => act('PRG_call_extraction')}
          />
        }
      >
        {contracts.map((contract) => {
          if (ongoing_contract && contract.status !== CONTRACT_STATUS_ACTIVE) {
            return;
          }
          const active = contract.status > CONTRACT_STATUS_INACTIVE;
          if (contract.status >= CONTRACT_STATUS_COMPLETE) {
            return;
          }
          return (
            <Section
              key={contract.target}
              title={
                contract.target
                  ? `${contract.target} (${contract.target_rank})`
                  : 'Неверная Цель'
              }
              buttons={
                <>
                  <Box inline bold mr={1}>
                    {`${contract.payout} (+${contract.payout_bonus}) ТК`}
                  </Box>
                  <Button
                    content={active ? 'Отменить' : 'Принять'}
                    disabled={contract.extraction_enroute}
                    color={active && 'bad'}
                    onClick={() =>
                      act('PRG_contract' + (active ? '_abort' : '-accept'), {
                        contract_id: contract.id,
                      })
                    }
                  />
                </>
              }
            >
              <Grid>
                <Grid.Column>{contract.message}</Grid.Column>
                <Grid.Column size={0.5}>
                  <Box bold mb={1}>
                    Dropoff Location:
                  </Box>
                  <Box>{contract.dropoff}</Box>
                </Grid.Column>
              </Grid>
            </Section>
          );
        })}
      </Section>
      <Section
        title="Локатор зоны отправки"
        textAlign="center"
        opacity={ongoing_contract ? 100 : 0}
      >
        <Box bold>{dropoff_direction}</Box>
      </Section>
    </>
  );
};
