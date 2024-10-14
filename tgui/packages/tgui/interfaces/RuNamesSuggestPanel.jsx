import { Button } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const RuNamesSuggestPanel = (props) => {
  const { act, data } = useBackend();
  const json_data = data.json_data || [];
  return (
    <Window title="Ru Names Suggest" theme="admin" width={700} height={700}>
      <Window.Content scrollable>
        {json_data.map((entry_id) => (
          <Button
            key={entry_id}
            onClick={() => act('deny', { entry_id: entry_id })}
          >
            entry_id
          </Button>
        ))}
      </Window.Content>
    </Window>
  );
};
