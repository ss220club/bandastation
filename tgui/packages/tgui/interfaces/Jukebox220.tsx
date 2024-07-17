import React, { useState } from 'react';
import { sortBy } from 'common/collections';

import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import {
  Box,
  Button,
  Input,
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
  const [trackName, setTrackName] = useState('Common Song');
  const [trackLength, setTrackLength] = useState('2200');
  const [trackBeat, setTrackBeat] = useState('220');
  const {
    active,
    looping,
    track_selected,
    volume,
    songs,
    startTime,
    endTime,
    worldTime,
  } = data;

  const MAX_NAME_LENGTH = 35;
  const songs_sorted: Song[] = sortBy(songs, (song: Song) => song.name);
  const song_selected: Song | undefined = songs.find(
    (song) => song.name === track_selected,
  );
  const totalTracks = songs_sorted.length;
  const selectedTrackNumber = song_selected
    ? songs_sorted.findIndex((song) => song.name === song_selected.name) + 1
    : 0;

  const formatTime = (seconds) => {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    const formattedTime = `${String(minutes).padStart(2, '0')}:${String(remainingSeconds).padStart(2, '0')}`;
    return formattedTime;
  };

  const trackTimer = (
    <Box textAlign="center">
      {active
        ? looping
          ? '∞'
          : formatTime(Math.round((worldTime - startTime) / 10))
        : looping
          ? '∞'
          : formatTime(song_selected?.length)}{' '}
      / {looping ? '∞' : formatTime(song_selected?.length)}
    </Box>
  );

  return (
    <Window width={350} height={435} title="Музыкальный автомат">
      <Window.Content>
        <Stack fill vertical>
          <Stack>
            <Stack.Item grow textAlign="center">
              <Section fill title="Проигрыватель">
                <Stack fill vertical>
                  <Stack.Item bold maxWidth="240px">
                    {song_selected.name.length > MAX_NAME_LENGTH ? (
                      <marquee>{song_selected?.name}</marquee>
                    ) : (
                      song_selected?.name
                    )}
                  </Stack.Item>
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
                    <Stack.Item>
                      <Button.Checkbox
                        icon={'download'}
                        checked={uploadTrack}
                        onClick={() => setUploadTrack(!uploadTrack)}
                      />
                    </Stack.Item>
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
              <Section>
                {active ? <OnMusic /> : null}
                <Stack fill mb={1.5}>
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
                <Stack.Item textAlign="center" textColor="label">
                  <Knob
                    size={2}
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
                  Volume
                </Stack.Item>
              </Section>
            </Stack.Item>
          </Stack>
          <Stack.Item grow textAlign="center">
            {uploadTrack ? (
              <Section fill scrollable title="Загрузить трек">
                <Stack fill vertical>
                  <Stack.Item grow>
                    <LabeledList>
                      <LabeledList.Item label="Название">
                        <Input
                          fluid
                          value={trackName}
                          onChange={(e, value) => setTrackName(value)}
                        />
                      </LabeledList.Item>
                      <LabeledList.Item label="Продолжительность">
                        <Input
                          fluid
                          value={trackLength}
                          onChange={(e, value) => setTrackLength(value)}
                        />
                      </LabeledList.Item>
                      <LabeledList.Item label="BPS">
                        <Input
                          fluid
                          value={trackBeat}
                          onChange={(e, value) => setTrackBeat(value)}
                        />
                      </LabeledList.Item>
                      {/*
                      <LabeledList.Item label="Файл">
                        <Button
                          fluid
                          icon="upload"
                          onClick={() => act('upload_track')}
                        >
                          Загрузить файл...
                        </Button>
                      </LabeledList.Item>
                      */}
                    </LabeledList>
                  </Stack.Item>
                  <Stack.Item>
                    {trackName} {trackLength} {trackBeat}
                  </Stack.Item>
                  <Stack.Item>
                    <Button
                      fluid
                      icon="check"
                      disabled={!trackName || !trackLength || !trackBeat}
                      onClick={() => {
                        act('add_song', {
                          track_name: trackName,
                          track_length: trackLength,
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
            ) : (
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
                      const randomIndex = Math.floor(
                        Math.random() * totalTracks,
                      );
                      const randomTrack = songs_sorted[randomIndex];
                      act('select_track', { track: randomTrack.name });
                    }}
                  >
                    {selectedTrackNumber}/{totalTracks}
                  </Button>
                }
              >
                {songs_sorted.map((song) => (
                  <Stack.Item key={song.name} mb={0.5} textAlign="left">
                    <Button
                      fluid
                      selected={song_selected?.name === song.name}
                      color="translucent"
                      onClick={() => {
                        act('select_track', { track: song.name });
                      }}
                    >
                      <Stack fill>
                        <Stack.Item grow>{song.name}</Stack.Item>
                        <Stack.Item>{song.length}</Stack.Item>
                      </Stack>
                    </Button>
                  </Stack.Item>
                ))}
              </Section>
            )}
          </Stack.Item>
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
