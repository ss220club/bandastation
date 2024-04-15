import { Feature, FeatureDropdownInput } from '../base';

export const mod_select: Feature<string> = {
  name: 'Активация модуля MOD',
  category: 'ГЕЙМПЛЕЙ',
  description: 'Какая клавиша вызовет функционал активного модуля MOD.',
  component: FeatureDropdownInput,
};
