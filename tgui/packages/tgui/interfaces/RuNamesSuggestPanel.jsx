import { Button, Collapsible, LabeledList } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const RuNamesSuggestPanel = (props) => {
  const { act, data } = useBackend();
  const json_data = data.json_data || [];
  return (
    <Window
      title="Предложения переводов"
      theme="admin"
      width={550}
      height={400}
    >
      <Window.Content scrollable>
        {json_data.map((entry_id) => (
          <Collapsible
            key={entry_id}
            title={entry_id.ckey + ' предлагает для ' + entry_id.atom_path}
          >
            <LabeledList>
              <LabeledList.Item label="ckey">{entry_id.ckey}</LabeledList.Item>
              <LabeledList.Item label="Путь к объекту">
                {entry_id.atom_path}
              </LabeledList.Item>
              <LabeledList.Item label="Стандартное имя">
                {entry_id.suggested_list['base']}
              </LabeledList.Item>
              <LabeledList.Item label="Именительный">
                {entry_id.suggested_list['именительный']}
              </LabeledList.Item>
              <LabeledList.Item label="Родительный">
                {entry_id.suggested_list['родительный']}
              </LabeledList.Item>
              <LabeledList.Item label="Дательный">
                {entry_id.suggested_list['дательный']}
              </LabeledList.Item>
              <LabeledList.Item label="Винительный">
                {entry_id.suggested_list['винительный']}
              </LabeledList.Item>
              <LabeledList.Item label="Творительный">
                {entry_id.suggested_list['творительный']}
              </LabeledList.Item>
              <LabeledList.Item label="Предложный">
                {entry_id.suggested_list['предложный']}
              </LabeledList.Item>
              <LabeledList.Item>
                <Button
                  color="green"
                  onClick={() =>
                    act('approve', {
                      entry_id: entry_id.ckey + '-' + entry_id.atom_path,
                    })
                  }
                >
                  Approve
                </Button>
              </LabeledList.Item>
              <LabeledList.Item>
                <Button
                  color="red"
                  onClick={() =>
                    act('deny', {
                      entry_id: entry_id.ckey + '-' + entry_id.atom_path,
                    })
                  }
                >
                  Deny
                </Button>
              </LabeledList.Item>
            </LabeledList>
          </Collapsible>
        ))}
      </Window.Content>
    </Window>
  );
};
