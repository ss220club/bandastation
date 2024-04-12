import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

export const CHANGELING_MECHANICAL_DESCRIPTION = multiline`
Превращайтесь или превращайте в другие личностей и покупайте арсенал
биологического оружия с помощью собранной ДНК.
`;

const Changeling: Antagonist = {
  key: 'changeling',
  name: 'Генокрад',
  description: [
    multiline`
      Разумный инопланетный хищник, способный изменять свою форму,
      чтобы безупречно походить на человека.
    `,
    CHANGELING_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Changeling;
