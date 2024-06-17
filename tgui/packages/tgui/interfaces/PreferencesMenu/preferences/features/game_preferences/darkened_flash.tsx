import { CheckboxInput, FeatureToggle } from '../base';

export const darkened_flash: FeatureToggle = {
  name: 'Включить затемнение вспышек',
  category: 'ГЕЙМПЛЕЙ',
  description: `
    Если включено, ослепление будет показывать темный экран,
    вместо яркого.
  `,
  component: CheckboxInput,
};
