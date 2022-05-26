import 'package:flutter/material.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/cell_calender_package/cell_calendar.dart';

/// Days of the week
///
// TODO: Internationalize the days of the week
const List<String> _DaysOfTheWeek = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fry',
  'Sat'
];

/// Show the row of text from [_DaysOfTheWeek]
class DaysOfTheWeek extends StatelessWidget {
  DaysOfTheWeek(this.daysOfTheWeekBuilder);

  final daysBuilder? daysOfTheWeekBuilder;

  Widget defaultLabels(index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: AppTextSize.textSize12(_DaysOfTheWeek[index], Colors.black,
          FontWeight.normal, "rubikregular", 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        7,
        (index) {
          return Expanded(
            child: daysOfTheWeekBuilder?.call(index) ?? defaultLabels(index),
          );
        },
      ),
    );
  }
}
