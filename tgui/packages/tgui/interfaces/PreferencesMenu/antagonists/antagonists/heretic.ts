import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

export const HERETIC_MECHANICAL_DESCRIPTION = multiline`
      Find hidden influences and sacrifice crew members to gain magical
      powers and ascend as one of several paths.
   `;

const Heretic: Antagonist = {
  key: 'heretic',
  name: 'Еретик',
  description: [
    multiline`
      Забытые, поглощенные, выпотрошенные. Человечество забыло об эльдрических силах
      разложения, но завеса мансуса ослабла. Мы заставим их почувствовать вкус страха
      снова...
    `,
    HERETIC_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Heretic;
