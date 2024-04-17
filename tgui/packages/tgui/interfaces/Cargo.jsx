import { filter, sortBy } from 'common/collections';
import { flow } from 'common/fp';

import { useBackend, useSharedState } from '../backend';
import {
  AnimatedNumber,
  Box,
  Button,
  Flex,
  Icon,
  Input,
  LabeledList,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
  Table,
  Tabs,
} from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';

export const Cargo = (props) => {
  return (
    <Window width={800} height={750}>
      <Window.Content scrollable>
        <CargoContent />
      </Window.Content>
    </Window>
  );
};

export const CargoContent = (props) => {
  const { data } = useBackend();
  const [tab, setTab] = useSharedState('tab', 'catalog');
  const { cart = [], requests = [], requestonly } = data;
  const cart_length = cart.reduce((total, entry) => total + entry.amount, 0);

  return (
    <Box>
      <CargoStatus />
      <Section fitted>
        <Tabs>
          <Tabs.Tab
            icon="list"
            selected={tab === 'catalog'}
            onClick={() => setTab('catalog')}
          >
            Каталог
          </Tabs.Tab>
          <Tabs.Tab
            icon="envelope"
            textColor={tab !== 'requests' && requests.length > 0 && 'yellow'}
            selected={tab === 'requests'}
            onClick={() => setTab('requests')}
          >
            Запросы ({requests.length})
          </Tabs.Tab>
          {!requestonly && (
            <>
              <Tabs.Tab
                icon="shopping-cart"
                textColor={tab !== 'cart' && cart_length > 0 && 'yellow'}
                selected={tab === 'cart'}
                onClick={() => setTab('cart')}
              >
                Расчёт ({cart_length})
              </Tabs.Tab>
              <Tabs.Tab
                icon="question"
                selected={tab === 'help'}
                onClick={() => setTab('help')}
              >
                Помощь
              </Tabs.Tab>
            </>
          )}
        </Tabs>
      </Section>
      {tab === 'catalog' && <CargoCatalog />}
      {tab === 'requests' && <CargoRequests />}
      {tab === 'cart' && <CargoCart />}
      {tab === 'help' && <CargoHelp />}
    </Box>
  );
};

