import { Antagonist, Category } from '../base';

const SentientDisease: Antagonist = {
  key: 'sentientdisease',
  name: 'Разумная болезнь',
  description: [
    `
      Мутируйте, распространяйтесь и заразите как можно больше членов экипажа
      смертельно опасной чумой собственного создания.
    `,
  ],
  category: Category.Midround,
};

export default SentientDisease;
