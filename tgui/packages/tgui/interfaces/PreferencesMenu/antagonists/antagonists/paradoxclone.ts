import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

const ParadoxClone: Antagonist = {
  key: 'paradoxclone',
  name: 'Парадоксальный клон',
  description: [
    multiline`
    Странная пространственно-временная аномалия телепортировала вас в
    другую реальность! Теперь вам предстоит найти своего двойника,
    убить и заменить его.
    `,
  ],
  category: Category.Midround,
};

export default ParadoxClone;
