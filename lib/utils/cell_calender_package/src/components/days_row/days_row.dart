import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/cell_calender_package/cell_calendar.dart';
import 'package:team_center/utils/cell_calender_package/src/components/days_row/view_label.dart';

import '../../controllers/calendar_state_controller.dart';
import '../../controllers/cell_height_controller.dart';
import 'event_labels.dart';
import 'measure_size.dart';

/// Show the row of [_DayCell] cells with events
class DaysRow extends StatelessWidget {
  const DaysRow({
    required this.visiblePageDate,
    required this.dates,
    required this.dateTextStyle,
    required this.isGameView,
    Key? key,
  }) : super(key: key);

  final List<DateTime> dates;
  final DateTime visiblePageDate;
  final TextStyle? dateTextStyle;
  final bool? isGameView;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: dates.map((date) {
          return _DayCell(
            date,
            visiblePageDate,
            dateTextStyle,
            isGameView,
          );
        }).toList(),
      ),
    );
  }
}

/// Cell of calendar.
///
/// Its height is circulated by [MeasureSize] and notified by [CellHeightController]
class _DayCell extends StatelessWidget {
  _DayCell(
      this.date, this.visiblePageDate, this.dateTextStyle, this.isGameView);

  final DateTime date;
  final DateTime visiblePageDate;
  final TextStyle? dateTextStyle;
  bool? isGameView;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Provider.of<CalendarStateController>(context, listen: false)
              .onCellTapped(date);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Theme.of(context).dividerColor, width: 0.5),
                right:
                    BorderSide(color: Theme.of(context).dividerColor, width: 1),
                bottom: BorderSide(
                    color: Theme.of(context).dividerColor, width: 0.5)),
          ),
          child: MeasureSize(
            onChange: (size) {
              if (size == null) return;
              Provider.of<CellHeightController>(context, listen: false)
                  .onChanged(size);
            },
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isToday
                      ? Container(
                          margin: EdgeInsets.only(left: 5, top: 5),
                          alignment: Alignment.topLeft,
                          child: _TodayLabel(
                            date: date,
                            dateTextStyle: dateTextStyle,
                          ),
                        )
                      : Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 5, top: 5),
                          child: _DayLabel(
                            date: date,
                            visiblePageDate: visiblePageDate,
                            dateTextStyle: dateTextStyle,
                          ),
                        ),
                  Expanded(
                      flex: 1,
                      child: isGameView == false
                          ? EventLabels(date)
                          : ViewLables(date)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TodayLabel extends StatelessWidget {
  const _TodayLabel({
    Key? key,
    required this.date,
    required this.dateTextStyle,
  }) : super(key: key);

  final DateTime date;
  final TextStyle? dateTextStyle;
  

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<TodayUIConfig>(context, listen: false);
    final caption = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontWeight: FontWeight.w500);
    final textStyle = caption.merge(dateTextStyle);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      height: 20,
      width: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accentColor,
      ),
      child: AppTextSize.textSize12(date.day.toString(), config.todayTextColor,
          FontWeight.normal, "rubikregular", 1),
    );
  }
}

class _DayLabel extends StatelessWidget {
  const _DayLabel({
    Key? key,
    required this.date,
    required this.visiblePageDate,
    required this.dateTextStyle,
  }) : super(key: key);

  final DateTime date;
  final DateTime visiblePageDate;
  final TextStyle? dateTextStyle;

  @override
  Widget build(BuildContext context) {
    final isCurrentMonth = visiblePageDate.month == date.month;
    final caption = Theme.of(context).textTheme.caption!.copyWith(
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface);
    final textStyle = caption.merge(dateTextStyle);
    const dayLabelContentHeight = 16;
    const dayLabelVerticalMargin = 4;

    return Container(
      margin: EdgeInsets.symmetric(vertical: dayLabelVerticalMargin.toDouble()),
      height: dayLabelContentHeight.toDouble(),
      child: isCurrentMonth
          ? AppTextSize.textSize12(date.day.toString(), textStyle.color!,
              FontWeight.normal, "rubikregular", 1)
          : AppTextSize.textSize12(
              date.day.toString(),
              textStyle.color!.withOpacity(0.4),
              FontWeight.normal,
              "rubikregular",
              1),
    );
  }
}
