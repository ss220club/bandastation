import { Dropdown, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  displayStyle: string;
};

export const JobDisplay = (props) => {
  const { act, data } = useBackend<Data>();
  const { displayStyle } = data;
  const STYLES = [
    'Отсутствует (Имя)',
    'По умолчанию ([Работа] Имя)',
    'Альтернативный (Имя (Работа))',
    'Альтернативный 2 (Имя - Работа)',
  ];
  return (
    <Window title="Система отображения назначения" width={400} height={200}>
      <Window.Content>
        <Section title="Стиль отображения" textAlign="left">
          <Dropdown
            textAlign="left"
            placeholder="Выберите стиль..."
            selected={displayStyle}
            options={STYLES}
            onSelected={(value) =>
              act('changeStyle', {
                displayStyle: value,
              })
            }
          />
        </Section>
      </Window.Content>
    </Window>
  );
};
