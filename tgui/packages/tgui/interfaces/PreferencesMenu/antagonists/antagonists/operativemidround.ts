import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';
import { OPERATIVE_MECHANICAL_DESCRIPTION } from './operative';

const OperativeMidround: Antagonist = {
  key: 'operativemidround',
  name: 'Ядерный штурмовик',
  description: [
    multiline`
      Вариант ядерного оперативника, который могут получить призраки
      в любой момент во время смены.
    `,
    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default OperativeMidround;
