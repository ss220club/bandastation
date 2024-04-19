import { multiline } from 'common/string';

import {
  CheckboxInput,
  Feature,
  FeatureNumberInput,
  FeatureToggle,
} from '../base';

export const enable_tips: FeatureToggle = {
  name: 'Подсказки - включить',
  category: 'ПОДСКАЗКИ',
  description: multiline`
    Показывать подсказки при наведении на объект.
  `,
  component: CheckboxInput,
};

export const tip_delay: Feature<number> = {
  name: 'Подсказки - задержка (в миллисекундах)',
  category: 'ПОДСКАЗКИ',
  description: multiline`
    Задержка перед тем, как показать подсказку при наведении на объект?
  `,
  component: FeatureNumberInput,
};
