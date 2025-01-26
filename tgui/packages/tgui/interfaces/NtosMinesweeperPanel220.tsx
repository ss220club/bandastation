import { Box, Button, Icon, Stack, Table } from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { NtosWindow } from '../layouts';

interface Bomb {
  open: number;
  bomb: number;
  flag: number;
  around: number;
}

type Matrix = Bomb[][];

type PlayerResult = {
  name: string;
  time: string;
  points: string;
  pointsPerSec: string;
  fieldParams: string;
};

type Leaderboard = PlayerResult[];

type FieldParams = {
  width: number;
  height: number;
  bombs: number;
};

type MinesweeperData = {
  matrix: Matrix;
  flags: number;
  bombs: number;
  leaderboard: Leaderboard;
  first_touch: boolean;
  field_params: FieldParams;
};

export const NtosMinesweeperPanel = (props) => {
  const { act, data } = useBackend<MinesweeperData>();
  const { field_params } = data;

  return (
    <NtosWindow
      width={34 * field_params.width + 100}
      height={30 * field_params.height + 100}
    >
      <NtosWindow.Content>
        <MinesweeperWindow />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const MinesweeperWindow = (props) => {
  const { act, data } = useBackend();

  const [currentWindow, setWindow] = useSharedState('window', 'Game');

  const AltWindow = {
    Game: 'Leaderboard',
    Leaderboard: 'Game',
  };

  return (
    <Stack fill vertical textAlign="center">
      <Stack.Item grow>
        {currentWindow === 'Game' ? (
          <MineSweeperGame />
        ) : (
          <MineSweeperLeaderboard />
        )}
      </Stack.Item>
      <Stack.Item>
        <Button
          fluid
          translucent
          fontSize={2}
          lineHeight={1.75}
          icon={currentWindow === 'Game' ? 'book' : 'gamepad'}
          onClick={() => setWindow(AltWindow[currentWindow])}
        >
          {AltWindow[currentWindow]}
        </Button>
      </Stack.Item>
    </Stack>
  );
};

export const MineSweeperGame = (props) => {
  const { act, data } = useBackend<MinesweeperData>();
  const { matrix, flags, bombs, first_touch } = data;

  const NumColor = {
    1: 'blue',
    2: 'green',
    3: 'red',
    4: 'darkblue',
    5: 'brown',
    6: 'lightblue',
    7: 'black',
    8: 'white',
  };

  const handleClick = (row, cell, mode) => {
    act('Square', {
      X: row,
      Y: cell,
      mode: mode,
    });
  };

  return (
    <Stack>
      <Stack.Item>
        {matrix.map((row, i) => (
          <Box key={i}>
            {matrix[i].map((cell, j) => (
              <Button
                key={j}
                m={0.25}
                height={2}
                width={2}
                className={
                  matrix[i][j].open
                    ? 'Minesweeper__open'
                    : 'Minesweeper__closed'
                }
                bold
                color="transparent"
                icon={
                  matrix[i][j].open
                    ? matrix[i][j].bomb
                      ? 'bomb'
                      : ''
                    : matrix[i][j].flag
                      ? 'flag'
                      : ''
                }
                textColor={
                  matrix[i][j].open
                    ? matrix[i][j].bomb
                      ? 'black'
                      : NumColor[matrix[i][j].around]
                    : matrix[i][j].flag
                      ? 'red'
                      : 'gray'
                }
                onClick={(e) => handleClick(i, j, 'bomb')}
                onContextMenu={(e) => {
                  e.preventDefault();
                  handleClick(i, j, 'flag');
                }}
              >
                {!!matrix[i][j].open &&
                !matrix[i][j].bomb &&
                matrix[i][j].around
                  ? matrix[i][j].around
                  : ' '}
              </Button>
            ))}
          </Box>
        ))}
      </Stack.Item>
      <Stack.Item grow className="Minesweeper__infobox">
        <Stack vertical textAlign="left" pt={1}>
          <Stack.Item pl={2} fontSize={2}>
            <Icon name="bomb" color="gray" /> : {bombs}
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item pl={2} fontSize={2}>
            <Icon name="flag" color="red" /> : {flags}
          </Stack.Item>
          <Stack.Item>
            <Button
              fluid
              textAlign="center"
              icon="cog"
              disabled={!first_touch}
              onClick={(e) => act('ChangeSize')}
            >
              Change field
            </Button>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

export const MineSweeperLeaderboard = (props) => {
  const { act, data } = useBackend<MinesweeperData>();
  const { leaderboard } = data;
  const [sortId, _setSortId] = useSharedState('sortId', 'time');
  const [sortOrder, _setSortOrder] = useSharedState('sortOrder', false);

  return (
    <Table className="Minesweeper__list">
      <Table.Row bold>
        <SortButton id="name">Nick</SortButton>
        <SortButton id="time">Time</SortButton>
        <SortButton id="points">3BV</SortButton>
        <SortButton id="pointsPerSec">3BV/s</SortButton>
        <SortButton id="fieldParams">Params</SortButton>
      </Table.Row>
      {leaderboard &&
        leaderboard
          .sort((a, b) => {
            const i = sortOrder ? 1 : -1;
            return a[sortId].localeCompare(b[sortId]) * i;
          })
          .map((player, i) => (
            <Table.Row key={i}>
              <Table.Cell>{player.name}</Table.Cell>
              <Table.Cell>{player.time}</Table.Cell>
              <Table.Cell>{player.points}</Table.Cell>
              <Table.Cell>{player.pointsPerSec}</Table.Cell>
              <Table.Cell>{player.fieldParams}</Table.Cell>
            </Table.Row>
          ))}
    </Table>
  );
};

const SortButton = (properties) => {
  const [sortId, setSortId] = useSharedState('sortId', 'time');
  const [sortOrder, setSortOrder] = useSharedState('sortOrder', false);
  const { id, children } = properties;
  return (
    <Table.Cell>
      <Button
        fluid
        color="transparent"
        onClick={() => {
          if (sortId === id) {
            setSortOrder(!sortOrder);
          } else {
            setSortId(id);
            setSortOrder(true);
          }
        }}
      >
        {children}
        {sortId === id && (
          <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml="0.25rem;" />
        )}
      </Button>
    </Table.Cell>
  );
};
