import { Antagonist, Category } from '../base';
import { REVOLUTIONARY_MECHANICAL_DESCRIPTION } from './headrevolutionary';

const Provocateur: Antagonist = {
  key: 'provocateur',
  name: 'Провокатор',
  description: [
    `
      A form of head revolutionary that can activate when joining an ongoing
      shift.
    `,

    REVOLUTIONARY_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Latejoin,
};

export default Provocateur;
