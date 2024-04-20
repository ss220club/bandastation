import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';
import { CHANGELING_MECHANICAL_DESCRIPTION } from './changeling';

const Stowaway_Changeling: Antagonist = {
  key: 'stowawaychangeling',
  name: 'Генокрад-безбилетник',
  description: [
    multiline`
      Генокрад, который попал на шаттл без ведома членов экипажа.
    `,
    CHANGELING_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Latejoin,
};

export default Stowaway_Changeling;
