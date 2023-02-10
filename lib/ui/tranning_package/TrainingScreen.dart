import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team_center/ui/managment_instruction_package/managment_instruaction.dart';
import 'package:team_center/ui/tranning_package/PlanScreen.dart';
import 'package:team_center/ui/tranning_package/TimeTrainingScreen.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/cell_calender_package/src/calendar_event.dart';
import 'package:team_center/utils/cell_calender_package/src/cell_calendar.dart';
import 'package:team_center/utils/cell_calender_package/src/controllers/cell_calendar_page_controller.dart';
import 'package:team_center/utils/trainner_sample_event.dart';

import 'model/TrainingModel.dart';

class TrainingScreen extends StatefulWidget {
  List<Data>? trainingData;
  TrainingScreen({this.trainingData});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen>
    implements NotificationClick {
  final cellCalendarPageController = CellCalendarPageController();
  List<CalendarEvent> events = new List.empty(growable: true);
  var name = "";
  var selectedEvent;
  var selectedDate;
  var fromTime;
  var untilTime;

  @override
  void initState() {
    super.initState();
    name = setCalenderData();
    CommonMethod.initPlatformState(this);
  }

  setCalenderData() {
    if (events.length > 0) {
      events.clear();
    }
    for (int i = 0; i < widget.trainingData!.length; i++) {
      events.add(CalendarEvent(
          eventName: widget.trainingData![i].field!.name!,
          eventDate: DateTime.parse(widget.trainingData![i].date!),
          time: widget.trainingData![i].fromTime!,
          endTime: widget.trainingData![i].untillTime!,
          eventID: widget.trainingData![i].id.toString(),
          eventBackgroundColor: Color(int.parse(
              "0xFFF${widget.trainingData![i].field!.color!.replaceAll("#", "")}")),
          clubComment: widget.trainingData![i].club_comment == "null" ||
                  widget.trainingData![i].club_comment == ""
              ? false
              : true));
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor[500],
      body: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, true);
                          },
                          child: Icon(Icons.arrow_back_ios,
                              size: 24, color: AppColors.blue),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, true);
                          },
                          child: AppTextSize.textSize20(
                              TeamCenterLocalizations.of(context)!
                                  .find('Training'),
                              AppColors.blue,
                              FontWeight.normal,
                              "rubikregular",
                              1),
                        ),
                      ]),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: Image.asset(
                              AppImages.clock,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(height: 1, color: AppColors.strokeColor),
                Flexible(
                    flex: 1,
                    child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: CellCalendar(
                            cellCalendarPageController:
                                cellCalendarPageController,
                            events: events,
                            isGameView: false,
                            daysOfTheWeekBuilder: (dayIndex) {
                              final labels =
                                  CommonMethod.appLanguage() == "English"
                                      ? [
                                          "Sun",
                                          "Mon",
                                          "Tue",
                                          "Wed",
                                          "Thu",
                                          "Fri",
                                          "Sat"
                                        ]
                                      : [
                                          "ראשון",
                                          "שני",
                                          "שלישי",
                                          "רביעי",
                                          "חמישי",
                                          "שישי",
                                          "שבת"
                                        ];
                              return Container(
                                  alignment: Alignment.center,
                                  child: AppTextSize.textSize12(
                                      labels[dayIndex],
                                      Colors.black,
                                      FontWeight.normal,
                                      "rubikregular",
                                      1));
                            },
                            monthYearLabelBuilder: (datetime) {
                              final year = datetime!.year.toString();
                              final month =
                                  CommonMethod.appLanguage() == "English"
                                      ? CommonMethod
                                          .monthNameListEng[datetime.month - 1]
                                      : CommonMethod
                                          .monthNameList[datetime.month - 1];
                              return Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // const SizedBox(width: 16),
                                    AppTextSize.textSize18(
                                        "$month  $year",
                                        Colors.black,
                                        FontWeight.normal,
                                        "rubikregular",
                                        1)

                                    // const Spacer(),
                                    // IconButton(
                                    //   padding: EdgeInsets.zero,
                                    //   icon: Icon(Icons.calendar_today),
                                    //   onPressed: () {
                                    //     cellCalendarPageController
                                    //         .animateToDate(
                                    //       DateTime.now(),
                                    //       curve: Curves.linear,
                                    //       duration: Duration(milliseconds: 300),
                                    //     );
                                    //   },
                                    // )
                                  ],
                                ),
                              );
                            },
                            onCellTapped: (date) {
                              final eventsOnTheDate = events.where((event) {
                                final eventDate = event.eventDate;
                                return eventDate.year == date.year &&
                                    eventDate.month == date.month &&
                                    eventDate.day == date.day;
                              }).toList();
                              selectedEvent = null;
                              fromTime = null;
                              selectedDate = null;
                              untilTime = null;
                              for (int i = 0; i < events.length; i++) {
                                if (date == events[i].eventDate) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text(
                                                CommonMethod.monthNameList[
                                                        date.month - 1] +
                                                    " " +
                                                    date.day.toString()),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: eventsOnTheDate
                                                  .map(
                                                    (event) => InkWell(
                                                      onTap: () {
                                                        for (int i = 0;
                                                            i < events.length;
                                                            i++) {
                                                          if (event.eventDate ==
                                                                  events[i]
                                                                      .eventDate &&
                                                              event.time ==
                                                                  events[i]
                                                                      .time) {
                                                            selectedEvent =
                                                                events[i]
                                                                    .eventID;
                                                            selectedDate =
                                                                events[i]
                                                                    .eventDate;
                                                            fromTime =
                                                                events[i].time;
                                                            untilTime =
                                                                events[i]
                                                                    .endTime;
                                                            break;
                                                          }
                                                        }
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                type:
                                                                    PageTransitionType
                                                                        .fade,
                                                                child:
                                                                    PlanScreen(
                                                                  trainingId:
                                                                      selectedEvent,
                                                                  fromTime:
                                                                      fromTime,
                                                                  untillTime:
                                                                      untilTime,
                                                                ))).then(
                                                            (value) {});
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 12,
                                                                    top: 4),
                                                            color: event
                                                                .eventBackgroundColor,
                                                            child: Text(
                                                              event.eventName,
                                                              style: TextStyle(
                                                                  color: event
                                                                      .eventTextColor),
                                                            ),
                                                          ),
                                                          event.clubComment ==
                                                                  false
                                                              ? Container()
                                                              : Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 20,
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      Container(
                                                                    width: 12,
                                                                    height: 12,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: AppColors
                                                                              .defaultAppColor[
                                                                          500],
                                                                    ),
                                                                  ),
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ));
                                  selectedEvent = events[i].eventID;
                                  break;
                                }
                              }
                              if (selectedEvent == null) {}
                            },
                            onPageChanged: (firstDate, lastDate) {
                              /// Called when the page was changed
                              /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
                            },
                          ),
                        )))
              ],
            ),
          )),
    );
  }

  @override
  void onClick(id, type) {}

  @override
  void updateBadge(id, String type) {}

  void detailsDiloag(String date, String time, Color color, String name) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 2.0,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    date + " " + time,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'rubikregular',
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0,
                        height: 1.5),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 80,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: color),
                  child: AppTextSize.textSize14(
                      name,
                      AppColors.whiteColor[500]!,
                      FontWeight.normal,
                      "rubikregular",
                      1),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.mediumGrey,
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            alignment: Alignment.center,
                            height: 50,
                            child: Text(
                              TeamCenterLocalizations.of(context)!
                                  .find('close'),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'rubikregular',
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.normal),
                            ),
                          ))
                    ]),
              ]),
            ),
          );
        });
  }
}
