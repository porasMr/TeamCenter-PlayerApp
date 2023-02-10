import 'dart:async';
import 'dart:convert' show jsonDecode, json;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/apiservice/key_string.dart';
import 'package:team_center/apiservice/url_string.dart';
import 'package:team_center/game_section_package/GameScreen.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/play_video.dart';
import 'package:team_center/utils/shared_preferences.dart';
import 'package:team_center/utils/globals.dart' as globals;

import '../../game_section_package/GameDetailsScreen.dart';
import '../../game_section_package/GameStats.dart';
import '../managment_instruction_package/InAppWebViewExampleScreen.dart';
import '../managment_instruction_package/managment_instruaction.dart';
import '../menu_package/MenuPage.dart';
import '../menu_package/PlayerObjectiveScreen.dart';
import '../menu_package/account.dart';
import '../professional_package/ProfessionalDetail.dart';
import '../professional_package/ProfessionalKnowledagePage.dart';
import '../tranning_package/PlanScreen.dart';
import '../tranning_package/TimeTrainingScreen.dart';
import 'model/HomePageModel.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin
    implements ApiInterface, NotificationClick {
  // bool isLoading = true;
  List<int> statistic = new List.empty(growable: true);

  List<String> days = [
    "ראשון",
    "שני",
    "שלישי",
    "רביעי",
    "חמישי",
    "שישי",
    "שבת"
  ];
  HomePageModel model = HomePageModel();
  bool isLoader = true;
  int maxValue = 0;
  int totalCount = 0;
  List<String> daysEng = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
// In initState()
  @override
  void initState() {
    super.initState();
    CommonMethod.initPlatformState(this);
    hundler();
    ApiCall.homepageData(this, context);
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

  Future<void> onRefresh() async {
    hundler();
    ApiCall.homepageData(this, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor[500],
      body: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 16.0, // soften the shadow
                      offset: Offset(
                        2.0, // Move to right 10  horizontally
                        2.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: AccountScreen()))
                                    .then((value) {
                                  setState(() {
                                    CommonMethod.initPlatformState(this);

                                    hundler();
                                    ApiCall.homepageData(this, context);
                                  });
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      padding: EdgeInsets.all(1.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            CommonMethod.clubLogoImage() ==
                                                    "null"
                                                ? ""
                                                : CommonMethod.clubLogoImage()!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 70,
                                          height: 70,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                                width: 70,
                                                height: 70,
                                                child:
                                                    Icon(Icons.perm_identity)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20, left: 40),
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      padding: EdgeInsets.all(1.0),
                                      child: CachedNetworkImage(
                                        imageUrl: CommonMethod.profileImage() ==
                                                "null"
                                            ? ""
                                            : CommonMethod.profileImage()!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                                width: 50,
                                                height: 50,
                                                child:
                                                    Icon(Icons.perm_identity)),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextSize.textSize18(
                                TeamCenterLocalizations.of(context)!
                                    .find('team_center'),
                                Colors.black,
                                FontWeight.normal,
                                "rubikregular",
                                1),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: MenuScreen()))
                                    .then((value) {
                                  setState(() {
                                    CommonMethod.initPlatformState(this);

                                    hundler();
                                    ApiCall.homepageData(this, context);
                                  });
                                });
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset(
                                        AppImages.menu,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    globals.totalCount == 0
                                        ? Container(
                                            width: 30,
                                            height: 30,
                                          )
                                        : Container(
                                            width: 30,
                                            height: 30,
                                            alignment:
                                                CommonMethod.appLanguage() ==
                                                        "English"
                                                    ? Alignment.topRight
                                                    : Alignment.topLeft,
                                            margin:
                                                CommonMethod.appLanguage() ==
                                                        "English"
                                                    ? EdgeInsets.only(left: 5)
                                                    : EdgeInsets.only(right: 5),
                                            child: Container(
                                              width: 20,
                                              height: 13,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: AppColors
                                                    .defaultAppColor[500]!,
                                              ),
                                              child: Text(
                                                "$totalCount",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              isLoader
                  ? Container()
                  : Expanded(
                      flex: 1,
                      child: RefreshIndicator(
                        onRefresh: onRefresh,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            model.data!.nextGameObjective != null
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AppTextSize.textSize18(
                                                TeamCenterLocalizations.of(
                                                        context)!
                                                    .find('nextGameObjectives'),
                                                AppColors.blackColor[500]!,
                                                FontWeight.bold,
                                                "rubikregular",
                                                1),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child:
                                                            GameDetailsScreen(
                                                          gameId: model
                                                              .data!
                                                              .nextGameObjective!
                                                              .id
                                                              .toString(),
                                                        ))).then((value) {
                                                  CommonMethod
                                                      .initPlatformState(this);

                                                  hundler();
                                                  ApiCall.homepageData(
                                                      this, context);
                                                });
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      AppImages.games,
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  child:
                                                                      GameDetailsScreen(
                                                                    gameId: model
                                                                        .data!
                                                                        .nextGameObjective!
                                                                        .id
                                                                        .toString(),
                                                                  ))).then(
                                                              (value) {
                                                            CommonMethod
                                                                .initPlatformState(
                                                                    this);

                                                            hundler();
                                                            ApiCall
                                                                .homepageData(
                                                                    this,
                                                                    context);
                                                          });
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            AppTextSize.textSize16(
                                                                "${CommonMethod.dateRetrun(model.data!.nextGameObjective!.date!)} ${model.data!.nextGameObjective!.time!} ${model.data!.nextGameObjective!.rival}",
                                                                AppColors
                                                                        .blackColor[
                                                                    500]!,
                                                                FontWeight
                                                                    .normal,
                                                                "rubikregular",
                                                                1),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            model
                                                                        .data!
                                                                        .nextGameObjective!
                                                                        .playerObjective!
                                                                        .length ==
                                                                    0
                                                                ? Container()
                                                                : Flexible(
                                                                    flex: 1,
                                                                    child: AppTextSize.textSizeShortDesc12(
                                                                        playerObjectiveAccordingToModel(),
                                                                        AppColors
                                                                            .selectedGrey,
                                                                        FontWeight
                                                                            .normal,
                                                                        "rubikregular",
                                                                        2),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Icons.chevron_right,
                                                      size: 20,
                                                      color: AppColors
                                                          .selectedGrey,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                                height: 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color:
                                                    AppColors.appGreyColor[50]!)
                                          ]),
                                    ),
                                  )
                                : Container(),
                            model.data!.game!.length == 0
                                ? Container()
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          children: [
                                            AppTextSize.textSize16(
                                                TeamCenterLocalizations.of(
                                                        context)!
                                                    .find('nextGame'),
                                                AppColors.appGreyColor[500]!,
                                                FontWeight.bold,
                                                "rubikregular",
                                                1),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                GameScreen()))
                                                    .then((value) {
                                                  CommonMethod
                                                      .initPlatformState(this);

                                                  hundler();
                                                  ApiCall.homepageData(
                                                      this, context);
                                                });
                                              },
                                              child: Icon(
                                                Icons.more_vert,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 170,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: model.data!.game!.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Stack(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              GameDetailsScreen(
                                                            gameId: model.data!
                                                                .game![index].id
                                                                .toString(),
                                                          ))).then((value) {
                                                    CommonMethod
                                                        .initPlatformState(
                                                            this);

                                                    hundler();
                                                    ApiCall.homepageData(
                                                        this, context);
                                                  });
                                                },
                                                child: Container(
                                                  height: 150,
                                                  width: 150,
                                                  margin: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 18),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16)),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: model
                                                                    .data!
                                                                    .game![
                                                                        index]
                                                                    .gamePlace ==
                                                                "home game"
                                                            ? AppColors
                                                                    .defaultAppColor[
                                                                500]!
                                                            : AppColors.blue),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.6),
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
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      AppTextSize.textSize14(
                                                          model
                                                                  .data!
                                                                  .game![index]
                                                                  .time! +
                                                              " " +
                                                              CommonMethod
                                                                  .dateRetrun(model
                                                                      .data!
                                                                      .game![
                                                                          index]
                                                                      .date!),
                                                          AppColors
                                                                  .appGreyColor[
                                                              500]!,
                                                          FontWeight.normal,
                                                          "rubikregular",
                                                          1),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      AppTextSize.textSize16(
                                                          model
                                                              .data!
                                                              .game![index]
                                                              .rival!,
                                                          AppColors
                                                              .blackColor[500]!,
                                                          FontWeight.normal,
                                                          "rubikregular",
                                                          1),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Container(
                                                              width: 100,
                                                              height: 35,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: model.data!.game![index].gamePlace ==
                                                                        "home game"
                                                                    ? AppColors
                                                                            .appGreyColor[
                                                                        300]!
                                                                    : Colors.grey[
                                                                        300],
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                              ),
                                                              child: AppTextSize.textSize16(
                                                                  model.data!.game![index].matchType == "Cup"
                                                                      ? TeamCenterLocalizations.of(context)!.find('Cup')
                                                                      : model.data!.game![index].matchType == "Friendly"
                                                                          ? TeamCenterLocalizations.of(context)!.find('Friendly')
                                                                          : TeamCenterLocalizations.of(context)!.find('League'),
                                                                  AppColors.whiteColor[500]!,
                                                                  FontWeight.normal,
                                                                  "rubikregular",
                                                                  1),
                                                            ),
                                                          )),
                                                      Container(
                                                        height: 30,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: model
                                                                      .data!
                                                                      .game![
                                                                          index]
                                                                      .gamePlace ==
                                                                  "home game"
                                                              ? AppColors
                                                                      .defaultAppColor[
                                                                  500]!
                                                              : Colors.blue,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          16),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          16)),
                                                        ),
                                                        child: AppTextSize.textSize14(
                                                            model.data!.game![index].gamePlace ==
                                                                    "home game"
                                                                ? TeamCenterLocalizations.of(
                                                                        context)!
                                                                    .find(
                                                                        'Homegame')
                                                                : TeamCenterLocalizations.of(
                                                                        context)!
                                                                    .find(
                                                                        'Awaygame'),
                                                            AppColors
                                                                    .whiteColor[
                                                                500]!,
                                                            FontWeight.normal,
                                                            "rubikregular",
                                                            1),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              model.data!.game![index]
                                                          .keyGame ==
                                                      1
                                                  ? Container(
                                                      width: 150,
                                                      height: 150,
                                                      alignment:
                                                          Alignment.topCenter,
                                                      margin: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                      ),
                                                      child: Icon(
                                                        Icons.star,
                                                        size: 30,
                                                        color: Colors.amber,
                                                      ))
                                                  : Container(),
                                              model.data!.game![index]
                                                          .club_comment !=
                                                      "null"
                                                  ? Container(
                                                      width: 150,
                                                      height: 150,
                                                      alignment:
                                                          Alignment.topRight,
                                                      margin: EdgeInsets.only(
                                                        top: 15,
                                                        left: 20,
                                                        right: 20,
                                                      ),
                                                      child: Icon(
                                                        Icons.circle,
                                                        size: 15,
                                                        color: Colors.green,
                                                      ))
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                model.data!.lastGame == null
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: GameDetailsScreen(
                                                    gameId: model
                                                        .data!.lastGame!.id
                                                        .toString(),
                                                  ))).then((value) {
                                            CommonMethod.initPlatformState(
                                                this);

                                            hundler();
                                            ApiCall.homepageData(this, context);
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(
                                              left: 12, right: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.6),
                                                blurRadius:
                                                    16.0, // soften the shadow
                                                offset: Offset(
                                                  2.0, // Move to right 10  horizontally
                                                  2.0, // Move to bottom 10 Vertically
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextSize.textSize16(
                                                      TeamCenterLocalizations
                                                              .of(context)!
                                                          .find('lastGame'),
                                                      AppColors
                                                          .blackColor[500]!,
                                                      FontWeight.bold,
                                                      "rubikregular",
                                                      1),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 5,
                                                        bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: model
                                                                    .data!
                                                                    .lastGame!
                                                                    .status ==
                                                                "win"
                                                            ? AppColors
                                                                    .defaultAppColor[
                                                                500]
                                                            : model
                                                                        .data!
                                                                        .lastGame!
                                                                        .status ==
                                                                    "loss"
                                                                ? Colors.red
                                                                : AppColors
                                                                    .orangeColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    child:
                                                        AppTextSize.textSize14(
                                                            model.data!.lastGame!
                                                                        .status ==
                                                                    "win"
                                                                ? TeamCenterLocalizations.of(
                                                                        context)!
                                                                    .find('WIN')
                                                                : model.data!.lastGame!
                                                                            .status ==
                                                                        "loss"
                                                                    ? TeamCenterLocalizations.of(
                                                                            context)!
                                                                        .find(
                                                                            'LOSS')
                                                                    : TeamCenterLocalizations.of(
                                                                            context)!
                                                                        .find(
                                                                            'TIE'),
                                                            AppColors
                                                                    .whiteColor[
                                                                500]!,
                                                            FontWeight.bold,
                                                            "rubikregular",
                                                            1),
                                                  ),
                                                  AppTextSize.textSize12(
                                                      CommonMethod.dateRetrun(
                                                              model
                                                                  .data!
                                                                  .lastGame!
                                                                  .date!) +
                                                          " " +
                                                          model.data!.lastGame!
                                                              .time!,
                                                      AppColors
                                                          .appGreyColor[500]!,
                                                      FontWeight.normal,
                                                      "rubikregular",
                                                      1),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey)),
                                                      child: AppTextSize.textSize18(
                                                          model.data!.lastGame!
                                                              .revelTeamScore
                                                              .toString(),
                                                          AppColors
                                                                  .appGreyColor[
                                                              500]!,
                                                          FontWeight.bold,
                                                          "rubikregular",
                                                          1),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    AppTextSize.textSize18(
                                                        "-",
                                                        AppColors
                                                            .appGreyColor[500]!,
                                                        FontWeight.bold,
                                                        "rubikregular",
                                                        1),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey)),
                                                      child: AppTextSize.textSize18(
                                                          model.data!.lastGame!
                                                              .myTeamScore
                                                              .toString(),
                                                          AppColors
                                                                  .appGreyColor[
                                                              500]!,
                                                          FontWeight.bold,
                                                          "rubikregular",
                                                          1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 30,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: AppTextSize.textSize16(
                                                        model.data!.lastGame!
                                                            .rival!,
                                                        AppColors
                                                            .appGreyColor[500]!,
                                                        FontWeight.normal,
                                                        "rubikregular",
                                                        1),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  child:
                                                                      GameStatsScreen()))
                                                          .then((value) {
                                                        CommonMethod
                                                            .initPlatformState(
                                                                this);

                                                        hundler();
                                                        ApiCall.homepageData(
                                                            this, context);
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            model.data!.nextTraining!.length == 0
                                ? Container()
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20, top: 30),
                                        child: Row(
                                          children: [
                                            AppTextSize.textSize16(
                                                TeamCenterLocalizations.of(
                                                        context)!
                                                    .find('nextTraining'),
                                                AppColors.appGreyColor[500]!,
                                                FontWeight.bold,
                                                "rubikregular",
                                                1),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                TimeTrainingScreen()))
                                                    .then((value) {
                                                  CommonMethod
                                                      .initPlatformState(this);

                                                  hundler();
                                                  ApiCall.homepageData(
                                                      this, context);
                                                });
                                              },
                                              child: Icon(
                                                Icons.more_vert,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 130,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              model.data!.nextTraining!.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Stack(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child: PlanScreen(
                                                            trainingId: model
                                                                .data!
                                                                .nextTraining![
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            date: model
                                                                .data!
                                                                .nextTraining![
                                                                    index]
                                                                .date,
                                                            fromTime: model
                                                                .data!
                                                                .nextTraining![
                                                                    index]
                                                                .fromTime,
                                                            untillTime: model
                                                                .data!
                                                                .nextTraining![
                                                                    index]
                                                                .untillTime,
                                                          ))).then((value) {
                                                    setState(() {
                                                      CommonMethod
                                                          .initPlatformState(
                                                              this);

                                                      hundler();
                                                      ApiCall.homepageData(
                                                          this, context);
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  height: 125,
                                                  width: 100,
                                                  margin: EdgeInsets.only(
                                                      left: 15, right: 15),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16)),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.6),
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      AppTextSize.textSize16(
                                                          CommonMethod
                                                              .datysName(model
                                                                  .data!
                                                                  .nextTraining![
                                                                      index]
                                                                  .date!),
                                                          AppColors
                                                                  .appGreyColor[
                                                              500]!,
                                                          FontWeight.w300,
                                                          "rubikregular",
                                                          1),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      AppTextSize.textSize12(
                                                          "${CommonMethod.dateStatRetrun(model.data!.nextTraining![index].date!)}",
                                                          AppColors
                                                              .blackColor[500]!,
                                                          FontWeight.normal,
                                                          "rubikregular",
                                                          1),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      AppTextSize.textSize12(
                                                          "${model.data!.nextTraining![index].fromTime}-${model.data!.nextTraining![index].untillTime}",
                                                          AppColors
                                                              .blackColor[500]!,
                                                          FontWeight.normal,
                                                          "rubikregular",
                                                          1),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      AppTextSize.textSize16(
                                                          model
                                                              .data!
                                                              .nextTraining![
                                                                  index]
                                                              .field!
                                                              .name!,
                                                          AppColors
                                                                  .appGreyColor[
                                                              500]!,
                                                          FontWeight.w600,
                                                          "rubikregular",
                                                          1),
                                                      SizedBox(
                                                        height: 5,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              model.data!.nextTraining![index]
                                                          .club_comment !=
                                                      "null"
                                                  ? Container(
                                                      width: 100,
                                                      height: 125,
                                                      alignment:
                                                          Alignment.topRight,
                                                      margin: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            size: 15,
                                                            color: Colors.green,
                                                          ),
                                                        ],
                                                      ))
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                            model.data!.gameState!.length == 0
                                ? Container()
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      model.data!.gameState![0].total == 0
                                          ? Container()
                                          : Container(
                                              padding: EdgeInsets.all(8),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.only(
                                                  left: 12, right: 12),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.6),
                                                    blurRadius:
                                                        16.0, // soften the shadow
                                                    offset: Offset(
                                                      2.0, // Move to right 10  horizontally
                                                      2.0, // Move to bottom 10 Vertically
                                                    ),
                                                  )
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AppTextSize.textSize16(
                                                          TeamCenterLocalizations
                                                                  .of(context)!
                                                              .find(
                                                                  'Gamestatistics'),
                                                          AppColors
                                                              .blackColor[500]!,
                                                          FontWeight.bold,
                                                          "rubikregular",
                                                          1),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 5,
                                                                    bottom: 5),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                      .appGreyColor[
                                                                  300]!,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: AppTextSize.textSize16(
                                                                "${model.data!.gameState![0].total} " +
                                                                    TeamCenterLocalizations
                                                                            .of(
                                                                                context)!
                                                                        .find(
                                                                            'matches'),
                                                                AppColors
                                                                        .whiteColor[
                                                                    500]!,
                                                                FontWeight
                                                                    .normal,
                                                                "rubikregular",
                                                                1),
                                                          ),
                                                          SizedBox(width: 5),
                                                          InkWell(
                                                            onTap: () {},
                                                            child: Icon(
                                                              Icons.more_vert,
                                                              size: 30,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                width: 30,
                                                                height: 160,
                                                                child:
                                                                    FAProgressBar(
                                                                  maxValue:
                                                                      maxValue,
                                                                  currentValue: model
                                                                              .data!
                                                                              .gameState![
                                                                                  0]
                                                                              .win ==
                                                                          null
                                                                      ? 0
                                                                      : int.parse(model
                                                                          .data!
                                                                          .gameState![
                                                                              0]
                                                                          .win),
                                                                  animatedDuration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              300),
                                                                  verticalDirection:
                                                                      VerticalDirection
                                                                          .up,
                                                                  direction: Axis
                                                                      .vertical,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  progressColor:
                                                                      AppColors
                                                                              .defaultAppColor[
                                                                          500]!,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  TeamCenterLocalizations.of(
                                                                          context)!
                                                                      .find(
                                                                          'WIN'),
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  model.data!.gameState![0].win ==
                                                                          null
                                                                      ? "0"
                                                                      : "${model.data!.gameState![0].win}",
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                width: 30,
                                                                height: 160,
                                                                child:
                                                                    FAProgressBar(
                                                                  maxValue:
                                                                      maxValue,
                                                                  currentValue: model
                                                                              .data!
                                                                              .gameState![
                                                                                  0]
                                                                              .loss ==
                                                                          null
                                                                      ? 0
                                                                      : int.parse(model
                                                                          .data!
                                                                          .gameState![
                                                                              0]
                                                                          .loss),
                                                                  animatedDuration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              300),
                                                                  verticalDirection:
                                                                      VerticalDirection
                                                                          .up,
                                                                  direction: Axis
                                                                      .vertical,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  progressColor:
                                                                      AppColors
                                                                          .redColor,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  TeamCenterLocalizations.of(
                                                                          context)!
                                                                      .find(
                                                                          'LOSS'),
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  model.data!.gameState![0].loss ==
                                                                          null
                                                                      ? "0"
                                                                      : "${model.data!.gameState![0].loss}",
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                width: 30,
                                                                height: 160,
                                                                child: FAProgressBar(
                                                                    maxValue:
                                                                        maxValue,
                                                                    currentValue: model.data!.gameState![0].tie ==
                                                                            null
                                                                        ? 0
                                                                        : int.parse(model
                                                                            .data!
                                                                            .gameState![
                                                                                0]
                                                                            .tie),
                                                                    animatedDuration:
                                                                        const Duration(
                                                                            milliseconds:
                                                                                300),
                                                                    verticalDirection:
                                                                        VerticalDirection
                                                                            .up,
                                                                    direction: Axis
                                                                        .vertical,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    progressColor:
                                                                        AppColors
                                                                            .orangeColor),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  TeamCenterLocalizations.of(
                                                                          context)!
                                                                      .find(
                                                                          'TIE'),
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  model.data!.gameState![0].tie ==
                                                                          null
                                                                      ? "0"
                                                                      : "${model.data!.gameState![0].tie}",
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                width: 30,
                                                                height: 160,
                                                                child:
                                                                    FAProgressBar(
                                                                  maxValue:
                                                                      maxValue,
                                                                  currentValue: model
                                                                              .data!
                                                                              .gameState![
                                                                                  0]
                                                                              .myTeamScore ==
                                                                          null
                                                                      ? 0
                                                                      : int.parse(model
                                                                          .data!
                                                                          .gameState![
                                                                              0]
                                                                          .myTeamScore),
                                                                  animatedDuration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              300),
                                                                  verticalDirection:
                                                                      VerticalDirection
                                                                          .up,
                                                                  direction: Axis
                                                                      .vertical,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  progressColor:
                                                                      AppColors
                                                                          .blue,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  TeamCenterLocalizations.of(
                                                                          context)!
                                                                      .find(
                                                                          'scored'),
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  model.data!.gameState![0].myTeamScore ==
                                                                          null
                                                                      ? "0"
                                                                      : "${model.data!.gameState![0].myTeamScore}",
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Container(
                                                                width: 30,
                                                                height: 160,
                                                                child: FAProgressBar(
                                                                    maxValue:
                                                                        maxValue,
                                                                    currentValue: model.data!.gameState![0].revelTeamScore ==
                                                                            null
                                                                        ? 0
                                                                        : int.parse(model
                                                                            .data!
                                                                            .gameState![
                                                                                0]
                                                                            .revelTeamScore),
                                                                    animatedDuration:
                                                                        const Duration(
                                                                            milliseconds:
                                                                                300),
                                                                    verticalDirection:
                                                                        VerticalDirection
                                                                            .up,
                                                                    direction: Axis
                                                                        .vertical,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    progressColor:
                                                                        AppColors
                                                                            .yellowColor),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  TeamCenterLocalizations.of(
                                                                          context)!
                                                                      .find(
                                                                          'conceded'),
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            ),
                                                            Container(
                                                              width: 50,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: AppTextSize.textSize12(
                                                                  model.data!.gameState![0].revelTeamScore ==
                                                                          null
                                                                      ? "0"
                                                                      : "${model.data!.gameState![0].revelTeamScore}",
                                                                  AppColors
                                                                          .blackColor[
                                                                      500]!,
                                                                  FontWeight
                                                                      .normal,
                                                                  "rubikregular",
                                                                  1),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                    ],
                                  ),
//  CommonMethod.professionalPermission()
//                                                 .subSections![0]
//                                                 .permission!
//                                                 .view ==
//                                             0
//                                         ? Container()
//                                         :
                            model.data!.professionalKnowledge!.length == 0
                                ? Container()
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: AppColors.professionalBackColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppTextSize.textSize16(
                                                  TeamCenterLocalizations.of(
                                                          context)!
                                                      .find(
                                                          'professional_knowledge'),
                                                  AppColors.blackColor[500]!,
                                                  FontWeight.bold,
                                                  "rubikregular",
                                                  1),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  ProfessionalKnowledagePage()))
                                                      .then((value) {
                                                    CommonMethod
                                                        .initPlatformState(
                                                            this);

                                                    hundler();
                                                    ApiCall.homepageData(
                                                        this, context);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.more_vert,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                          height: 240,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: model.data!
                                                .professionalKnowledge!.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                ProfessionalDetailsScreen(
                                                              professional: model
                                                                      .data!
                                                                      .professionalKnowledge![
                                                                  index],
                                                            ))).then((value) {
                                                      CommonMethod
                                                          .initPlatformState(
                                                              this);

                                                      hundler();
                                                      ApiCall.homepageData(
                                                          this, context);

                                                      setState(() {});
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      Container(
                                                          height: 227,
                                                          width: 160,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .white),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.6),
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              (model.data!.professionalKnowledge![index].videoUrl ==
                                                                              "null" &&
                                                                          model.data!.professionalKnowledge![index].mainImage ==
                                                                              "null") ||
                                                                      (model.data!.professionalKnowledge![index].videoUrl ==
                                                                              "" &&
                                                                          model.data!.professionalKnowledge![index].mainImage ==
                                                                              "")
                                                                  ? Container()
                                                                  : Container(
                                                                      width:
                                                                          160,
                                                                      height:
                                                                          150,
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          model.data!.professionalKnowledge![index].videoUrl == "null" || model.data!.professionalKnowledge![index].videoUrl == ""
                                                                              ? CachedNetworkImage(
                                                                                  imageUrl: model.data!.professionalKnowledge![index].mainImage == "null" ? "" : model.data!.professionalKnowledge![index].mainImage!,
                                                                                  imageBuilder: (context, imageProvider) => Container(
                                                                                    width: 160,
                                                                                    height: 150,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                      shape: BoxShape.rectangle,
                                                                                      image: DecorationImage(
                                                                                        image: imageProvider,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  placeholder: (context, url) => Container(
                                                                                    width: 160,
                                                                                    height: 150,
                                                                                    child: Container(
                                                                                      width: 70,
                                                                                      height: 70,
                                                                                      alignment: Alignment.center,
                                                                                      child: CircularProgressIndicator(
                                                                                        color: AppColors.primaryColor,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  errorWidget: (context, url, error) => Container(
                                                                                      width: 160,
                                                                                      height: 150,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.black,
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                        shape: BoxShape.rectangle,
                                                                                      ),
                                                                                      child: Container(width: 70, height: 70, child: Icon(Icons.error))),
                                                                                )
                                                                              : CachedNetworkImage(
                                                                                  imageUrl: model.data!.professionalKnowledge![index].thumbnail_image == "null" ? "" : model.data!.professionalKnowledge![index].thumbnail_image!,
                                                                                  imageBuilder: (context, imageProvider) => Container(
                                                                                    width: 160,
                                                                                    height: 150,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                      shape: BoxShape.rectangle,
                                                                                      image: DecorationImage(
                                                                                        image: imageProvider,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  placeholder: (context, url) => Container(
                                                                                    width: 160,
                                                                                    height: 150,
                                                                                    child: Container(
                                                                                      width: 70,
                                                                                      height: 70,
                                                                                      alignment: Alignment.center,
                                                                                      child: CircularProgressIndicator(
                                                                                        color: AppColors.primaryColor,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  errorWidget: (context, url, error) => Container(
                                                                                      width: 160,
                                                                                      height: 150,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.black,
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                        shape: BoxShape.rectangle,
                                                                                      ),
                                                                                      child: Container(width: 70, height: 70, child: Icon(Icons.error))),
                                                                                ),
                                                                          model.data!.professionalKnowledge![index].videoUrl == "null" || model.data!.professionalKnowledge![index].videoUrl == ""
                                                                              ? Container()
                                                                              : Container(
                                                                                  width: 160,
                                                                                  height: 150,
                                                                                  alignment: Alignment.center,
                                                                                  child: GestureDetector(
                                                                                      onTap: () {
                                                                                        Navigator.push(
                                                                                            context,
                                                                                            PageTransition(
                                                                                                type: PageTransitionType.fade,
                                                                                                child: InAppWebViewExampleScreen(
                                                                                                  url: model.data!.professionalKnowledge![index].videoUrl!,
                                                                                                  name: model.data!.professionalKnowledge![index].videoUrl!.split("/").last.split(".").first,
                                                                                                  isProfessionalKnowledge: true,
                                                                                                ))).then((value) {
                                                                                          CommonMethod.initPlatformState(this);

                                                                                          hundler();
                                                                                          ApiCall.homepageData(this, context);
                                                                                        });
                                                                                      },
                                                                                      child: Image.asset("assets/images/play_icon.png", width: 50, height: 50)))
                                                                        ],
                                                                      ),
                                                                    ),
                                                              model.data!.professionalKnowledge![index].title ==
                                                                          null ||
                                                                      model.data!.professionalKnowledge![index].title ==
                                                                          ""
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      child: AppTextSize.textSize14(
                                                                          model
                                                                              .data!
                                                                              .professionalKnowledge![
                                                                                  index]
                                                                              .title!,
                                                                          AppColors.blackColor[
                                                                              500]!,
                                                                          FontWeight
                                                                              .w500,
                                                                          "rubikregular",
                                                                          1)),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 5,
                                                                        right:
                                                                            5,
                                                                        bottom:
                                                                            5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20)),
                                                                ),
                                                                child: AppTextSize.textSizeShortDesc12(
                                                                    model
                                                                        .data!
                                                                        .professionalKnowledge![
                                                                            index]
                                                                        .shortDescription!,
                                                                    AppColors
                                                                        .textColor,
                                                                    FontWeight
                                                                        .normal,
                                                                    "rubikregular",
                                                                    2),
                                                              )
                                                            ],
                                                          )),
                                                      SizedBox(
                                                        width: 12,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ))
            ],
          )),
    );
  }

  @override
  void onFailure(message) {
    setState(() {
      isLoader = false;
    });
    Navigator.pop(context);
  }

  @override
  void onSuccess(data) {
    isLoader = false;
    Navigator.pop(context);
    print(data);
    model = HomePageModel.fromJson(data);
    totalInstruction(context);

    maxValueMethod();

    if (SharedPref.getNotificationId() != "") {
      if (SharedPref.getNotificationType() == "game") {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: GameDetailsScreen(
                  gameId: SharedPref.getNotificationId(),
                ))).then((value) {
          setState(() {
            CommonMethod.initPlatformState(this);

            hundler();
            ApiCall.homepageData(this, context);
          });
        });
      } else if (SharedPref.getNotificationType() == "game_instruction" ||
          SharedPref.getNotificationType() == "training_instruction") {
        Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ManagmentInstructionScreen(
                        id: SharedPref.getNotificationId(),
                        type: SharedPref.getNotificationType())))
            .then((value) {
          CommonMethod.initPlatformState(this);

          hundler();
          ApiCall.homepageData(this, context);
        });
      } else if (SharedPref.getNotificationType() == "professional_knowledge") {
        Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ProfessionalKnowledagePage(
                        id: SharedPref.getNotificationId(),
                        type: SharedPref.getNotificationType())))
            .then((value) {
          setState(() {
            CommonMethod.initPlatformState(this);

            hundler();
            ApiCall.homepageData(this, context);
          });
        });
      } else {
        Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: TimeTrainingScreen()))
            .then((value) {
          setState(() {
            CommonMethod.initPlatformState(this);

            hundler();
            ApiCall.homepageData(this, context);
          });
        });
      }
      SharedPref.saveNotificationId("");
      SharedPref.saveNotificationType("");
    }
  }

  maxValueMethod() {
    statistic.add(model.data!.gameState![0].win != null
        ? int.parse(model.data!.gameState![0].revelTeamScore)
        : 0);
    statistic.add(model.data!.gameState![0].loss != null
        ? int.parse(model.data!.gameState![0].loss)
        : 0);
    statistic.add(model.data!.gameState![0].tie != null
        ? int.parse(model.data!.gameState![0].tie)
        : 0);
    statistic.add(model.data!.gameState![0].myTeamScore != null
        ? int.parse(model.data!.gameState![0].myTeamScore)
        : 0);
    statistic.add(model.data!.gameState![0].revelTeamScore != null
        ? int.parse(model.data!.gameState![0].revelTeamScore)
        : 0);

    maxValue = statistic[0];
    for (var i = 0; i < statistic.length; i++) {
      // Checking for largest value in the list
      if (statistic[i] != 0) {
        if (statistic[i] > maxValue) {
          maxValue = statistic[i];
        }
      }
    }
    print(maxValue);
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
        setState(() {
          CommonMethod.initPlatformState(this);

          hundler();
          ApiCall.homepageData(this, context);
        });
      });
    } else if (type == "game_instruction" || type == "training_instruction") {
      Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ManagmentInstructionScreen(id: id, type: type)))
          .then((value) {
        setState(() {
          CommonMethod.initPlatformState(this);

          hundler();
          ApiCall.homepageData(this, context);
        });
      });
    } else if (type == "professional_knowledge") {
      Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ProfessionalKnowledagePage(id: id, type: type)))
          .then((value) {
        setState(() {
          CommonMethod.initPlatformState(this);

          hundler();
          ApiCall.homepageData(this, context);
        });
      });
    } else {
      Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: TimeTrainingScreen()))
          .then((value) {
        CommonMethod.initPlatformState(this);

        hundler();
        ApiCall.homepageData(this, context);
      });
    }
  }

  stateVerify() {
    CommonMethod.initPlatformState(this);
  }

  @override
  Future<http.Response?> totalInstruction(BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.totalInstruction), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          setState(() {
            globals.totalCount = data['totalCount'];
            globals.gameCount = data['gameCont'];
            globals.trainingCount = data['trainingCount'];
            globals.professinalCount = data['professionalknowledge'];

            totalCount = globals.totalCount;
          });
        } else {
          setState(() {});
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.

      }
    } catch (e) {}
  }

  @override
  void updateBadge(id, String type) {
    print(type);
    if (type == "game") {
    } else if (type == "game_instruction" || type == "training_instruction") {
      totalInstruction(context);
    } else if (type == "professional_knowledge") {
      totalInstruction(context);
    } else {}
  }

  playerObjectiveAccordingToModel() {
    for (int i = 0;
        i < model.data!.nextGameObjective!.playerObjective!.length;
        i++) {
      if (model.data!.nextGameObjective!.playerObjective![i].playerId
              .toString() ==
          CommonMethod.userId()) {
        return model.data!.nextGameObjective!.playerObjective![i].objective!;
      }
    }
  }
}
