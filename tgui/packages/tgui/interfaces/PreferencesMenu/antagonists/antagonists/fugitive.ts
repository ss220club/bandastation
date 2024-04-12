import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

const Fugitive: Antagonist = {
  key: 'fugitive',
  name: 'Беглец',
  description: [
    multiline`
    Откуда бы вы ни прибыли, за вами охотятся. У вас есть 10 минут,
    чтобы подготовиться, пока не появились охотники за беглецами и не начали охоту на вас и ваших друзей!
    `,
  ],
  category: Category.Midround,
};

export default Fugitive;
