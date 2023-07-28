import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Button, Section } from '../components';

type Emote = {
  key: string;
  emote_path: string;
};

type EmotePanelData = {
  emotes: Emote[];
};

export const EmotePanelContent = (props, context) => {
  const { act, data } = useBackend<EmotePanelData>(context);
  const { emotes } = data;
  return (
    <Section title="Emote Panel">
      {emotes.map((emote) => (
        <Button
          key={emote.key}
          onClick={() =>
            act('play_emote', {
              emote_path: emote.emote_path,
            })
          }>
          {emote.key}
        </Button>
      ))}
    </Section>
  );
};

export const EmotePanel = (props, context) => {
  return (
    <Window width={500} height={450}>
      <Window.Content scrollable>
        <EmotePanelContent />
      </Window.Content>
    </Window>
  );
};
