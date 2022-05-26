import 'package:flutter/material.dart';
import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/cell_calender_package/src/calendar_event.dart';

List<CalendarEvent> sampleEvents() {
  final today = DateTime.now();
  final sampleEvents = [
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: -20)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: -19)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: -18)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: -17)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: -42)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Late",
        eventDate: today.add(Duration(days: -30)),
        eventBackgroundColor: AppColors.redColor),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Late",
        eventDate: today.add(Duration(days: -7)),
        eventBackgroundColor: AppColors.redColor),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "late",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: AppColors.redColor),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: 21)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: 30)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
    CalendarEvent(
        eventName: "Att",
        eventDate: today.add(Duration(days: 42)),
        eventBackgroundColor: AppColors.defaultAppColor[500]!),
  ];
  return sampleEvents;
}
