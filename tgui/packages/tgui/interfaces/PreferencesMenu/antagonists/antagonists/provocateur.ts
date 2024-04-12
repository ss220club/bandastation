import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';
import { REVOLUTIONARY_MECHANICAL_DESCRIPTION } from './headrevolutionary';

const Provocateur: Antagonist = {
  key: 'provocateur',
  name: 'Провокатор',
  description: [
    multiline`
      Вариант главы революции, который можно получить при прибытии на уже теущую
      смену.
    `,

    REVOLUTIONARY_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Latejoin,
};

export default Provocateur;
