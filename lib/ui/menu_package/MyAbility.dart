import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

import '../../main.dart';
import '../../utils/SelectImageInterface.dart';
import '../../utils/SelectOtherImageWithCrop.dart';
import '../home_package copy/homePage.dart';
import 'model/player_objective.dart';

class MyAbilityScreen extends StatefulWidget {
  @override
  _MyAbilityScreenState createState() => _MyAbilityScreenState();
}

class _MyAbilityScreenState extends State<MyAbilityScreen>
    implements ApiInterface {
  PlayerObjectives model = PlayerObjectives();
  bool isLoader = true;
  @override
  void initState() {
    super.initState();
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
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 6;
    final double itemWidth = size.width / 2;
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
                                              .find('myAbilities'),
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
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: model.data!.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppTextSize.textSize18(
                                                    model.data![index].type!,
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    "rubikregular",
                                                    1),
                                              ],
                                            ),
                                            model.data![index].ablities == null
                                                ? Container()
                                                : model.data![index].ablities!
                                                            .length ==
                                                        0
                                                    ? Container()
                                                    : SizedBox(
                                                        height: 10,
                                                      ),
                                            model.data![index].ablities == null
                                                ? Container()
                                                : model.data![index].ablities!
                                                            .length ==
                                                        0
                                                    ? Container()
                                                    : GridView.count(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 5,
                                                        mainAxisSpacing: 5,
                                                        childAspectRatio:
                                                            (itemWidth /
                                                                itemHeight),
                                                        shrinkWrap: true,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        children: List.generate(
                                                          model.data![index]
                                                              .ablities!.length,
                                                          (pos) => Container(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: Container(
                                                              height: 150,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .strokeColor,
                                                                      width: 1),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5.0)),
                                                                  color: AppColors
                                                                      .tabGreyColor),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  RatingBar(
                                                                    ignoreGestures:
                                                                        true,
                                                                    initialRating: double.parse(model
                                                                        .data![
                                                                            index]
                                                                        .ablities![
                                                                            pos]
                                                                        .value!),
                                                                    minRating:
                                                                        1,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    itemSize:
                                                                        30,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    ratingWidget:
                                                                        RatingWidget(
                                                                      full: Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.amber),
                                                                      half:
                                                                          Icon(
                                                                        Icons
                                                                            .star_half,
                                                                        color: Colors
                                                                            .amber,
                                                                        textDirection:
                                                                            TextDirection.ltr,
                                                                      ),
                                                                      empty: Icon(
                                                                          Icons
                                                                              .star_border,
                                                                          color:
                                                                              Colors.amber),
                                                                    ),
                                                                    onRatingUpdate:
                                                                        (rating) {},
                                                                  ),
                                                                  Container(
                                                                    height: 16,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                  ),
                                                                  AppTextSize.textSize14(
                                                                      CommonMethod.appLanguage() ==
                                                                              "English"
                                                                          ? model
                                                                              .data![
                                                                                  index]
                                                                              .ablities![
                                                                                  pos]
                                                                              .clubAblity!
                                                                              .name!
                                                                          : model
                                                                              .data![
                                                                                  index]
                                                                              .ablities![
                                                                                  pos]
                                                                              .clubAblity!
                                                                              .hebrewName!,
                                                                      Colors
                                                                          .black,
                                                                      FontWeight
                                                                          .normal,
                                                                      "rubikregular",
                                                                      1),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )),
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
}
