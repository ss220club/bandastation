import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureSliderInput,
  FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const sound_ambience: FeatureToggle = {
  name: 'Включить звук окружения',
  category: 'ЗВУК',
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
  name: 'Enable TTS',
  category: 'SOUND',
  description: `
    When enabled, be able to hear text-to-speech sounds in game.
    When set to "Blips", text to speech will be replaced with blip sounds based on the voice.
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

export const sound_lobby: FeatureToggle = {
  name: 'Включить звук лобби-музыки',
  category: 'ЗВУК',
  component: CheckboxInput,
};

export const sound_midi: FeatureToggle = {
  name: 'Включить звук админской музыки',
  category: 'ЗВУК',
  description: 'Играть звук музыки, запускаемой администрацией.',
  component: CheckboxInput,
};

export const sound_ship_ambience: FeatureToggle = {
  name: 'Включить звук корабля',
  category: 'ЗВУК',
  component: CheckboxInput,
};

export const sound_elevator: FeatureToggle = {
  name: 'Включить музыку в лифтах',
  category: 'ЗВУК',
  component: CheckboxInput,
};

export const sound_achievement: FeatureChoiced = {
  name: 'Achievement unlock sound',
  category: 'SOUND',
  description: `
    The sound that's played when unlocking an achievement.
    If disabled, no sound will be played.
  `,
  component: FeatureDropdownInput,
};
