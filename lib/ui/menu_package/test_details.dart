import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';

import '../../apiservice/api_call.dart';
import '../../apiservice/api_interface.dart';
import '../../game_section_package/GameDetailsScreen.dart';
import '../../utils/CommonMethod.dart';
import '../managment_instruction_package/managment_instruaction.dart';
import '../professional_package/ProfessionalKnowledagePage.dart';
import '../tranning_package/TimeTrainingScreen.dart';
import 'model/PlayerTest.dart';

class TestDetailsScreen extends StatefulWidget {
  @override
  _TestDetailsScreenState createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen>
    implements ApiInterface,NotificationClick {
  PlayerTest model = PlayerTest();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
        CommonMethod.initPlatformState(this);

    ApiCall.playerTestWithResult(this, context);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? CommonMethod.loader(context)
        : Scaffold(
            body: Container(
              color: AppColors.whiteColor[500],
              child: SafeArea(
                top: false,
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
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
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
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
                                  Navigator.pop(context);
                                },
                                child: AppTextSize.textSize20(
                                    TeamCenterLocalizations.of(context)!
                                        .find('Tests'),
                                    AppColors.blue,
                                    FontWeight.normal,
                                    "rubikregular",
                                    1),
                              ),
                            ]),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(height: 1, color: AppColors.strokeColor),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: model.data!.length,
                          itemBuilder: (context, position) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.6),
                                            blurRadius:
                                                2.0, // soften the shadow
                                            offset: Offset(
                                              0.5, // Move to right 10  horizontally
                                              0.5, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 130,
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: AppTextSize.textSize14(
                                                      model.data![position]
                                                          .name!,
                                                      Colors.black,
                                                      FontWeight.normal,
                                                      "rubikregular",
                                                      1),
                                                ),
                                                Spacer(),
                                                model
                                                            .data![position]
                                                            .testResult!
                                                            .length ==
                                                        1
                                                    ? model.data![position]
                                                                .goodResultType ==
                                                            "less"
                                                        ? SvgPicture.asset(
                                                            AppImages.down,
                                                            semanticsLabel:
                                                                'down')
                                                        : SvgPicture.asset(
                                                            AppImages.up,
                                                            semanticsLabel:
                                                                'up')
                                                    : double.parse(model
                                                                .data![position]
                                                                .testResult![0]
                                                                .number!) ==
                                                            double.parse(model
                                                                .data![position]
                                                                .testResult![1]
                                                                .number!)
                                                        ? SvgPicture.asset(
                                                            AppImages.equalArrow,
                                                            semanticsLabel: 'equal')
                                                        : model.data![position].goodResultType == "less"
                                                            ? double.parse(model.data![position].testResult![0].number!) < double.parse(model.data![position].testResult![1].number!)
                                                                ? SvgPicture.asset(AppImages.up, semanticsLabel: 'up')
                                                                : SvgPicture.asset(AppImages.down, semanticsLabel: 'down')
                                                            : double.parse(model.data![position].testResult![0].number!) < double.parse(model.data![position].testResult![1].number!)
                                                                ? SvgPicture.asset(AppImages.down, semanticsLabel: 'down')
                                                                : SvgPicture.asset(AppImages.up, semanticsLabel: 'up'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          CommonMethod.appLanguage() ==
                                                  "English"
                                              ? AppTextSize.textSize12(
                                                  TeamCenterLocalizations.of(
                                                              context)!
                                                          .find('Average') +
                                                      " " +
                                                      retrunAvg(model
                                                              .data![position]
                                                              .testResult!)
                                                          .toString() +
                                                      " " +
                                                      model.data![position]
                                                          .unitTypeEn!,
                                                  Colors.black,
                                                  FontWeight.normal,
                                                  "rubikregular",
                                                  1)
                                              : AppTextSize.textSize12(
                                                  TeamCenterLocalizations.of(
                                                              context)!
                                                          .find('Average') +
                                                      " " +
                                                      retrunAvg(model
                                                              .data![position]
                                                              .testResult!)
                                                          .toString() +
                                                      " " +
                                                      model.data![position]
                                                          .unitTypeHe!,
                                                  Colors.black,
                                                  FontWeight.normal,
                                                  "rubikregular",
                                                  1),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          CommonMethod.appLanguage() ==
                                                  "English"
                                              ? widgetEng(position)
                                              : widgetHebrew(position),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                              blurRadius:
                                                  2.0, // soften the shadow
                                              offset: Offset(
                                                0.5, // Move to right 10  horizontally
                                                0.5, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                        ),
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(6),
                                          itemCount: model.data![position]
                                              .testResult!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 120,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey[400]!),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30))),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: model.data![position]
                                                                .goodResultType ==
                                                            "less"
                                                        ? lessData(
                                                            position, index)
                                                        : maxData(
                                                            position, index),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: AppTextSize.textSize12(
                                                              CommonMethod
                                                                  .dateMonthRetrun(model
                                                                      .data![
                                                                          position]
                                                                      .testResult![
                                                                          index]
                                                                      .date!),
                                                              Colors.black,
                                                              FontWeight.normal,
                                                              "rubikregular",
                                                              1))),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  dynamic retrunAvg(List<TestResult>? data) {
    var t = 0.0;
    for (int i = 0; i < data!.length; i++) {
      t = t + double.parse(data[i].number!);
    }
    return (t / data.length).ceil();
  }

  double getMax(List<TestResult>? data) {
    var largestGeekValue = double.parse(data![0].number!);
    for (var i = 0; i < data.length; i++) {
      // Checking for largest value in the list
      if (double.parse(data[i].number!) > 0) {
        if (double.parse(data[i].number!) > largestGeekValue) {
          largestGeekValue = double.parse(data[i].number!);
        }
      }
    }

    return largestGeekValue;
  }

  double getLess(List<TestResult>? data) {
    var largestGeekValue = double.parse(data![0].number!);
    for (var i = 0; i < data.length; i++) {
      // Checking for largest value in the list
      if (double.parse(data[i].number!) > 0) {
        if (double.parse(data[i].number!) < largestGeekValue) {
          largestGeekValue = double.parse(data[i].number!);
        }
      }
    }

    return largestGeekValue;
  }

  double getListingMax(List<TestResult>? data, var p) {
    var largestGeekValue = p;
    for (var i = 0; i < data!.length; i++) {
      // Checking for largest value in the list
      if (double.parse(data[i].number!) > 0) {
        if (double.parse(data[i].number!) > largestGeekValue) {
          largestGeekValue = double.parse(data[i].number!);
        }
      }
    }
    print(largestGeekValue);

    return largestGeekValue;
  }

  double getListingLess(List<TestResult>? data, var p) {
    var largestGeekValue = p;
    for (var i = 0; i < data!.length; i++) {
      // Checking for largest value in the list
      if (double.parse(data[i].number!) > 0) {
        if (double.parse(data[i].number!) < largestGeekValue) {
          largestGeekValue = double.parse(data[i].number!);
        }
      }
    }
    print(largestGeekValue);

    return largestGeekValue;
  }

  widgetEng(int p) {
    return model.data![p].goodResultType == "less"
        ? AppTextSize.textSize12(
            TeamCenterLocalizations.of(context)!.find('Best') +
                " ${getLess(model.data![p].testResult!)} " +
                model.data![p].unitTypeEn!,
            AppColors.defaultAppColor[500]!,
            FontWeight.normal,
            "rubikregular",
            1)
        : AppTextSize.textSize12(
            TeamCenterLocalizations.of(context)!.find('Best') +
                " ${getMax(model.data![p].testResult!)} " +
                model.data![p].unitTypeEn!,
            AppColors.defaultAppColor[500]!,
            FontWeight.normal,
            "rubikregular",
            1);
  }

  widgetHebrew(int p) {
    print(model.data![p].goodResultType);
    return model.data![p].goodResultType == "less"
        ? AppTextSize.textSize12(
            TeamCenterLocalizations.of(context)!.find('Best') +
                " ${getLess(model.data![p].testResult!)} " +
                model.data![p].unitTypeHe!,
            AppColors.defaultAppColor[500]!,
            FontWeight.normal,
            "rubikregular",
            1)
        : AppTextSize.textSize12(
            TeamCenterLocalizations.of(context)!.find('Best') +
                " ${getMax(model.data![p].testResult!)} " +
                model.data![p].unitTypeHe!,
            AppColors.defaultAppColor[500]!,
            FontWeight.normal,
            "rubikregular",
            1);
  }

  lessData(int parentP, int childP) {
    return getListingLess(model.data![parentP].testResult!, double.parse(model.data![parentP].testResult![childP].number!)) == double.parse(model.data![parentP].testResult![childP].number!) &&
            getListingLess(model.data![parentP].testResult!, double.parse(model.data![parentP].testResult![childP].number!)) !=
                0.0
        ? Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.defaultAppColor[500]!,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: AppTextSize.textSize14(
                "${model.data![parentP].testResult![childP].number!}",
                Colors.white,
                FontWeight.normal,
                "rubikregular",
                1))
        : getListingMax(model.data![parentP].testResult!, double.parse(model.data![parentP].testResult![childP].number!)) == double.parse(model.data![parentP].testResult![childP].number!) &&
                getListingMax(model.data![parentP].testResult!, double.parse(model.data![parentP].testResult![childP].number!)) !=
                    0.0
            ? Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: AppTextSize.textSize14(
                    "${model.data![parentP].testResult![childP].number!}",
                    Colors.white,
                    FontWeight.normal,
                    "rubikregular",
                    1))
            : model.data![parentP].testResult![childP].number == "0"
                ? Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: AppTextSize.textSize14("-", Colors.black, FontWeight.normal, "rubikregular", 1))
                : Container(width: 60, height: 60, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(30))), child: AppTextSize.textSize14("${model.data![parentP].testResult![childP].number!}", Colors.black, FontWeight.normal, "rubikregular", 1));
  }

  maxData(int parentP, int childP) {
    return getListingMax(model.data![parentP].testResult!, double.parse(model.data![parentP].testResult![childP].number!)) == double.parse(model.data![parentP].testResult![childP].number!) &&
            getListingMax(model.data![parentP].testResult!, double.parse(model.data![parentP].testResult![childP].number!)) !=
                0.0
        ? Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.defaultAppColor[500]!,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: AppTextSize.textSize14(
                "${model.data![parentP].testResult![childP].number!}",
                Colors.white,
                FontWeight.normal,
                "rubikregular",
                1))
        : getListingLess(model.data![parentP].testResult!, double.parse(model.data![parentP].testResult![childP].number!)) == double.parse(model.data![parentP].testResult![childP].number!) &&
                getListingLess(model.data![parentP].testResult!, double.parse(model.data![parentP].testResult![childP].number!)) !=
                    0.0
            ? Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: AppTextSize.textSize14(
                    "${model.data![parentP].testResult![childP].number!}",
                    Colors.white,
                    FontWeight.normal,
                    "rubikregular",
                    1))
            : model.data![parentP].testResult![childP].number == "0"
                ? Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: AppTextSize.textSize14("-", Colors.black, FontWeight.normal, "rubikregular", 1))
                : Container(width: 60, height: 60, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(30))), child: AppTextSize.textSize14("${model.data![parentP].testResult![childP].number!}", Colors.black, FontWeight.normal, "rubikregular", 1));
  }

  @override
  void onFailure(message) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onSuccess(data) {
    model = new PlayerTest.fromJson(data);
    setState(() {
      isLoading = false;
    });
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
    }else if (type == "professional_knowledge") {
      Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ProfessionalKnowledagePage(id: id, type: type)))
          .then((value) {
       
      });
    }
     else {
      Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: TimeTrainingScreen()))
          .then((value) {});
    }
  }

  
  @override
  void updateBadge(id, String type) {
    // TODO: implement updateBadge
  }
}
