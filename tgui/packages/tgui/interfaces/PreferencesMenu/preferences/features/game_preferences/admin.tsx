import {
  CheckboxInput,
  Feature,
  FeatureColorInput,
  FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const asaycolor: Feature<string> = {
  name: 'Цвет админских сообщений',
  category: 'АДМИН',
  description: 'Цвет ваших сообщений в Adminsay.',
  component: FeatureColorInput,
};

export const brief_outfit: Feature<string> = {
  name: 'Экипировка для брифинга',
  category: 'АДМИН',
  description: 'Экипировка, выдаваемая вам на роли брифинг офицера.',
  component: FeatureDropdownInput,
};

export const bypass_deadmin_in_centcom: FeatureToggle = {
  name: 'Игнорировать deadmin при спавне на ЦК',
  category: 'АДМИН',
  description:
    'Оставаться ли с правами администратора, когда вы появляетесь на ЦК.',
  component: CheckboxInput,
};

export const fast_mc_refresh: FeatureToggle = {
  name: 'Включить ускоренное обновление MC',
  category: 'АДМИН',
  description:
    'Должна ли панель MC со стат-панели обновляться быстрее обычного. Используйте, только если она нужна!',
  component: CheckboxInput,
};

export const ghost_roles_as_admin: FeatureToggle = {
  name: 'Get ghost roles while adminned',
  category: 'ADMIN',
  description: `
    If you de-select this, you will not get any ghost role pop-ups while
    adminned! Every single pop-up WILL never show up for you in an adminned
    state. However, this does not suppress notifications when you are
    a regular player (deadminned).
`,
  component: CheckboxInput,
};

export const comms_notification: FeatureToggle = {
  name: 'Звуковое оповещение о факсах на ЦК',
  category: 'АДМИН',
  component: CheckboxInput,
};
