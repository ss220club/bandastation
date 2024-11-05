import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureSliderInput,
  FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const sound_ambience_volume: Feature<number> = {
  name: 'Ambience volume',
  category: 'SOUND',
  description: `Ambience refers to the more noticeable ambient sounds that play on occasion.`,
  component: FeatureSliderInput,
};

export const sound_breathing: FeatureToggle = {
  name: 'Включить звук дыхания',
  category: 'ЗВУК',
  description: 'Слышать звук дыхания, когда подключен баллон.',
  component: CheckboxInput,
};

export const sound_announcements: FeatureToggle = {
  name: 'Включить звук анонсов',
  category: 'ЗВУК',
  description: 'Играть звук при оповещениях с ЦК, уведомлений и тд.',
  component: CheckboxInput,
};

export const sound_combatmode: FeatureToggle = {
  name: 'Включить звук режима боя',
  category: 'ЗВУК',
  description: 'Играть звук при переключении режима боя.',
  component: CheckboxInput,
};

export const sound_endofround: FeatureToggle = {
  name: 'Включить звук конца раунда',
  category: 'ЗВУК',
  description: 'Играть звук, когда сервер начинает перезапуск.',
  component: CheckboxInput,
};

export const sound_instruments: FeatureToggle = {
  name: 'Включить звук музыкальных инструментов',
  category: 'ЗВУК',
  description: 'Играть звук музыкальных инструментов.',
  component: CheckboxInput,
};

export const sound_tts: FeatureChoiced = {
  name: 'TTS - включить',
  category: 'ЗВУК',
  description: `
    Играть звук text-to-speech.
    Функция "Blips" не работает.
  `,
  component: FeatureDropdownInput,
};

export const sound_tts_volume: Feature<number> = {
  name: 'TTS - громкость',
  category: 'ЗВУК',
  description: 'Громкость text-to-speech.',
  component: FeatureSliderInput,
};

export const sound_jukebox: FeatureToggle = {
  name: 'Включить звук музыкальных автоматов',
  category: 'ЗВУК',
  description: 'Играть звук музыкальных автоматов, диско-машин и тд.',
  component: CheckboxInput,
};

export const sound_lobby_volume: Feature<number> = {
  name: 'Lobby music volume',
  category: 'SOUND',
  component: FeatureSliderInput,
};

export const sound_midi: FeatureToggle = {
  name: 'Включить звук админской музыки',
  category: 'ЗВУК',
  description: 'Играть звук музыки, запускаемой администрацией.',
  component: CheckboxInput,
};

export const sound_ship_ambience_volume: Feature<number> = {
  name: 'Ship ambience volume',
  category: 'SOUND',
  description: `Ship ambience refers to the low ambient buzz that plays on loop.`,
  component: FeatureSliderInput,
};

export const sound_elevator: FeatureToggle = {
  name: 'Включить музыку в лифтах',
  category: 'ЗВУК',
  component: CheckboxInput,
};

export const sound_achievement: FeatureChoiced = {
  name: 'Звук при получении достижений',
  category: 'ЗВУК',
  description: `
    Выбор звука, который будет играть при получении достижения.
    При отключении звука не будет.
  `,
  component: FeatureDropdownInput,
};

export const sound_radio_noise: Feature<number> = {
  name: 'Radio noise volume',
  category: 'SOUND',
  description: `Volume of talking and hearing radio chatter sounds.`,
  component: FeatureSliderInput,
};

export const sound_ai_vox: FeatureToggle = {
  name: 'Enable AI VOX announcements',
  category: 'SOUND',
  description:
    'When enabled, hear vocal AI announcements (also known as "VOX").',
  component: CheckboxInput,
};
