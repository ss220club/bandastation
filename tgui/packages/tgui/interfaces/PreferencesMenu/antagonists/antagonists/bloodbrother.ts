import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

const BloodBrother: Antagonist = {
  key: 'bloodbrother',
  name: 'Кровный брат',
  description: [
    multiline`
      Объединитесь с другими членами команды как кровные братья,
      чтобы объединить сильные стороны своих отделов,
      вызволить друг друга из тюрьмы и побороть станцию.
    `,
  ],
  category: Category.Roundstart,
};

export default BloodBrother;
