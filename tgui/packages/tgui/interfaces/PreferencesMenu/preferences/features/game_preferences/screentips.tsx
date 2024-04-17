import { multiline } from 'common/string';

import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureColorInput,
  FeatureDropdownInput,
  FeatureToggle,
} from '../base';

export const screentip_color: Feature<string> = {
  name: 'Подсказки на экране - цвет',
  category: 'ИНТЕРФЕЙС',
  description: multiline`
    Цвет ваших подсказок на экране.
  `,
  component: FeatureColorInput,
};

export const screentip_images: FeatureToggle = {
  name: 'Подсказки на экране - изображения',
  category: 'ИНТЕРФЕЙС',
  description: multiline`Показывает изображения кнопок мыши при подсказках,
    вместо ЛКМ/ПКМ.`,
  component: CheckboxInput,
};

export const screentip_pref: FeatureChoiced = {
  name: 'Подсказки на экране - включить',
  category: 'ИНТЕРФЕЙС',
  description: multiline`
   Включает подсказки на экране, когда вы наводитесь над объектами.
   Если выбрана "Только с подсказками", подсказки будут появляться, только если
   есть дополнительная информация к ним, например действие на ПКМ.
  `,
  component: FeatureDropdownInput,
};
