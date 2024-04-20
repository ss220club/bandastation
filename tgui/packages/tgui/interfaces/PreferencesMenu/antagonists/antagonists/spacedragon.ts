import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

const SpaceDragon: Antagonist = {
  key: 'spacedragon',
  name: 'Космический дракон',
  description: [
    multiline`
      Станьте свирепым Космическим драконом. Дышите огнем, призывайте армию
      космических карпов, крушите стены и наводите ужас на станцию.
    `,
  ],
  category: Category.Midround,
};

export default SpaceDragon;
