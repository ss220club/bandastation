export const CRIMESTATUS2COLOR = {
  Арест: 'bad',
  Оправдано: 'blue',
  Заключение: 'average',
  УДО: 'good',
  Подозрение: 'teal',
} as const;

export const CRIMESTATUS2DESC = {
  Арест:
    'Арест. Личность должна иметь действующие преступления для выдачи статуса.',
  Оправдано: 'Оправдано. Личность оправдана в совершении правонарушений.',
  Заключение: 'Заключение. Личность сейчас отбывает срок.',
  УДО: 'УДО. Освобождение из тюрьмы, но все еще находится под надзором.',
  Подозрение: 'Подозрение. Внимательно следите за преступной деятельностью.',
} as const;
