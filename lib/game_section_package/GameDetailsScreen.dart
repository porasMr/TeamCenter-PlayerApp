import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/game_section_package/CallBack.dart';

import 'package:team_center/game_section_package/model/GameDetailModel.dart';
import 'package:team_center/game_section_package/model/GameListingModel.dart';
import 'package:team_center/ui/managment_instruction_package/managment_instruaction.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/shared_preferences.dart';

import '../utils/AppImages.dart';

class GameDetailsScreen extends StatefulWidget {
  var gameId;

  GameDetailsScreen({this.gameId});
  @override
  _GameDetailsScreenState createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen>
    with TickerProviderStateMixin
    implements ApiInterface, GameCallBackInterface, NotificationClick {
  List<Tab> _tabs = List<Tab>.empty(growable: true);
  late TabController _tabController;
  GameDetailModel model = new GameDetailModel();
  TextEditingController highController = new TextEditingController();
  TextEditingController lowController = new TextEditingController();
  String whichApiCall = "game details";
  String status = "";
  bool isEdit = true;

  bool isLoader = true;
  @override
  void initState() {
    super.initState();

    // getselectedData();
    hundler();
    ApiCall.gameDetailsApi(widget.gameId, this, context);
  }

  hundler() async {
    Timer(Duration(microseconds: 100), () {
      CommonMethod.dialogLoader(context);
    });
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor[500],
      body: SafeArea(
          top: false,
          bottom: false,
          child: InkWell(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
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
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 24, color: AppColors.blue),
                          ),
                          InkWell(
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 10,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
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
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              width: 40,
                              height: 40,
                              child: TextFormField(
                                readOnly: true,
                                controller: lowController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.center,
                                onFieldSubmitted: (v) {},
                                onChanged: (v) {},
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "rubikregular",
                                    fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 12.0)),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AppTextSize.textSize14(
                                "-",
                                AppColors.appGreyColor[500]!,
                                FontWeight.bold,
                                "rubikregular",
                                1),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              width: 40,
                              height: 40,
                              child: TextFormField(
                                readOnly: true,
                                controller: highController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.center,
                                onFieldSubmitted: (v) {},
                                onChanged: (v) {},
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "rubikregular",
                                    fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      status == ""
                          ? Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
                            )
                          : status == "win"
                              ? Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: AppColors.defaultAppColor[500],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: AppTextSize.textSize14(
                                      TeamCenterLocalizations.of(context)!
                                          .find('WIN'),
                                      AppColors.whiteColor[500]!,
                                      FontWeight.bold,
                                      "rubikregular",
                                      1),
                                )
                              : status == "loss"
                                  ? Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                          color: AppColors.redColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: AppTextSize.textSize14(
                                          TeamCenterLocalizations.of(context)!
                                              .find('LOSS'),
                                          AppColors.whiteColor[500]!,
                                          FontWeight.bold,
                                          "rubikregular",
                                          1),
                                    )
                                  : status == "tie"
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                              color: AppColors.orangeColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: AppTextSize.textSize14(
                                              TeamCenterLocalizations.of(
                                                      context)!
                                                  .find('TIE'),
                                              AppColors.whiteColor[500]!,
                                              FontWeight.bold,
                                              "rubikregular",
                                              1),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 5,
                                              bottom: 5)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 1,
                    decoration:
                        BoxDecoration(color: AppColors.strokeColor, boxShadow: [
                      BoxShadow(
                        color: AppColors.mediumGrey,
                        blurRadius: 2.0, // soften the shadow
                        offset: Offset(
                          0.5, // Move to right 10  horizontally
                          0.5, // Move to bottom 10 Vertically
                        ),
                      )
                    ]),
                  ),
                  isLoader
                      ? Container()
                      : Expanded(
                          flex: 1,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 24, right: 24),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: AppColors.strokeColor),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: AppColors.tabGreyColor),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppTextSize.textSize14(
                                              "${CommonMethod.dateStatRetrun(model.gameDetail!.date!)}, ${model.gameDetail!.time}",
                                              Colors.black,
                                              FontWeight.bold,
                                              "rubikregular",
                                              1),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          AppTextSize.textSize14(
                                              model.gameDetail!.rival!,
                                              Colors.black,
                                              FontWeight.normal,
                                              "rubikregular",
                                              1),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          model.gameDetail!.keyGame == 1
                                              ? Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                      Image.asset(
                                                        AppImages.starFill,
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      AppTextSize.textSize14(
                                                          TeamCenterLocalizations
                                                                  .of(context)!
                                                              .find('Keygame'),
                                                          Colors.black,
                                                          FontWeight.normal,
                                                          "rubikregular",
                                                          1),
                                                    ])
                                              : Container(),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 100,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 8),
                                            decoration: BoxDecoration(
                                                color: AppColors.darkgrey,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors.mediumGrey,
                                                    blurRadius:
                                                        16.0, // soften the shadow
                                                    offset: Offset(
                                                      4.0, // Move to right 10  horizontally
                                                      4.0, // Move to bottom 10 Vertically
                                                    ),
                                                  )
                                                ]),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                model.gameDetail!.matchType ==
                                                        "League"
                                                    ? Image.asset(
                                                        AppImages.leaguIcon,
                                                        width: 20,
                                                        height: 20,
                                                      )
                                                    : model.gameDetail!
                                                                .matchType ==
                                                            "Friendly"
                                                        ? Image.asset(
                                                            AppImages
                                                                .friendlyIcon,
                                                            width: 20,
                                                            height: 20,
                                                          )
                                                        : Image.asset(
                                                            AppImages.cup,
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                model.gameDetail!.matchType ==
                                                        "League"
                                                    ? AppTextSize.textSize16(
                                                        TeamCenterLocalizations.of(
                                                                context)!
                                                            .find('League'),
                                                        Colors.white,
                                                        FontWeight.bold,
                                                        "rubikregular",
                                                        1)
                                                    : model.gameDetail!
                                                                .matchType ==
                                                            "Friendly"
                                                        ? AppTextSize.textSize16(
                                                            TeamCenterLocalizations.of(
                                                                    context)!
                                                                .find(
                                                                    'Friendly'),
                                                            Colors.white,
                                                            FontWeight.bold,
                                                            "rubikregular",
                                                            1)
                                                        : AppTextSize.textSize16(
                                                            TeamCenterLocalizations
                                                                    .of(context)!
                                                                .find('Cup'),
                                                            Colors.white,
                                                            FontWeight.bold,
                                                            "rubikregular",
                                                            1),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 100,
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 8),
                                            decoration: BoxDecoration(
                                                color: AppColors.darkgrey,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors.mediumGrey,
                                                    blurRadius:
                                                        4.0, // soften the shadow
                                                    offset: Offset(
                                                      2.0, // Move to right 10  horizontally
                                                      4.0, // Move to bottom 10 Vertically
                                                    ),
                                                  )
                                                ]),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  model.gameDetail!.gamePlace ==
                                                          "home game"
                                                      ? AppImages.homeIcon
                                                      : AppImages.awayIcon,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                AppTextSize.textSize16(
                                                    model.gameDetail!
                                                                .gamePlace ==
                                                            "home game"
                                                        ? TeamCenterLocalizations
                                                                .of(context)!
                                                            .find('Home')
                                                        : TeamCenterLocalizations
                                                                .of(context)!
                                                            .find('Away'),
                                                    Colors.white,
                                                    FontWeight.bold,
                                                    "rubikregular",
                                                    1),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              model.playerStat == null
                                  ? Container()
                                  : Padding(
                                      padding:
                                          EdgeInsets.only(left: 24, right: 24),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.strokeColor,
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            color: AppColors.tabGreyColor),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextSize.textSize14(
                                                      TeamCenterLocalizations
                                                              .of(context)!
                                                          .find('myStatsArea'),
                                                      Colors.black,
                                                      FontWeight.normal,
                                                      "rubikregular",
                                                      1),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Container(
                                                height: valueLenght(),
                                                child: GridView.count(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 5,
                                                  mainAxisSpacing: 5,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.all(10.0),
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  children: List.generate(
                                                    model
                                                        .playerStat!
                                                        .playerGameStateAvg![0]
                                                        .stats!
                                                        .length,
                                                    (index) => Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .strokeColor,
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          color: Colors.white),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                              padding: const EdgeInsets.all(
                                                                  5.0),
                                                              child: double.parse(model
                                                                          .playerStat!
                                                                          .playerStats![
                                                                              0]
                                                                          .stats![
                                                                              index]
                                                                          .value!) >
                                                                      double.parse(model
                                                                          .playerStat!
                                                                          .playerGameStateAvg![
                                                                              0]
                                                                          .stats![
                                                                              index]
                                                                          .value!)
                                                                  ? AppTextSize.textSize28(
                                                                      "${model.playerStat!.playerStats![0].stats![index].value!}",
                                                                      AppColors.defaultAppColor[
                                                                          500]!,
                                                                      FontWeight
                                                                          .bold,
                                                                      "rubikregular",
                                                                      1)
                                                                  : double.parse(model.playerStat!.playerStats![0].stats![index].value!) ==
                                                                          double.parse(model.playerStat!.playerGameStateAvg![0].stats![index].value!)
                                                                      ? AppTextSize.textSize28("${model.playerStat!.playerStats![0].stats![index].value!}", AppColors.orangeColor, FontWeight.bold, "rubikregular", 1)
                                                                      : AppTextSize.textSize28("${model.playerStat!.playerStats![0].stats![index].value!}", AppColors.redColor, FontWeight.bold, "rubikregular", 1)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: double.parse(model
                                                                        .playerStat!
                                                                        .playerStats![
                                                                            0]
                                                                        .stats![
                                                                            index]
                                                                        .value!) >
                                                                    double.parse(model
                                                                        .playerStat!
                                                                        .playerGameStateAvg![
                                                                            0]
                                                                        .stats![
                                                                            index]
                                                                        .value!)
                                                                ? Text(
                                                                    "${TeamCenterLocalizations.of(context)!.find('ave')} ${model.playerStat!.playerGameStateAvg![0].stats![index].value!}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12.0,
                                                                        fontFamily:
                                                                            "rubikregular",
                                                                        color: AppColors
                                                                            .redColor,
                                                                        fontWeight:
                                                                            FontWeight.normal))
                                                                : double.parse(model.playerStat!.playerStats![0].stats![index].value!) == double.parse(model.playerStat!.playerGameStateAvg![0].stats![index].value!)
                                                                    ? Text(
                                                                        "${TeamCenterLocalizations.of(context)!.find('ave')} ${model.playerStat!.playerGameStateAvg![0].stats![index].value!}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.0,
                                                                            fontFamily:
                                                                                "rubikregular",
                                                                            color:
                                                                                AppColors.orangeColor,
                                                                            fontWeight: FontWeight.normal),
                                                                      )
                                                                    : Text(
                                                                        "${TeamCenterLocalizations.of(context)!.find('ave')} ${model.playerStat!.playerGameStateAvg![0].stats![index].value!}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12.0,
                                                                            fontFamily:
                                                                                "rubikregular",
                                                                            color:
                                                                                AppColors.defaultAppColor[500],
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                          ),
                                                          Text(
                                                            model
                                                                .playerStat!
                                                                .playerGameStateAvg![
                                                                    0]
                                                                .stats![index]
                                                                .statName!,
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontFamily:
                                                                    "rubikregular",
                                                                color: AppColors
                                                                        .appGreyColor[
                                                                    500],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                              model.gameDetail!.clubComment == "null" ||
                                      model.gameDetail!.clubComment == ""
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 24, right: 24),
                                          child: AppTextSize.textSize16(
                                              TeamCenterLocalizations.of(
                                                      context)!
                                                  .find('club_comments'),
                                              Colors.black,
                                              FontWeight.bold,
                                              "rubikregular",
                                              1),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 24, right: 24),
                                          child: Html(
                                            data: model.gameDetail!.clubComment,
                                            customTextAlign: (_) =>
                                                CommonMethod.appLanguage() ==
                                                        "English"
                                                    ? TextAlign.left
                                                    : TextAlign.right,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                              model.gameDetail!.plan == "null"
                                  ? Container()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 24, right: 24),
                                          child: AppTextSize.textSize16(
                                              TeamCenterLocalizations.of(
                                                      context)!
                                                  .find('Gameplan'),
                                              Colors.black,
                                              FontWeight.bold,
                                              "rubikregular",
                                              1),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 24, right: 24),
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AppTextSize
                                                  .textSize16WithExtraLineSpacing(
                                                      model.gameDetail!.plan!,
                                                      Colors.black,
                                                      FontWeight.normal,
                                                      "rubikregular",
                                                      8),
                                            )),
                                      ],
                                    ),
                              model.gameDetail!.playerObjective!.length == 0 ||
                                      model.gameDetail!.playerObjective == null
                                  ? Container()
                                  : Container(child: objectiveView()),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 24, right: 24),
                                child: AppTextSize.textSize16(
                                  TeamCenterLocalizations.of(context)!
                                      .find('GameLineup'),
                                  Colors.black,
                                  FontWeight.bold,
                                  "rubikregular",
                                  1,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 600.0,
                                decoration: BoxDecoration(),
                                padding: EdgeInsets.all(1.0),
                                child: CachedNetworkImage(
                                  imageUrl: model.gameDetail!.lineUpImage!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 600.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 600.0,
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 600.0,
                                          child: Container()),
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          )),
    );
  }

  objectiveView() {
    for (int i = 0; i < model.gameDetail!.playerObjective!.length; i++) {
      if (model.gameDetail!.playerObjective![i].playerId.toString() ==
          SharedPref.getPlayerId()) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 24, right: 24),
              child: AppTextSize.textSize16(
                TeamCenterLocalizations.of(context)!.find('myGameObjectives'),
                Colors.black,
                FontWeight.bold,
                "rubikregular",
                1,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            AppTextSize.textSize16WithExtraLineSpacing(
                model.gameDetail!.playerObjective![i].objective!,
                Colors.black,
                FontWeight.normal,
                "rubikregular",
                8),
          ],
        );
      }
    }
    return Container();
  }

  @override
  void onFailure(message) {
    setState(() {
      isLoader = false;
    });
  }

  @override
  void onSuccess(data) {
    if (whichApiCall == "game details") {
      Navigator.pop(context);
      model = GameDetailModel.fromJson(data);
      if (model.gameDetail!.status == "" ||
          model.gameDetail!.status == "null") {
        highController.text = "";
        lowController.text = "";
        status = model.gameDetail!.status.toString();
      } else {
        highController.text = model.gameDetail!.myTeamScore.toString();
        lowController.text = model.gameDetail!.revelTeamScore.toString();
        status = model.gameDetail!.status.toString();
      }

      setState(() {
        isLoader = false;
      });
    } else {}
  }

  @override
  void onUpdate() {
    whichApiCall = "game details";

    hundler();
    ApiCall.gameDetailsApi(widget.gameId, this, context);
  }

  @override
  void onClick(id, type) {}

  @override
  void updateBadge(id, String type) {}

  precentage(String value) {
    return double.parse(value) * 10 / 100;
  }

  valueLenght() {
    var d = model.playerStat!.playerGameStateAvg![0].stats!.length / 3;
    if (d.toString().contains(".")) {
      d = d + 0.5;
    }
    return d * 110;
  }
}
