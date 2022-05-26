import 'package:team_center/utils/AppColors.dart';

import 'package:team_center/utils/cell_calender_package/src/calendar_event.dart';

List<CalendarEvent> trainnerSampleEvents() {
  final today = DateTime.now();
  final sampleEvents = [
    CalendarEvent(
        eventName: "Filed A",
        eventDate: today.add(Duration(days: -20)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Filed B",
        eventDate: today.add(Duration(days: -19)),
        eventBackgroundColor: AppColors.pinkColor),
    CalendarEvent(
        eventName: "Filed D",
        eventDate: today.add(Duration(days: -18)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Filed c",
        eventDate: today.add(Duration(days: -17)),
        eventBackgroundColor: AppColors.vilotColor),
    CalendarEvent(
        eventName: "Filed A",
        eventDate: today.add(Duration(days: -42)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Filed C",
        eventDate: today.add(Duration(days: -30)),
        eventBackgroundColor: AppColors.redColor),
    CalendarEvent(
        eventName: "Filed D",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColors.vilotColor),
    CalendarEvent(
        eventName: "Filed B",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColors.redColor),
    CalendarEvent(
        eventName: "Filed C",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: AppColors.pinkColor),
    CalendarEvent(
        eventName: "Filed A",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Filed D",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: AppColors.redColor),
    CalendarEvent(
        eventName: "Filed B",
        eventDate: today.add(Duration(days: 21)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Filed C",
        eventDate: today.add(Duration(days: 30)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Filed B",
        eventDate: today.add(Duration(days: 42)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
  ];
  return sampleEvents;
}
