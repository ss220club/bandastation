import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

const SpaceNinja: Antagonist = {
  key: 'spaceninja',
  name: 'Космический ниндзя',
  description: [
    multiline`
      Клан Пауков практикует своего рода аугментацию человеческой плоти,
      чтобы достичь более совершенного состояния бытия
      и следовать постмодернистскому космическому бусидо.
    `,

    multiline`
      Станьте коварным космическим ниндзя, вооружившись катаной,
      перчатками для взлома шлюзов и ЛКП, костюмом, делающим вас
      практически невидимым, а также разнообразными способностями в вашем наборе.
      Взломайте консоли СБ, чтобы пометить всех как арестованных,
      и даже взломайте консоли связи, чтобы вызвать новые угрозы
      для большего хаоса на станции!
    `,
  ],
  category: Category.Midround,
};

export default SpaceNinja;
