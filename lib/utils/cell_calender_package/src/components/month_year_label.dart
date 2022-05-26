import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/cell_calender_package/cell_calendar.dart';

import '../controllers/calendar_state_controller.dart';

/// Label showing the date of current page
class MonthYearLabel extends StatelessWidget {
  const MonthYearLabel(
    this.monthYearLabelBuilder, {
    Key? key,
  }) : super(key: key);

  final monthYearBuilder? monthYearLabelBuilder;

  @override
  Widget build(BuildContext context) {
    final currentDateTime =
        Provider.of<CalendarStateController>(context).currentDateTime;
    final monthLabel = currentDateTime?.month.monthName ?? '';
    final yearLabel = currentDateTime?.year.toString();
    return monthYearLabelBuilder?.call(currentDateTime) ??
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: AppTextSize.textSize18(monthLabel + " " + yearLabel!,
              Colors.black, FontWeight.normal, "rubikregular", 1),
        );
  }
}
