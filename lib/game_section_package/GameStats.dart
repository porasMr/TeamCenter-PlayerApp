import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';

import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/game_section_package/model/ClubStatModel.dart';
import 'package:team_center/ui/managment_instruction_package/managment_instruaction.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';

import '../ui/professional_package/ProfessionalKnowledagePage.dart';
import '../ui/tranning_package/TimeTrainingScreen.dart';
import 'GameDetailsScreen.dart';
import 'model/StatsModel.dart';

class GameStatsScreen extends StatefulWidget {
  @override
  _GameStatsScreenState createState() => _GameStatsScreenState();
}

class _GameStatsScreenState extends State<GameStatsScreen>
    implements ApiInterface, NotificationClick {
  bool _isLoading = true;
  ScrollController controller = new ScrollController();
  ScrollController childcontroller = new ScrollController();
  ScrollController timeController = new ScrollController();

  ScrollController controllerTop = new ScrollController();
  ScrollController controllerBottom = new ScrollController();
  List<StatsData> statList = new List.empty(growable: true);
  String whichApiCall = "clubStat";
  bool isReverse = false;
  List<String> list = new List.empty(growable: true);
  ClubStatModel model = new ClubStatModel();
  StatsModel modle = new StatsModel();

  @override
  void initState() {
    super.initState();
    if (CommonMethod.appLanguage() == "English") {
      list.add("Min");
      list.add("Goals");
      list.add("Assists");
      list.add("Steals");
      list.add("Rescue");
      list.add("Foul");
      list.add("Ball loss");
      list.add("Yellow");
      list.add("Red");
    } else {
      list.add("דקות");
      list.add("שערים");
      list.add("בישולים");
      list.add("חטיפות");
      list.add("חילוצים");
      list.add("עבירות");
      list.add("איבודים");
      list.add("צהוב");
      list.add("אדום");
    }

    controller.addListener(() {
      controllerTop.position.setPixels(controller.position.pixels);
      controllerBottom.position.setPixels(controller.position.pixels);

      setState(() {});
    });
    // hundler();
    hundler();
    ApiCall.clubStat(this, context);
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
    controller.dispose();
    controllerTop.dispose();
    controllerBottom.dispose();
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
                                  .find('GameStats'),
                              AppColors.blue,
                              FontWeight.normal,
                              "rubikregular",
                              1),
                        ),
                      ]),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(height: 1, color: AppColors.strokeColor),
                Expanded(
                    flex: 1,
                    child: _isLoading == true
                        ? Container()
                        : Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    gameText(),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            color: AppColors.backColors,
                                            width: model.data!.length * 75,
                                            height: 60,
                                            child: stateListing()))
                                  ],
                                ),
                              ),
                              Container(height: 1, color: AppColors.mediumGrey),
                              Expanded(
                                  flex: 1,
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 125,
                                            height:
                                                modle.playerStat!.length * 65,
                                            child: gameTimeingListing(),
                                          ),
                                          Expanded(flex: 1, child: playerData())
                                        ],
                                      ),
                                    ],
                                  )),
                              Container(height: 1, color: AppColors.mediumGrey),
                              Container(
                                child: Row(
                                  children: [
                                    averageText(),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            color: AppColors.backColors,
                                            width: MediaQuery.of(context)
                                                .size
                                                .height,
                                            height: 60,
                                            child: totalListing()))
                                  ],
                                ),
                              )
                            ],
                          ))
              ],
            ),
          )),
    );
  }

  gameText() {
    return Container(
      width: 125,
      height: 60,
      alignment: CommonMethod.appLanguage() == "English"
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.strokeColor),
          color: AppColors.backColors,
          boxShadow: [
            BoxShadow(
              color: AppColors.mediumGrey,
              blurRadius: 30.0, // soften the shadow
              offset: Offset(
                4.0, // Move to right 10  horizontally
                4.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: AppTextSize.textSize14(
          TeamCenterLocalizations.of(context)!.find('Games'),
          Colors.black,
          FontWeight.w500,
          "rubikregular",
          1),
    );
  }

  averageText() {
    return Container(
      width: 125,
      height: 60,
      alignment: CommonMethod.appLanguage() == "English"
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.strokeColor),
          color: AppColors.backColors,
          boxShadow: [
            BoxShadow(
              color: AppColors.mediumGrey,
              blurRadius: 30.0, // soften the shadow
              offset: Offset(
                4.0, // Move to right 10  horizontally
                4.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: AppTextSize.textSize14(
          TeamCenterLocalizations.of(context)!.find('Average'),
          Colors.black,
          FontWeight.w500,
          "rubikregular",
          1),
    );
  }

  totalListing() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        controller: controllerBottom,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.data!.length,
        itemBuilder: (context, position) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 59,
                width: 75,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: AppTextSize.textSize12(
                          modle.playerStat!
                                      .where((c) =>
                                          c.stats![position].value!.length != 0)
                                      .toList()
                                      .length ==
                                  0
                              ? "-"
                              : (modle.playerStat!
                                          .map((m) =>
                                              m.stats![position].value!.length != 0
                                                  ? double.parse(
                                                      m.stats![position].value!)
                                                  : 0)
                                          .reduce((a, b) => a + b) /
                                      modle.playerStat!
                                          .where((c) =>
                                              c.stats![position].value!.length != 0)
                                          .toList()
                                          .length)
                                  .ceil()
                                  .toString(),
                          Colors.black,
                          FontWeight.w500,
                          "rubikregular",
                          2),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  stateListing() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        controller: controllerTop,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.data!.length,
        itemBuilder: (context, position) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 59,
                width: 75,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        modle.playerStat = modle.playerStat!.reversed.toList();
                        if (isReverse == false) {
                          isReverse = true;
                        } else {
                          isReverse = false;
                        }
                        setState(() {});
                      },
                      child: AppTextSize.textSize12(model.data![position].name!,
                          Colors.black, FontWeight.w500, "rubikregular", 2),
                    ),
                    position == 0
                        ? isReverse == true
                            ? Icon(Icons.arrow_upward,
                                color: AppColors.blue, size: 24)
                            : Icon(Icons.arrow_downward,
                                color: AppColors.blue, size: 24)
                        : Container()
                  ],
                ),
              ),
            ],
          );
        });
  }

  gameTimeingListing() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: modle.playerStat!.length,
        itemBuilder: (context, position) {
          return Row(
            children: [
              Container(
                width: 125,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.strokeColor),
                    color: AppColors.backColors,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mediumGrey,
                        blurRadius: 30.0, // soften the shadow
                        offset: Offset(
                          4.0, // Move to right 10  horizontally
                          4.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextSize.textSize12(
                              CommonMethod.dateStatRetrun(
                                  modle.playerStat![position].date!),
                              Colors.black,
                              FontWeight.w500,
                              "rubikregular",
                              1),
                          SizedBox(height: 5),
                          modle.playerStat![position].status == "win"
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 6, right: 6, top: 3, bottom: 3),
                                  decoration: BoxDecoration(
                                      color: AppColors.defaultAppColor[500],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: AppTextSize.textSize10(
                                      TeamCenterLocalizations.of(context)!
                                          .find('WIN'),
                                      AppColors.whiteColor[500]!,
                                      FontWeight.normal,
                                      "rubikregular",
                                      1),
                                )
                              : modle.playerStat![position].status == "loss"
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: 6, right: 6, top: 3, bottom: 3),
                                      decoration: BoxDecoration(
                                          color: AppColors.redColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: AppTextSize.textSize10(
                                          TeamCenterLocalizations.of(context)!
                                              .find('LOSS'),
                                          AppColors.whiteColor[500]!,
                                          FontWeight.normal,
                                          "rubikregular",
                                          1),
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 6, right: 6, top: 3, bottom: 3),
                                      decoration: BoxDecoration(
                                          color: AppColors.orangeColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: AppTextSize.textSize10(
                                          TeamCenterLocalizations.of(context)!
                                              .find('TIE'),
                                          AppColors.whiteColor[500]!,
                                          FontWeight.normal,
                                          "rubikregular",
                                          1),
                                    )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.mediumGrey,
                                          blurRadius: 2.0, // soften the shadow
                                          offset: Offset(
                                            1.0, // Move to right 10  horizontally
                                            1.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  child: AppTextSize.textSize10(
                                      modle.playerStat![position].revelTeamScore
                                          .toString(),
                                      AppColors.appGreyColor[500]!,
                                      FontWeight.normal,
                                      "rubikregular",
                                      1),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                AppTextSize.textSize10(
                                    ":",
                                    AppColors.appGreyColor[500]!,
                                    FontWeight.normal,
                                    "rubikregular",
                                    1),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.mediumGrey,
                                          blurRadius: 2.0, // soften the shadow
                                          offset: Offset(
                                            1.0, // Move to right 10  horizontally
                                            1.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  child: AppTextSize.textSize10(
                                      modle.playerStat![position].myTeamScore
                                          .toString(),
                                      AppColors.appGreyColor[500]!,
                                      FontWeight.normal,
                                      "rubikregular",
                                      1),
                                ),
                              ],
                            ),
                            Flexible(
                              child: AppTextSize.textSize14(
                                  modle.playerStat![position].rival!,
                                  Colors.black,
                                  FontWeight.w500,
                                  "rubikregular",
                                  1),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          );
        });
  }

  playerData() {
    return Container(
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        child: Container(
          width: model.data!.length * 75,
          height: modle.playerStat!.length * 65,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 75,
                  height: modle.playerStat!.length * 65,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: modle.playerStat!.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, position) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  width: 75,
                                  height: 59,
                                  color: AppColors.backColors,
                                  alignment: Alignment.center,
                                  child: AppTextSize.textSize12(
                                      modle.playerStat![position].stats![index]
                                                  .value!.length ==
                                              0
                                          ? "-"
                                          : modle.playerStat![position]
                                              .stats![index].value!,
                                      Colors.black,
                                      FontWeight.w500,
                                      "rubikregular",
                                      1)),
                              Container(
                                  width: 75,
                                  height: 1,
                                  color: AppColors.mediumGrey),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }

  @override
  void onFailure(message) {
    Navigator.pop(context);
    _isLoading = false;
    setState(() {});
  }

  @override
  void onSuccess(data) {
    print(data);
    if (whichApiCall == "clubStat") {
      model = new ClubStatModel.fromJson(data);
      whichApiCall = "";

      ApiCall.gameState(this, context);
    } else {
      _isLoading = false;
      modle = new StatsModel.fromJson(data);
      statList = new StatsModel.fromJson(data).data!;

      Navigator.pop(context);
    }
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
    } else {
      Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: TimeTrainingScreen()))
          .then((value) {});
    }
  }

  @override
  void updateBadge(id, String type) {}
}
