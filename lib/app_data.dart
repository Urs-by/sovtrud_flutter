import 'dart:math';

final username = "Эммануил Гидеонович";

final draver_header = "Настройки";
final draver_change_theme = "Изменить тему";
final draver_exit = "Выйти";
final draver_back = "Назад";
final draver_turn = "Свернуть";

List<String> tasks = [
  'Задачи на день',
  'Задачи на неделю',
  'Задачи на месяц',
  'Задачи на квартал',
  'Задачи на год',
];

final task_plan = "План";
final task_fact = "Факт";

List<String> day = [
  'Пн',
  'Вт',
  'Ср',
  'Чт',
  'Пт',
  'Сб',
  'Вс',
];




List<int> planTasks = List.generate(30, (index) => Random().nextInt(7) + 1);

List<int> factTasks = generateSecondList(planTasks);
List<int> generateSecondList(List<int> firstList) {
  return firstList.map((value) => Random().nextInt(value) + 1).toList();
}
