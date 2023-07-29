import { Feature } from '../base';
import { FeatureTextInput } from '../base_bandastation';

export const flavor_text: Feature<string> = {
  name: 'Flavor Text',
  description: 'Describe your character!',
  component: FeatureTextInput,
};

export const silicon_flavor_text: Feature<string> = {
  name: 'Flavor Text (Silicon)',
  description: 'Describe your cyborg/AI shell!',
  component: FeatureTextInput,
};
