import 'package:flutter/widgets.dart';
import 'package:sovtrud_project/app_data.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:sovtrud_project/gauge_indicator.dart';
import 'package:charts_painter/chart.dart';


class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String? selectedTask = tasks[0];
  DateTime currentDate = DateTime.now();
  int plannedTasks = 0;
  int completedTasks = 0;

  void changeDate(int days) {
    setState(() {
      int maxTasks = 0;
      if (selectedTask == tasks[0]) {
        maxTasks = 5;
      } else if (selectedTask == tasks[1]) {
        maxTasks = 15;
      } else if (selectedTask == tasks[2]) {
        maxTasks = 60;
      } else if (selectedTask == tasks[3]) {
        maxTasks = 150;
      } else if (selectedTask == tasks[4]) {
        maxTasks = 500;
      }

      if (selectedTask == tasks[0]) {
        currentDate = currentDate.add(Duration(days: days));
      } else if (selectedTask == tasks[1]) {
        currentDate = currentDate.add(Duration(days: days * 7));
      } else if (selectedTask == tasks[2]) {
        currentDate = DateTime(currentDate.year, currentDate.month + days);
      } else if (selectedTask == tasks[3]) {
        int currentQuarter = (currentDate.month / 3).ceil();
        currentDate = DateTime(currentDate.year, currentQuarter * 3 + days * 3);
      } else if (selectedTask == tasks[4]) {
        currentDate = DateTime(currentDate.year + days);
      }

      plannedTasks = Random().nextInt(maxTasks);
      completedTasks = Random().nextInt(plannedTasks + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.orange,
          child: Center(
            child: DropdownButton<String>(
              value: selectedTask,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTask = newValue;
                  if (selectedTask == tasks[2] ||
                      selectedTask == tasks[3] ||
                      selectedTask == tasks[4] ||
                      selectedTask == tasks[1]) {
                    currentDate = DateTime.now();
                  }
                });
              },
              items: tasks.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      changeDate(
                          -1); // Переключение на предыдущий день или неделю или месяц или квартал или год
                    },
                    child: Text('<<'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 5.0),
                    child: Text(
                      selectedTask == tasks[0]
                          ? MaterialLocalizations.of(context)
                              .formatMediumDate(currentDate)
                              .toUpperCase()
                          : selectedTask == tasks[1]
                              ? '${MaterialLocalizations.of(context).formatMediumDate(DateTime(currentDate.year, currentDate.month, currentDate.day - currentDate.weekday + 1))}'
                                  ' - ${MaterialLocalizations.of(context).formatMediumDate(DateTime(currentDate.year, currentDate.month, currentDate.day - currentDate.weekday + 7))}'
                              : selectedTask == tasks[2]
                                  ? MaterialLocalizations.of(context)
                                      .formatMonthYear(currentDate)
                                      .toUpperCase()
                                  : selectedTask == tasks[4]
                                      ? MaterialLocalizations.of(context)
                                          .formatYear(currentDate)
                                      : '${((currentDate.month - 1) / 3).ceil()} Квартал ${currentDate.year}',
                      style: TextStyle(fontSize: 20),
                      // padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      changeDate(
                          1); // Переключение на следующий день или неделю или месяц или квартал или год
                    },
                    child: Text('>>'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                selectedTask == tasks[0]
                    ? Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '$task_plan: $plannedTasks                                      $task_fact: $completedTasks',
                          ),
                          GaugeIndicator(
                              value: (completedTasks / plannedTasks * 100)),
                        ],
                      )
                    : selectedTask == tasks[1]
                        ? Container(
                            width: 300.0,
                            child: Chart(
                              state: ChartState<void>(
                                data: ChartData.randomBarValues(
                                  items: 7,
                                  maxValue: 7,
                                ),
                                itemOptions: BarItemOptions(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  barItemBuilder: (_) => BarItem(
                                      radius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  maxBarWidth: 5.0,
                                ),
                                backgroundDecorations: [
                                  GridDecoration(
                                    endWithChartVertical: true,
                                    endWithChartHorizontal: true,
                                    showHorizontalValues: true,
                                    showVerticalGrid: false,
                                    showVerticalValues: true,
                                    showTopHorizontalValue: true,
                                    horizontalLegendPosition:
                                        HorizontalLegendPosition.start,
                                    gridColor: Colors.grey.shade200,
                                    gridWidth: 1,
                                    horizontalValuesPadding:
                                        const EdgeInsets.only(
                                            bottom: -8.0, right: 8.0),
                                    verticalValuesPadding:
                                        const EdgeInsets.only(top: 24.0),
                                    horizontalAxisValueFromValue: (value) =>
                                        '${value + 1}',
                                    verticalAxisValueFromIndex: (value) =>
                                        day[value],
                                    textStyle: TextStyle(
                                        fontSize: 14.0, color: Colors.black45),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : selectedTask == tasks[2]
                            ? Container(
                                // width: 300.0,

                                child: Chart(
                                state: ChartState<void>(
                                  data: ChartData(
                                    [
                                      planTasks
                                          .map((value) => ChartItem(
                                              value.toDouble(),
                                              min: value.toDouble()))
                                          .toList(),
                                      factTasks
                                          .map((value) => ChartItem(
                                              value.toDouble(),
                                              min: value.toDouble()))
                                          .toList(),
                                    ],
                                    axisMax: 10,
                                  ),
                                  itemOptions: BarItemOptions(
                                    barItemBuilder: (_) {
                                      return BarItem(color: Colors.transparent);
                                    },
                                  ),
                                  backgroundDecorations: [
                                    GridDecoration(
                                      horizontalAxisStep: 2.0,
                                      endWithChartHorizontal: true,
                                      showTopHorizontalValue: true,
                                      showVerticalGrid: true,
                                      showVerticalValues: true,
                                      showHorizontalValues: true,
                                      horizontalLegendPosition:
                                          HorizontalLegendPosition.start,
                                      gridColor: Colors.grey.shade400,
                                      gridWidth: 1,
                                      dashArray: [4, 4],
                                      verticalValuesPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                      horizontalAxisValueFromValue: (value) =>
                                          '${value}',
                                      verticalAxisValueFromIndex: (value) =>
                                          '${value + 1}',
                                      textStyle: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black45),
                                    ),
                                  ],
                                  foregroundDecorations: [
                                    BorderDecoration(
                                      sidesWidth: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1.0,
                                        ),
                                      ),
                                      endWithChart: true,
                                    ),
                                    SparkLineDecoration(
                                      listIndex: 1,
                                      lineColor: Color(0xFFB6CADD),
                                      lineWidth: 4.0,
                                    ),
                                    SparkLineDecoration(
                                      lineColor: Color(0xFF5B6ACF),
                                      lineWidth: 4.0,
                                    ),
                                  ],
                                ),
                              ))
                            : Container(),
              ],
            )),
      ],
    );
  }
}
