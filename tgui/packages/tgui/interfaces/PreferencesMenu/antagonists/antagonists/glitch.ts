import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

const Glitch: Antagonist = {
  key: 'glitch',
  name: 'Сбой',
  description: [
    multiline`
    Виртуальное пространство - опасное место для битраннеров. Убедите их в этом.
    `,

    multiline`
    Вы кратковременный антагонист, сбой в системе. Используйте боевые искусства \
    и летальное оружие, чтобы уничтожить органиков.
    `,
  ],
  category: Category.Midround,
};

export default Glitch;
