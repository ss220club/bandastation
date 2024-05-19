import { Antagonist, Category } from '../base';
import { TRAITOR_MECHANICAL_DESCRIPTION } from './traitor';

const SyndicateSleeperAgent: Antagonist = {
  key: 'syndicatesleeperagent',
  name: 'Спящий агент Синдиката',
  description: [
    `
      A form of traitor that can activate at any point in the middle
      of the shift.
    `,
    TRAITOR_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
  priority: -1,
};

export default SyndicateSleeperAgent;
