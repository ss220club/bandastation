import { Antagonist, Category } from '../base';

const Fugitive: Antagonist = {
  key: 'fugitive',
  name: 'Беглец',
  description: [
    `
    Wherever you come from, you're being hunted. You have 10 minutes to prepare
    before fugitive hunters arrive and start hunting you and your friends down!
    `,
  ],
  category: Category.Midround,
};

export default Fugitive;
