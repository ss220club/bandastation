import { useBackend } from '../../backend';
import { Box, Button, Dimmer, Section, Stack } from '../../components';
import { ObjectiveElement } from './ObjectiveMenu';

type PrimaryObjectiveMenuProps = {
  primary_objectives;
  final_objective;
  can_renegotiate;
};

export const PrimaryObjectiveMenu = (props: PrimaryObjectiveMenuProps) => {
  const { act } = useBackend();
  const { primary_objectives, final_objective, can_renegotiate } = props;
  return (
    <Section fill>
      <Section>
        <Box mt={3} mb={3} bold fontSize={1.2} align="center" color="white">
          {'Агент, это ваши основные задачи. Выполните их любой ценой.'}
        </Box>
        <Box mt={3} mb={5} bold fontSize={1.2} align="center" color="white">
          {
            'Завершение второстепенных задач позволяет получить дополнительное оборудование.'
          }
        </Box>
      </Section>
      {final_objective && (
        <Dimmer>
          <Box
            color="red"
            fontFamily={'Bahnschrift'}
            fontSize={3}
            align={'top'}
            as="span"
          >
            ПРИОРИТЕТНОЕ СООБЩЕНИЕ
            <br />
            ИСТОЧНИК: xxx.xxx.xxx.224:41394
            <br />
            <br />
            \\Проводится подведение итогов.
            <br />
            \\Выполнение финальной задачи подверждено <br />
            \\Ваша работа здесь готова, агент.
            <br />
            <br />
            СОЕДИНЕНИЕ ЗАКРЫТО_
          </Box>
        </Dimmer>
      )}
      <Section>
        <Stack vertical fill scrollable>
          {primary_objectives.map((prim_obj, index) => (
            <Stack.Item key={index}>
              <ObjectiveElement
                key={prim_obj.id}
                name={prim_obj['task_name']}
                description={prim_obj['task_text']}
                dangerLevel={{
                  minutesLessThan: 0,
                  title: 'none',
                  gradient:
                    index === primary_objectives.length - 1
                      ? 'reputation-good'
                      : 'reputation-very-good',
                }}
                telecrystalReward={0}
                telecrystalPenalty={0}
                progressionReward={0}
                originalProgression={0}
                hideTcRep
                canAbort={false}
                grow={false}
                finalObjective={false}
              />
            </Stack.Item>
          ))}
        </Stack>
      </Section>
      {!!can_renegotiate && (
        <Box mt={3} mb={5} bold fontSize={1.2} align="center" color="white">
          <Button
            content={'Перезаключить контракт'}
            tooltip={
              'Замените свои текущие основные задачи на пользовательские. Это действие можно совершить лишь единожды.'
            }
            onClick={() => act('renegotiate_objectives')}
          />
        </Box>
      )}
    </Section>
  );
};