const CargoStatus = (props) => {
  const { act, data } = useBackend();
  const {
    department,
    grocery,
    away,
    docked,
    loan,
    loan_dispatched,
    location,
    message,
    points,
    requestonly,
    can_send,
  } = data;

  return (
    <Section
      title={department}
      buttons={
        <Box inline bold>
          <AnimatedNumber
            value={points}
            format={(value) => formatMoney(value)}
          />
          {' кредитов'}
        </Box>
      }
    >
      <LabeledList>
        <LabeledList.Item label="Шаттл">
          {(docked && !requestonly && can_send && (
            <Button
              color={(grocery && 'orange') || 'green'}
              content={location}
              tooltip={
                (grocery &&
                  'Кухня ожидает доставки продуктов!') ||
                ''
              }
              tooltipPosition="right"
              onClick={() => act('send')}
            />
          )) ||
            location}
        </LabeledList.Item>
        <LabeledList.Item label="Сообщение от Центрального Командования">{message}</LabeledList.Item>
        {!!loan && !requestonly && (
          <LabeledList.Item label="Займ">
            {(!loan_dispatched && (
              <Button
                content="Отдать шаттл в займ"
                disabled={!(away && docked)}
                onClick={() => act('loan')}
              />
            )) || <Box color="bad">Отдан в займ Центральному Командованию</Box>}
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};

/**
 * Take entire supplies tree
 * and return a flat supply pack list that matches search,
 * sorted by name and only the first page.
 * @param {any[]} supplies Supplies list.
 * @param {string} search The search term
 * @returns {any[]} The flat list of supply packs.
 */
const searchForSupplies = (supplies, search) => {
  search = search.toLowerCase();

  return flow([
    (categories) => categories.flatMap((category) => category.packs),
    filter(
      (pack) =>
        pack.name?.toLowerCase().includes(search.toLowerCase()) ||
        pack.desc?.toLowerCase().includes(search.toLowerCase()),
    ),
    sortBy((pack) => pack.name),
    (packs) => packs.slice(0, 25),
  ])(supplies);
};

export const CargoCatalog = (props) => {
  const { express } = props;
  const { act, data } = useBackend();

  const { self_paid, app_cost } = data;

  const supplies = Object.values(data.supplies);
  const { amount_by_name = [], max_order } = data;

  const [activeSupplyName, setActiveSupplyName] = useSharedState(
    'supply',
    supplies[0]?.name,
  );

  const [searchText, setSearchText] = useSharedState('search_text', '');

  const activeSupply =
    activeSupplyName === 'search_results'
      ? { packs: searchForSupplies(supplies, searchText) }
      : supplies.find((supply) => supply.name === activeSupplyName);

  return (
    <Section
      title="Каталог"
      buttons={
        !express && (
          <>
            <CargoCartButtons />
            <Button.Checkbox
              ml={2}
              content="Купить приватно"
              checked={self_paid}
              onClick={() => act('toggleprivate')}
            />
          </>
        )
      }
    >
      <Flex>
        <Flex.Item ml={-1} mr={1}>
          <Tabs vertical>
            <Tabs.Tab
              key="search_results"
              selected={activeSupplyName === 'search_results'}
            >
              <Stack align="baseline">
                <Stack.Item>
                  <Icon name="search" />
                </Stack.Item>
                <Stack.Item grow>
                  <Input
                    fluid
                    placeholder="Поиск..."
                    value={searchText}
                    onInput={(e, value) => {
                      if (value === searchText) {
                        return;
                      }

                      if (value.length) {
                        // Start showing results
                        setActiveSupplyName('search_results');
                      } else if (activeSupplyName === 'search_results') {
                        // return to normal category
                        setActiveSupplyName(supplies[0]?.name);
                      }
                      setSearchText(value);
                    }}
                  />
                </Stack.Item>
              </Stack>
            </Tabs.Tab>
            {supplies.map((supply) => (
              <Tabs.Tab
                key={supply.name}
                selected={supply.name === activeSupplyName}
                onClick={() => {
                  setActiveSupplyName(supply.name);
                  setSearchText('');
                }}
              >
                {supply.name} ({supply.packs.length})
              </Tabs.Tab>
            ))}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1} basis={0}>
          <Table>
            {activeSupply?.packs.map((pack) => {
              const tags = [];
              if (pack.small_item) {
                tags.push('Small');
              }
              if (pack.access) {
                tags.push('Restricted');
              }
              return (
                <Table.Row key={pack.name} className="candystripe">
                  <Table.Cell>{pack.name}</Table.Cell>
                  <Table.Cell collapsing color="label" textAlign="right">
                    {tags.join(', ')}
                  </Table.Cell>
                  <Table.Cell collapsing textAlign="right">
                    <Button
                      fluid
                      tooltip={pack.desc}
                      tooltipPosition="left"
                      disabled={(amount_by_name[pack.name] || 0) >= max_order}
                      onClick={() =>
                        act('add', {
                          id: pack.id,
                        })
                      }
                    >
                      {formatMoney(
                        (self_paid && !pack.goody) || app_cost
                          ? Math.round(pack.cost * 1.1)
                          : pack.cost,
                      )}
                      {' cr'}
                    </Button>
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const CargoRequests = (props) => {
  const { act, data } = useBackend();
  const { requestonly, can_send, can_approve_requests } = data;
  const requests = data.requests || [];
  // Labeled list reimplementation to squeeze extra columns out of it
  return (
    <Section
      title="Активные запросы"
      buttons={
        !requestonly && (
          <Button
            icon="times"
            content="Очистить"
            color="transparent"
            onClick={() => act('denyall')}
          />
        )
      }
    >
      {requests.length === 0 && <Box color="good">Нет запросов</Box>}
      {requests.length > 0 && (
        <Table>
          {requests.map((request) => (
            <Table.Row key={request.id} className="candystripe">
              <Table.Cell collapsing color="label">
                #{request.id}
              </Table.Cell>
              <Table.Cell>{request.object}</Table.Cell>
              <Table.Cell>
                <b>{request.orderer}</b>
              </Table.Cell>
              <Table.Cell width="25%">
                <i>{request.reason}</i>
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                {formatMoney(request.cost)} cr
              </Table.Cell>
              {(!requestonly || can_send) && can_approve_requests && (
                <Table.Cell collapsing>
                  <Button
                    icon="check"
                    color="good"
                    onClick={() =>
                      act('approve', {
                        id: request.id,
                      })
                    }
                  />
                  <Button
                    icon="times"
                    color="bad"
                    onClick={() =>
                      act('deny', {
                        id: request.id,
                      })
                    }
                  />
                </Table.Cell>
              )}
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
};

const CargoCartButtons = (props) => {
  const { act, data } = useBackend();
  const { requestonly, can_send, can_approve_requests } = data;
  const cart = data.cart || [];
  const total = cart.reduce((total, entry) => total + entry.cost, 0);
  return (
    <>
      <Box inline mx={1}>
        {cart.length === 0 && 'Корзина пуста'}
        {cart.length === 1 && '1 предмет'}
        {cart.length >= 2 && cart.length + ' предметов'}{' '}
        {total > 0 && `(${formatMoney(total)} cr)`}
      </Box>
      {!requestonly && !!can_send && !!can_approve_requests && (
        <Button
          icon="times"
          color="transparent"
          content="Очистить"
          onClick={() => act('clear')}
        />
      )}
    </>
  );
};

const CartHeader = (props) => {
  const { data } = useBackend();
  return (
    <Section>
      <Stack>
        <Stack.Item mt="4px">Текущая корзина</Stack.Item>
        <Stack.Item ml="200px" mt="3px">
          Количество
        </Stack.Item>
        <Stack.Item ml="72px">
          <CargoCartButtons />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const CargoCart = (props) => {
  const { act, data } = useBackend();
  const {
    requestonly,
    away,
    docked,
    location,
    can_send,
    amount_by_name,
    max_order,
  } = data;
  const cart = data.cart || [];
  return (
    <Section fill>
      <CartHeader />
      {cart.length === 0 && <Box color="label">Корзина пуста</Box>}
      {cart.length > 0 && (
        <Table>
          {cart.map((entry) => (
            <Table.Row key={entry.id} className="candystripe">
              <Table.Cell collapsing color="label" inline width="210px">
                #{entry.id}&nbsp;{entry.object}
              </Table.Cell>
              <Table.Cell inline ml="65px" width="40px">
                {(can_send && entry.can_be_cancelled && (
                  <RestrictedInput
                    width="40px"
                    minValue={0}
                    maxValue={max_order}
                    value={entry.amount}
                    onEnter={(e, value) =>
                      act('modify', {
                        order_name: entry.object,
                        amount: value,
                      })
                    }
                  />
                )) || <Input width="40px" value={entry.amount} disabled />}
              </Table.Cell>
              <Table.Cell inline ml="5px" width="10px">
                {!!can_send && !!entry.can_be_cancelled && (
                  <Button
                    icon="plus"
                    disabled={amount_by_name[entry.object] >= max_order}
                    onClick={() =>
                      act('add_by_name', { order_name: entry.object })
                    }
                  />
                )}
              </Table.Cell>
              <Table.Cell inline ml="15px" width="10px">
                {!!can_send && !!entry.can_be_cancelled && (
                  <Button
                    icon="minus"
                    onClick={() => act('remove', { order_name: entry.object })}
                  />
                )}
              </Table.Cell>
              <Table.Cell collapsing textAlign="right" inline ml="50px">
                {entry.paid > 0 && <b>[Оплачено приватно x {entry.paid}]</b>}
                {formatMoney(entry.cost)} {entry.cost_type}
                {entry.dep_order > 0 && <b>[Департамент x {entry.dep_order}]</b>}
              </Table.Cell>
              <Table.Cell inline mt="20px" />
            </Table.Row>
          ))}
        </Table>
      )}
      {cart.length > 0 && !requestonly && (
        <Box mt={2}>
          {(away === 1 && docked === 1 && (
            <Button
              color="green"
              style={{
                lineHeight: '28px',
                padding: '0 12px',
              }}
              content="Подтвердить заказ"
              onClick={() => act('send')}
            />
          )) || <Box opacity={0.5}>Шаттл находится в {location}.</Box>}
        </Box>
      )}
    </Section>
  );
};

const CargoHelp = (props) => {
  return (
    <>
      <Section title="Заказы департаментов">
        Каждый Департамент на станции может заказать ящики с их собственных
        консолей. Эти заказы абсолютно БЕСПЛАТНЫ! Они не оплачиваются через 
        бюджет карго, и также уводят консоли на перезарядку. Всё 
        это работает следующим образом: Заказанные ящики появятся на вашей
        консоли поставок, и вам нужно будет доставить ящики заказчикам.
        Вы даже получите полную стоимость ящика при
        доставке, если ящик не был поддельным, что делает эту систему хорошим
        источником доходов.
        <br />
        <b>
          Осмотрите ящик, чтобы узнать детали о том
          куда ящик должен быть доставлен.
        </b>
      </Section>
      <Section title="MULEботы">
        MULEботы - медленные, но лояльные роботы доставщики, что доставят все ящики
        с минимальным вмешательством техника. Это медленно, однако, в операцию могут 
        вмешаться во время пути.
        <br />
        <b>Настроить MULEбота довольно просто:</b>
        <br />
        <b>1.</b> Поставьте ящик, что вы хотите доставить рядом с МУЛботом.
        <br />
        <b>2.</b> Перетащите ящик на верх МУЛбота. Он должен погрузиться.
        <br />
        <b>3.</b> Включите ваш КПК.
        <br />
        <b>4.</b> Нажмите на <i>Delivery Bot Control</i>.<br />
        <b>5.</b> Нажмите на <i>Scan for Active Bots</i>.<br />
        <b>6.</b> Выберите своего MULEбота.
        <br />
        <b>7.</b> Нажмите на <i>Destination: (set)</i>.<br />
        <b>8.</b> Выберите пункт назначения и нажмите ОК.
        <br />
        <b>9.</b> Нажмите на <i>Proceed</i>.
      </Section>
      <Section title="Disposals Delivery System">
        In addition to MULEs and hand-deliveries, you can also make use of the
        disposals mailing system. Note that a break in the disposal piping could
        cause your package to be lost (this hardly ever happens), so this is not
        always the most secure ways to deliver something. You can wrap up a
        piece of paper and mail it the same way if you (or someone at the desk)
        wants to mail a letter.
        <br />
        <b>Using the Disposals Delivery System is even easier:</b>
        <br />
        <b>1.</b> Wrap your item/crate in packaging paper.
        <br />
        <b>2.</b> Use the destinations tagger to choose where to send it.
        <br />
        <b>3.</b> Tag the package.
        <br />
        <b>4.</b> Stick it on the conveyor and let the system handle it.
        <br />
      </Section>
      <NoticeBox textAlign="center" info mb={0}>
        Pondering something not included here? When in doubt, ask the QM!
      </NoticeBox>
    </>
  );
};
