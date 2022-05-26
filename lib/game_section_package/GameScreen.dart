import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';

import 'package:team_center/game_section_package/GameStats.dart';
import 'package:team_center/ui/managment_instruction_package/managment_instruaction.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/cell_calender_package/src/calendar_event.dart';
import 'package:team_center/utils/cell_calender_package/src/cell_calendar.dart';
import 'package:team_center/utils/cell_calender_package/src/controllers/cell_calendar_page_controller.dart';
import 'package:team_center/utils/sample_game_event.dart';

import 'GameDetailsScreen.dart';
import 'model/GameListingModel.dart';
import 'package:team_center/utils/globals.dart' as globals;

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    implements ApiInterface, NotificationClick {
  //final _sampleEvents = sampleGameEvents();
  final cellCalendarPageController = CellCalendarPageController();
  GameListingModel model = new GameListingModel();
  List<CalendarEvent> _sampleEvents = new List.empty(growable: true);
  var selectedEvent;

  @override
  void initState() {
    super.initState();
    hundler();
    ApiCall.fetchGameList(this, context);
    CommonMethod.initPlatformState(this);
  }

  hundler() async {
    Timer(Duration(microseconds: 100), () {
      CommonMethod.dialogLoader(context);
    });
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
                            Navigator.pop(context);
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
                                  .find('Games'),
                              AppColors.blue,
                              FontWeight.normal,
                              "rubikregular",
                              1),
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: GameStatsScreen()));
                          },
                          child: AppTextSize.textSize18(
                              TeamCenterLocalizations.of(context)!
                                  .find('Stats'),
                              AppColors.blue,
                              FontWeight.normal,
                              "rubikregular",
                              1),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        // CommonMethod.gamePermission()
                        //             .subSections![0]
                        //             .permission!
                        //             .edit ==
                        //         0
                        //     ? Container()
                        //     : InkWell(
                        //         onTap: () {
                        //           Navigator.push(
                        //                   context,
                        //                   PageTransition(
                        //                       type: PageTransitionType.fade,
                        //                       child: CreateNewGameScreen()))
                        //               .then((value) {
                        //             hundler();
                        //             ApiCall.fetchGameList(
                        //                 globals.groupId, this, context);
                        //           });
                        //         },
                        //         child: AppTextSize.textSize18(
                        //             TeamCenterLocalizations.of(context)!
                        //                 .find('New'),
                        //             AppColors.blue,
                        //             FontWeight.normal,
                        //             "rubikregular",
                        //             1),
                        //       ),
                        // SizedBox(
                        //   width: 16,
                        // ),
                      ],
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
                            events: _sampleEvents,
                            isGameView: true,
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
                              final eventsOnTheDate =
                                  _sampleEvents.where((event) {
                                // selectedEvent = event;
                                var eventDate = event.eventDate;
                                return eventDate.year == date.year &&
                                    eventDate.month == date.month &&
                                    eventDate.day == date.day;
                              }).toList();
                              selectedEvent = null;
                              for (int i = 0; i < _sampleEvents.length; i++) {
                                if (date == _sampleEvents[i].eventDate) {
                                  selectedEvent = _sampleEvents[i].eventID;
                                  break;
                                }
                              }
                              if (selectedEvent != null) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: GameDetailsScreen(
                                          gameId: selectedEvent,
                                        ))).then((value) {
                                  hundler();
                                  ApiCall.fetchGameList(this, context);
                                });
                              }

                              // showDialog(
                              //     context: context,
                              //     builder: (_) => AlertDialog(
                              //           title: Text(CommonMethod
                              //                   .monthNameList[date.month - 1] +
                              //               " " +
                              //               date.day.toString()),
                              //           content: Column(
                              //             mainAxisSize: MainAxisSize.min,
                              //             children: eventsOnTheDate
                              //                 .map(
                              //                   (event) => Container(
                              //                     width: double.infinity,
                              //                     padding: EdgeInsets.all(4),
                              //                     margin: EdgeInsets.only(
                              //                         bottom: 12),
                              //                     color: event
                              //                         .eventBackgroundColor,
                              //                     child: Text(
                              //                       event.eventName,
                              //                       style: TextStyle(
                              //                           color: event
                              //                               .eventTextColor),
                              //                     ),
                              //                   ),
                              //                 )
                              //                 .toList(),
                              //           ),
                              //         ));
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
  void onFailure(message) {
    Navigator.pop(context);
    CommonMethod.showErrorFlushbar(context, message);
  }

  @override
  void onSuccess(data) {
    print(data);
    Navigator.pop(context);
    model = GameListingModel.fromJson(data);
    if (_sampleEvents.length > 0) {
      _sampleEvents.clear();
    }
    for (int i = 0; i < model.data!.length; i++) {
      _sampleEvents.add(
        CalendarEvent(
            eventName: model.data![i].rival!,
            eventDate: DateTime.parse(model.data![i].date!),
            time: model.data![i].status == "win" ||
                    model.data![i].status == "loss" ||
                    model.data![i].status == "tie"
                ? model.data![i].my_team_score.toString() +
                    "-" +
                    model.data![i].revel_team_score.toString()
                : model.data![i].time!,
            eventID: model.data![i].id!.toString(),
            eventBackgroundColor: model.data![i].status == "win"
                ? AppColors.defaultAppColor[500]!
                : model.data![i].status == "loss"
                    ? AppColors.redColor
                    : model.data![i].status == "tie"
                        ? AppColors.orangeColor
                        : Colors.grey,
            gameType: model.data![i].matchType!,
            gamePlace: model.data![i].gamePlace!,
            keyGame: model.data![i].keyGame == 1 ? "true" : "false",
            clubComment: model.data![i].club_comment == "null" ||
                    model.data![i].club_comment == ""
                ? false
                : true),
      );

      setState(() {});
    }
  }

  @override
  void onClick(id, type) {}

  @override
  void updateBadge(id, String type) {}
}
