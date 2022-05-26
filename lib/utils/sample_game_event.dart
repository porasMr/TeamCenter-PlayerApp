import 'package:team_center/utils/AppColors.dart';

import 'package:team_center/utils/cell_calender_package/src/calendar_event.dart';

List<CalendarEvent> sampleGameEvents() {
  final today = DateTime.now();
  final sampleEvents = [
    CalendarEvent(
        eventName: "Hapoel",
        eventDate: today.add(Duration(days: -20)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Hapoel",
        eventDate: today.add(Duration(days: -19)),
        eventBackgroundColor: AppColors.pinkColor),
    CalendarEvent(
        eventName: "Hapoel",
        eventDate: today.add(Duration(days: -18)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Macabi",
        eventDate: today.add(Duration(days: -17)),
        eventBackgroundColor: AppColors.vilotColor),
    CalendarEvent(
        eventName: "Hapoel.",
        eventDate: today.add(Duration(days: -42)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Macabi",
        eventDate: today.add(Duration(days: -30)),
        eventBackgroundColor: AppColors.redColor),
    CalendarEvent(
        eventName: "Macabi",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColors.vilotColor),
    CalendarEvent(
        eventName: "Macabi",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: AppColors.pinkColor),
    CalendarEvent(
        eventName: "Macabi",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Macabi",
        eventDate: today.add(Duration(days: 21)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Macabi",
        eventDate: today.add(Duration(days: 30)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Macabi",
        eventDate: today.add(Duration(days: 42)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
  ];
  return sampleEvents;
}
