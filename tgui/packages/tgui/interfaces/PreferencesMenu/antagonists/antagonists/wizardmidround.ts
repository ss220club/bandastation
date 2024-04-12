import { Antagonist, Category } from '../base';
import { WIZARD_MECHANICAL_DESCRIPTION } from './wizard';

const WizardMidround: Antagonist = {
  key: 'wizardmidround',
  name: 'Маг (Мидраунд)',
  description: [
    'Вариант мага, который могут получить призраки в любой момент во время смены.',
    WIZARD_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default WizardMidround;
