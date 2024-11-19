import { CheckboxInputInverse, FeatureToggle } from '../base';

export const hotkeys: FeatureToggle = {
  name: 'Классические горячие клавиши',
  category: 'ГЕЙМПЛЕЙ',
  description:
    'Возвращает к старым горячи клавишам, которые используют полосу ввода, а не всплывающие окна.',
  component: CheckboxInputInverse,
};
