import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/ui/managment_instruction_package/managment_instruaction.dart';

import 'package:team_center/ui/tranning_package/TrainingScreen.dart';
import 'package:team_center/ui/tranning_package/model/TrainingModel.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';

import '../../game_section_package/GameDetailsScreen.dart';
import '../professional_package/ProfessionalKnowledagePage.dart';

class TimeTrainingScreen extends StatefulWidget {
  @override
  _TimeTrainingScreenState createState() => _TimeTrainingScreenState();
}

class _TimeTrainingScreenState extends State<TimeTrainingScreen>
    implements ApiInterface, NotificationClick {
  TrainingModel model = new TrainingModel();
  List<Data> trainingData = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    hundler();
    ApiCall.trainingList(this, context);
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
                              Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: TrainingScreen(
                                              trainingData: trainingData)))
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pop(context);
                                } else {}
                              });
                            },
                            child: Image.asset(
                              AppImages.cal,
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
                          child: SfCalendar(
                            //cellBorderColor: Colors.white,

                            view: CalendarView.week,
                            // selectionDecoration: BoxDecoration(
                            //   color: Colors.transparent,
                            //   border: Border.all(
                            //     color: Colors.white,
                            //   ),
                            //   borderRadius:
                            //       const BorderRadius.all(Radius.circular(4)),
                            //   shape: BoxShape.rectangle,
                            // ),
                            dataSource: _getCalendarDataSource(),
                            onSelectionChanged: (v) {},
                            onTap: (v) {
                              if (v.appointments != null) {
                                for (int i = 0; i < trainingData.length; i++) {
                                  if (trainingData[i].date ==
                                          DateFormat('yyyy-MM-dd')
                                              .format(v.date!) &&
                                      trainingData[i].fromTime ==
                                          DateFormat('HH:mm').format(
                                              v.appointments![0].startTime) &&
                                      trainingData[i].untillTime ==
                                          DateFormat('HH:mm').format(
                                              v.appointments![0].endTime)) {
                                    setState(() {});
                                    detailsDiloag(trainingData[i]);
                                    break;
                                  }
                                }
                              } else {}
                            },

                            timeSlotViewSettings: TimeSlotViewSettings(
                                timeIntervalHeight: 20,
                                timeInterval: Duration(minutes: 30),
                                timeFormat: 'HH:mm',
                                minimumAppointmentDuration:
                                    Duration(minutes: 10)),
                          ),
                        )))
              ],
            ),
          )),
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    if (trainingData.length != 0) {
      for (int i = 0; i < trainingData.length; i++) {
        appointments.add(Appointment(
          startTime: DateTime.parse(
              "${trainingData[i].date} ${trainingData[i].fromTime}"),
          endTime: DateTime.parse(
              "${trainingData[i].date} ${trainingData[i].untillTime}"),
          subject: trainingData[i].field!.name!,
          color: Color(int.parse(
              "0xFFF${trainingData[i].field!.color!.replaceAll("#", "")}")),
          startTimeZone: '',
          endTimeZone: '',
        ));
      }
    }

    return _AppointmentDataSource(appointments);
  }

  @override
  void onFailure(message) {
    Navigator.pop(context);
    CommonMethod.showErrorFlushbar(context, message);
  }

  @override
  void onSuccess(data) {
    Navigator.pop(context);
    model = new TrainingModel.fromJson(data);
    trainingData = model.data!;
    setState(() {});
  }

  @override
  void onClick(id, type) {
    if (type == "game") {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: GameDetailsScreen(
                gameId: id,
              ))).then((value) {
        setState(() {});
      });
    } else if (type == "game_instruction" || type == "training_instruction") {
      Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ManagmentInstructionScreen(id: id, type: type)))
          .then((value) {});
    } else if (type == "professional_knowledge") {
      Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ProfessionalKnowledagePage(id: id, type: type)))
          .then((value) {});
    } else {}
  }

  @override
  void updateBadge(id, String type) {}
  void detailsDiloag(Data traning) {
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
                    traning.date! +
                        " " +
                        traning.fromTime! +
                        "-" +
                        traning.untillTime!,
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
                      color: Color(int.parse(
                          "0xFFF${traning.field!.color!.replaceAll("#", "")}"))),
                  child: AppTextSize.textSize14(
                      traning.field!.name!,
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

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
