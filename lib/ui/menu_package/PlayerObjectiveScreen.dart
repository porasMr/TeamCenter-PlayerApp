import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';

import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/country_list.dart';
import 'package:team_center/utils/shared_preferences.dart';

import '../../game_section_package/GameDetailsScreen.dart';
import '../../main.dart';
import '../../utils/SelectImageInterface.dart';
import '../../utils/SelectOtherImageWithCrop.dart';
import '../home_package copy/homePage.dart';
import '../managment_instruction_package/managment_instruaction.dart';
import '../professional_package/ProfessionalKnowledagePage.dart';
import '../tranning_package/TimeTrainingScreen.dart';
import 'model/player_objective.dart';

class PlayerObjectiveScreen extends StatefulWidget {
  @override
  _PlayerObjectiveScreenState createState() => _PlayerObjectiveScreenState();
}

class _PlayerObjectiveScreenState extends State<PlayerObjectiveScreen>
    implements ApiInterface, NotificationClick {
  PlayerObjectives model = PlayerObjectives();
  bool isLoader = true;
  @override
  void initState() {
    super.initState();
    CommonMethod.initPlatformState(this);

    hundler();
    ApiCall.getAbility(this, context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  hundler() async {
    Timer(Duration(microseconds: 100), () {
      CommonMethod.dialogLoader(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor[500],
      body: InkWell(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SafeArea(
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                                              .find('myObjective'),
                                          AppColors.blue,
                                          FontWeight.normal,
                                          "rubikregular",
                                          1),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  isLoader == true
                      ? Container()
                      : Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            model.nextGameObjective != null
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
                                            Row(
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
                                                                    .nextGameObjective!
                                                                    .id
                                                                    .toString(),
                                                              ))).then(
                                                          (value) {});
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
                                                            "${CommonMethod.dateRetrun(model.nextGameObjective!.date!)} ${model.nextGameObjective!.time!} ${model.nextGameObjective!.rival}",
                                                            AppColors
                                                                    .blackColor[
                                                                500]!,
                                                            FontWeight.normal,
                                                            "rubikregular",
                                                            1),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        model
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
                                                  color: AppColors.selectedGrey,
                                                )
                                              ],
                                            )
                                          ]),
                                    ),
                                  )
                                : Container(),
                            model.nextGameObjective != null
                                ? SizedBox(
                                    height: 8,
                                  )
                                : Container(),
                            model.nextGameObjective != null
                                ? Container(
                                    height: 1,
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    width: MediaQuery.of(context).size.width,
                                    color: AppColors.appGreyColor[50]!,
                                  )
                                : Container(),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: model.data!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AppTextSize.textSize18(
                                              model.data![index].type!,
                                              AppColors.blackColor[500]!,
                                              FontWeight.bold,
                                              "rubikregular",
                                              1),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          model.data![index].goal!.value == null
                                              ? Container()
                                              : Flexible(
                                                  flex: 1,
                                                  child: AppTextSize
                                                      .textSizeShortDesc12WithoutMaxline(
                                                          model.data![index]
                                                              .goal!.value!,
                                                          AppColors
                                                              .selectedGrey,
                                                          FontWeight.normal,
                                                          "rubikregular"),
                                                ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: AppColors.appGreyColor[50]!,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ))
                ],
              ))),
    );
  }

  registerButton() {
    if (Platform.isIOS) {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        child: new CupertinoButton(
          padding: EdgeInsets.all(10),
          borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: HomePageScreen()));
          },
          color: AppColors.defaultAppColor[500],
          child: AppTextSize.textSize14(
              TeamCenterLocalizations.of(context)!.find('next'),
              AppColors.whiteColor[500]!,
              FontWeight.bold,
              "",
              1),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        child: new MaterialButton(
          elevation: 4.0,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: HomePageScreen()));
          },
          color: AppColors.defaultAppColor[500],
          splashColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
          ),
          padding: EdgeInsets.all(10),
          child: AppTextSize.textSize14(
              TeamCenterLocalizations.of(context)!.find('next'),
              AppColors.appGreyColor[500]!,
              FontWeight.bold,
              "",
              1),
        ),
      );
    }
  }

  sendAgainButton() {
    if (Platform.isIOS) {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        child: new CupertinoButton(
          padding: EdgeInsets.all(10),
          borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
          onPressed: () {},
          color: Colors.grey[200],
          child: AppTextSize.textSize14(
              TeamCenterLocalizations.of(context)!.find('sentAgain'),
              AppColors.blackColor[300]!,
              FontWeight.normal,
              "",
              1),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        child: new MaterialButton(
          elevation: 4.0,
          onPressed: () {},
          color: Colors.grey[200],
          splashColor: Colors.black12,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
              side: BorderSide(color: Colors.grey)),
          padding: EdgeInsets.all(10),
          child: AppTextSize.textSize14(
              TeamCenterLocalizations.of(context)!.find('sentAgain'),
              AppColors.blackColor[300]!,
              FontWeight.normal,
              "",
              1),
        ),
      );
    }
  }

  @override
  void onFailure(message) {
    Navigator.pop(context);
    setState(() {
      isLoader = false;
    });
  }

  @override
  void onSuccess(data) {
    Navigator.pop(context);
    model = PlayerObjectives.fromJson(data);
    setState(() {
      isLoader = false;
    });
  }

  playerObjectiveAccordingToModel() {
    for (int i = 0; i < model.nextGameObjective!.playerObjective!.length; i++) {
      if (model.nextGameObjective!.playerObjective![i].playerId.toString() ==
          CommonMethod.userId()) {
        return model.nextGameObjective!.playerObjective![i].objective!;
      }
    }
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
  void updateBadge(id, String type) {
    // TODO: implement updateBadge
  }
}
