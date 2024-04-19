import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import {
  AnimatedNumber,
  Box,
  Button,
  Grid,
  LabeledList,
  ProgressBar,
  Section,
} from '../components';
import { NtosWindow } from '../layouts';

export const NtosArcade = (props) => {
  const { act, data } = useBackend();
  return (
    <NtosWindow width={450} height={350}>
      <NtosWindow.Content>
        <Section title="Outbomb Cuban Pete Ultra" textAlign="center">
          <Box>
            <Grid>
              <Grid.Column size={2}>
                <Box m={1} />
                <LabeledList>
                  <LabeledList.Item label="Здоровье">
                    <ProgressBar
                      value={data.PlayerHitpoints}
                      minValue={0}
                      maxValue={30}
                      ranges={{
                        olive: [31, Infinity],
                        good: [20, 31],
                        average: [10, 20],
                        bad: [-Infinity, 10],
                      }}
                    >
                      {data.PlayerHitpoints}HP
                    </ProgressBar>
                  </LabeledList.Item>
                  <LabeledList.Item label="Магия">
                    <ProgressBar
                      value={data.PlayerMP}
                      minValue={0}
                      maxValue={10}
                      ranges={{
                        purple: [11, Infinity],
                        violet: [3, 11],
                        bad: [-Infinity, 3],
                      }}
                    >
                      {data.PlayerMP}MP
                    </ProgressBar>
                  </LabeledList.Item>
                </LabeledList>
                <Box my={1} mx={4} />
                <Section
                  backgroundColor={
                    data.PauseState === 1 ? '#1b3622' : '#471915'
                  }
                >
                  {data.Status}
                </Section>
              </Grid.Column>
              <Grid.Column>
                <ProgressBar
                  value={data.Hitpoints}
                  minValue={0}
                  maxValue={45}
                  ranges={{
                    good: [30, Infinity],
                    average: [5, 30],
                    bad: [-Infinity, 5],
                  }}
                >
                  <AnimatedNumber value={data.Hitpoints} />
                  HP
                </ProgressBar>
                <Box m={1} />
                <Section inline width="156px" textAlign="center">
                  <img src={resolveAsset(data.BossID)} />
                </Section>
              </Grid.Column>
            </Grid>
            <Box my={1} mx={4} />
            <Button
              icon="fist-raised"
              tooltip="Убей их черт подери!"
              tooltipPosition="top"
              disabled={data.GameActive === 0 || data.PauseState === 1}
              onClick={() => act('Attack')}
              content="Атаковать!"
            />
            <Button
              icon="band-aid"
              tooltip="Вылечи себя!"
              tooltipPosition="top"
              disabled={data.GameActive === 0 || data.PauseState === 1}
              onClick={() => act('Heal')}
              content="Лечение!"
            />
            <Button
              icon="magic"
              tooltip="Заряди свою магию!"
              tooltipPosition="top"
              disabled={data.GameActive === 0 || data.PauseState === 1}
              onClick={() => act('Recharge_Power')}
              content="Зарядка!"
            />
          </Box>
          <Box>
            <Button
              icon="sync-alt"
              tooltip="Еще одна игра не повредит."
              tooltipPosition="top"
              disabled={data.GameActive === 1}
              onClick={() => act('Start_Game')}
              content="Начать игру"
            />
            <Button
              icon="ticket-alt"
              tooltip="Получите призы в ближайшей компьютерной аркаде!"
              tooltipPosition="top"
              disabled={data.GameActive === 1}
              onClick={() => act('Dispense_Tickets')}
              content="Забрать тикеты"
            />
          </Box>
          <Box color={data.TicketCount >= 1 ? 'good' : 'normal'}>
            Заработанные билеты: {data.TicketCount}
          </Box>
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
