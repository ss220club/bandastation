import { FeatureChoiced, FeatureDropdownInput } from '../base';

export const prisoner_crime: FeatureChoiced = {
  name: 'Преступления заключенного',
  description:
    'Будучи заключенным, эта информация будет внесена в ваши записи как причина вашего ареста.',
  component: FeatureDropdownInput,
};
