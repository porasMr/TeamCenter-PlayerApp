import 'package:flutter/material.dart';

/// DataModel of event
///
/// [eventName] and [eventDate] is essential to show in [CellCalendar]
class CalendarEvent {
  CalendarEvent(
      {required this.eventName,
      required this.eventDate,
      this.time = "10.00",
      this.endTime = "10.00",
      this.eventBackgroundColor = Colors.blue,
      this.eventTextColor = Colors.white,
      this.eventID,
      this.gamePlace,
      this.gameType = "cup",
      this.keyGame = "true",
      this.clubComment = false});

  final String time;
  final String endTime;

  final String gameType;
  var gamePlace;

  final String keyGame;
  bool clubComment;

  final String eventName;
  final DateTime eventDate;
  final String? eventID;
  final Color eventBackgroundColor;
  final Color eventTextColor;
}
