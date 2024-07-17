import React, { useState } from 'react';
import { sortBy } from 'common/collections';

import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import {
  Box,
  Button,
  Input,
  NumberInput,
  Knob,
  ProgressBar,
  Section,
  Stack,
  LabeledList,
  Dimmer,
  Icon,
} from '../components';
import { Window } from '../layouts';

type Song = {
  name: string;
  length: number;
  beat: number;
};

type Data = {
  admin: BooleanLike;
  active: BooleanLike;
  looping: BooleanLike;
  volume: number;
  startTime: number;
  endTime: number;
  worldTime: number;
  track_selected: string | null;
  songs: Song[];
};

export const Jukebox220 = () => {
  const { act, data } = useBackend<Data>();
  const [uploadTrack, setUploadTrack] = useState(false);
  const [trackName, setTrackName] = useState('');
  const [trackLength, setTrackLength] = useState(220);
  const [trackBeat, setTrackBeat] = useState(10);
  const {
    admin,
    active,
    looping,
    track_selected,
    volume,
    songs,
    startTime,
    endTime,
    worldTime,
  } = data;

  const MAX_NAME_LENGTH = 30;
  const songs_sorted: Song[] = sortBy(songs, (song: Song) => song.name);
  const song_selected: Song | undefined = songs.find(
    (song) => song.name === track_selected,
  );
  const totalTracks = songs_sorted.length;
  const selectedTrackNumber = song_selected
    ? songs_sorted.findIndex((song) => song.name === song_selected.name) + 1
    : 0;

  const formatTime = (deciseconds) => {
    const seconds = Math.floor(deciseconds / 10);
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    const formattedTime = `${minutes}:${remainingSeconds > 9 ? remainingSeconds : '0' + remainingSeconds}`;
    return formattedTime;
  };

  const trackTimer = (
    <Box textAlign="center">
      {active
        ? looping
          ? '∞'
          : formatTime(Math.round(worldTime - startTime))
        : looping
          ? '∞'
          : formatTime(song_selected?.length)}{' '}
      / {looping ? '∞' : formatTime(song_selected?.length)}
    </Box>
  );

  return (
    <Window
      width={350}
      height={uploadTrack ? 582 : 435}
      title="Музыкальный автомат"
    >
      <Window.Content>
        <Stack fill vertical>
          <Stack>
            <Stack.Item grow textAlign="center">
              <Section fill title="Проигрыватель">
                <Stack fill vertical>
                  {song_selected && (
                    <Stack.Item bold maxWidth="240px">
                      {song_selected.name.length > MAX_NAME_LENGTH ? (
                        <marquee>{song_selected.name}</marquee>
                      ) : (
                        song_selected.name
                      )}
                    </Stack.Item>
                  )}
                  <Stack fill mt={1.5}>
                    <Stack.Item grow basis="0">
                      <Button
                        fluid
                        icon={active ? 'pause' : 'play'}
                        color="transparent"
                        selected={active}
                        onClick={() => act('toggle')}
                      >
                        {active ? 'Стоп' : 'Старт'}
                      </Button>
                    </Stack.Item>
                    <Stack.Item grow basis="0">
                      <Button.Checkbox
                        fluid
                        icon={'undo'}
                        disabled={active}
                        checked={looping}
                        onClick={() => act('loop', { looping: !looping })}
                      >
                        Повтор
                      </Button.Checkbox>
                    </Stack.Item>
                    {!!admin && (
                      <Stack.Item>
                        <Button.Checkbox
                          icon={'download'}
                          tooltip="Загрузить новый трек"
                          checked={uploadTrack}
                          onClick={() => setUploadTrack(!uploadTrack)}
                        />
                      </Stack.Item>
                    )}
                  </Stack>
                  <Stack.Item>
                    <ProgressBar
                      minValue={startTime}
                      value={!looping ? worldTime : endTime}
                      maxValue={endTime}
                    >
                      {trackTimer}
                    </ProgressBar>
                  </Stack.Item>
                </Stack>
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Section fill>
                {active ? <OnMusic /> : null}
                <Stack mb={1.5}>
                  <Stack.Item grow m={0}>
                    <Button
                      color="transparent"
                      icon="fast-backward"
                      onClick={() =>
                        act('set_volume', {
                          volume: 'min',
                        })
                      }
                    />
                  </Stack.Item>
                  <Stack.Item m={0}>
                    <Button
                      color="transparent"
                      icon="undo"
                      onClick={() =>
                        act('set_volume', {
                          volume: 'reset',
                        })
                      }
                    />
                  </Stack.Item>
                  <Stack.Item grow m={0} textAlign="right">
                    <Button
                      color="transparent"
                      icon="fast-forward"
                      onClick={() =>
                        act('set_volume', {
                          volume: 'max',
                        })
                      }
                    />
                  </Stack.Item>
                </Stack>
                <Stack.Item pr={1} pl={1} textAlign="center" textColor="label">
                  <Knob
                    size={1.75}
                    value={volume}
                    unit="%"
                    minValue={0}
                    maxValue={50}
                    step={1}
                    stepPixelSize={5}
                    onDrag={(e, value) =>
                      act('set_volume', {
                        volume: value,
                      })
                    }
                  />
                  <Box mt={0.75}>Громкость</Box>
                </Stack.Item>
              </Section>
            </Stack.Item>
          </Stack>
          <Stack.Item grow textAlign="center">
            <Section
              fill
              scrollable
              title="Доступные треки"
              buttons={
                <Button
                  bold
                  icon="random"
                  color="transparent"
                  tooltip="Выбрать случайный трек"
                  tooltipPosition="top-end"
                  onClick={() => {
                    const randomIndex = Math.floor(Math.random() * totalTracks);
                    const randomTrack = songs_sorted[randomIndex];
                    act('select_track', { track: randomTrack.name });
                  }}
                >
                  {selectedTrackNumber}/{totalTracks}
                </Button>
              }
            >
              {songs_sorted.map((song) => {
                const selectedTrack = song_selected?.name === song.name;
                return (
                  <Stack.Item key={song.name} mb={0.5} textAlign="left">
                    <Button
                      fluid
                      selected={selectedTrack}
                      color="transparent"
                      onClick={() => {
                        !active && act('select_track', { track: song.name });
                      }}
                      style={{
                        backgroundColor:
                          active && !selectedTrack
                            ? `rgba(255, 0, 0, 0.1)`
                            : ``,
                        color: active && !selectedTrack ? `gray` : ``,
                      }}
                    >
                      <Stack fill>
                        <Stack.Item grow>{song.name}</Stack.Item>
                        <Stack.Item>{formatTime(song.length)}</Stack.Item>
                      </Stack>
                    </Button>
                  </Stack.Item>
                );
              })}
            </Section>
          </Stack.Item>
          {uploadTrack && (
            <Stack.Item>
              <Section fill title="Загрузить трек">
                <Stack fill vertical textAlign="center">
                  <Stack.Item>
                    <LabeledList>
                      <LabeledList.Item label="Название">
                        <Input
                          width="100%"
                          placeholder="Название трека..."
                          value={trackName}
                          onChange={(e, value) => setTrackName(value)}
                        />
                      </LabeledList.Item>
                      <LabeledList.Item label="Продолжительность (сек)">
                        <NumberInput
                          width="100%"
                          step={10}
                          minValue={0}
                          value={trackLength}
                          maxValue={600}
                          onChange={(value) => setTrackLength(value)}
                        />
                      </LabeledList.Item>
                      <LabeledList.Item label="BPS">
                        <NumberInput
                          width="100%"
                          step={10}
                          minValue={0}
                          value={trackBeat}
                          maxValue={100}
                          onChange={(value) => setTrackBeat(value)}
                        />
                      </LabeledList.Item>
                    </LabeledList>
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="upload"
                      disabled={!trackName || !trackLength || !trackBeat}
                      onClick={() => {
                        act('add_song', {
                          track_name: trackName,
                          track_length: trackLength * 10,
                          track_beat: trackBeat,
                        }),
                          setUploadTrack(false);
                      }}
                    >
                      Загрузить новый трек
                    </Button>
                  </Stack.Item>
                </Stack>
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};

const OnMusic = () => {
  return (
    <Dimmer textAlign="center">
      <Icon name="music" size={3} color="gray" mb={1} />
      <Box color="label" bold>
        Играет музыка
      </Box>
    </Dimmer>
  );
};
