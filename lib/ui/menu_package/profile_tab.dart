import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/strings.dart';

import '../../game_section_package/GameDetailsScreen.dart';
import '../../utils/NotificationCallBack.dart';
import '../managment_instruction_package/managment_instruaction.dart';
import '../professional_package/ProfessionalKnowledagePage.dart';
import '../tranning_package/TimeTrainingScreen.dart';
import 'model/player_model.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    implements ApiInterface, NotificationClick {
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  PlayerModel playerModel = PlayerModel();
  bool isLoader = true;

  @override
  void initState() {
    hundler();
    CommonMethod.initPlatformState(this);

    ApiCall.playerProfile(this, context);
    super.initState();
  }

  hundler() async {
    Timer(Duration(microseconds: 100), () {
      CommonMethod.dialogLoader(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                            Navigator.pop(context);
                          },
                          child: AppTextSize.textSize20(
                              TeamCenterLocalizations.of(context)!
                                  .find('myprofile'),
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
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          profileCommonUI(),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              AppTextSize.textSize16(
                                  TeamCenterLocalizations.of(context)!
                                      .find('Profile'),
                                  Colors.black,
                                  FontWeight.bold,
                                  "rubikregular",
                                  1),
                              InkWell(
                                onTap: () {},
                                child: AppTextSize.textSize16(
                                    TeamCenterLocalizations.of(context)!
                                        .find('Edit'),
                                    AppColors.blue,
                                    FontWeight.bold,
                                    "rubikregular",
                                    1),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            textDirection: TextDirection.ltr,
                            textAlign: CommonMethod.appLanguage() == "English"
                                ? TextAlign.left
                                : TextAlign.right,
                            controller: _phoneController,
                            style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 16,
                                fontFamily: "rubikregular",
                                fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                              labelText: TeamCenterLocalizations.of(context)!
                                  .find('Phone'),
                              border: InputBorder.none,
                              errorMaxLines: 1,
                              fillColor: Colors.transparent,
                              errorText: null,
                              labelStyle: TextStyle(
                                  color: AppColors.blackColor[500],
                                  fontSize: 14,
                                  fontFamily: "rubikregular",
                                  fontWeight: FontWeight.normal),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                            ),
                            maxLines: 1,
                            readOnly: true,
                            textInputAction: TextInputAction.none,
                            onChanged: (fullName) {},
                            validator: (fullName) {
                              if (fullName!.trim().length < 10) {
                                return 'Please enter valid phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            controller: _addressController,
                            style: TextStyle(
                                color: AppColors.appGreyColor[500],
                                fontSize: 16,
                                fontFamily: "rubikregular",
                                fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                              labelText: TeamCenterLocalizations.of(context)!
                                  .find('Address'),
                              border: InputBorder.none,
                              errorMaxLines: 1,
                              fillColor: Colors.transparent,
                              errorText: null,
                              labelStyle: TextStyle(
                                  color: AppColors.appGreyColor[500],
                                  fontSize: 14,
                                  fontFamily: "rubikregular",
                                  fontWeight: FontWeight.normal),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                            ),
                            maxLines: 1,
                            readOnly: true,
                            textInputAction: TextInputAction.none,
                            onChanged: (fullName) {},
                            validator: (fullName) {
                              if (fullName!.trim().length < 10) {
                                return 'Please enter valid phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          playerModel.data!.contact_type == "null"
                              ? Container()
                              : Wrap(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            playerModel.data!.contact_type!
                                                .split(",")
                                                .length;
                                        i++)
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .appGreyColor[500],
                                                      fontSize: 16,
                                                      fontFamily:
                                                          "rubikregular",
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  initialValue: playerModel
                                                      .data!.contact_name!
                                                      .split(",")[i],
                                                  decoration: InputDecoration(
                                                    labelText: playerModel.data!
                                                                .contact_type!
                                                                .split(
                                                                    ",")[i] ==
                                                            "parent"
                                                        ? TeamCenterLocalizations
                                                                .of(context)!
                                                            .find('Parrent')
                                                        : TeamCenterLocalizations
                                                                .of(context)!
                                                            .find('Other'),
                                                    border: InputBorder.none,
                                                    errorMaxLines: 1,
                                                    fillColor:
                                                        Colors.transparent,
                                                    errorText: null,
                                                    labelStyle: TextStyle(
                                                        color: AppColors
                                                            .appGreyColor[500],
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "rubikregular",
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    filled: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 0),
                                                  ),
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  textInputAction:
                                                      TextInputAction.none,
                                                  onChanged: (fullName) {},
                                                ),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  style: TextStyle(
                                                      color: AppColors.blue,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          "rubikregular",
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  initialValue: playerModel
                                                      .data!.phone_number!
                                                      .split(",")[i],
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        TeamCenterLocalizations
                                                                .of(context)!
                                                            .find('Phone'),
                                                    border: InputBorder.none,
                                                    errorMaxLines: 1,
                                                    fillColor:
                                                        Colors.transparent,
                                                    errorText: null,
                                                    labelStyle: TextStyle(
                                                        color: AppColors
                                                            .appGreyColor[500],
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "rubikregular",
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    filled: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 0),
                                                  ),
                                                  maxLines: 1,
                                                  readOnly: true,
                                                  textInputAction:
                                                      TextInputAction.none,
                                                  onChanged: (fullName) {},
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          )
                                        ],
                                      )
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget profileCommonUI() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mediumGrey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.grey[100]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: AppTextSize.textSize18(
                            playerModel.data!.shirtNumber == "null"
                                ? ""
                                : playerModel.data!.shirtNumber.toString(),
                            Colors.black,
                            FontWeight.bold,
                            "rubikregular",
                            1)),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Shirt'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.appGreyColor[500],
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AppTextSize.textSize18(
                          playerModel.data!.height.toString() + "cm",
                          Colors.black,
                          FontWeight.bold,
                          "rubikregular",
                          1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Height'),
                        style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.appGreyColor[500],
                            fontFamily: "rubikregular",
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Container(
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: AppTextSize.textSize18(
                            playerModel.data!.weight.toString() + "kg",
                            Colors.black,
                            FontWeight.bold,
                            "rubikregular",
                            1)),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Weight'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.appGreyColor[500],
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: playerModel.data!.isCaptian == 0
                          ? Container()
                          : Icon(
                              Icons.done,
                              color: Colors.black,
                              size: 30,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Captain'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.appGreyColor[500],
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: AppTextSize.textSize18(
                            playerModel.data!.fat.toString() + "%",
                            Colors.black,
                            FontWeight.bold,
                            "rubikregular",
                            1)),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Fat'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.appGreyColor[500],
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AppTextSize.textSize18(
                          playerModel.data!.muscle.toString() + "%",
                          Colors.black,
                          FontWeight.bold,
                          "rubikregular",
                          1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Muscle'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.appGreyColor[500],
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    playerModel.data!.age == 0
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AppTextSize.textSize18(
                                playerModel.data!.age.toString(),
                                Colors.black,
                                FontWeight.bold,
                                "rubikregular",
                                1),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Age'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.appGreyColor[500],
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AppTextSize.textSize18(
                          CommonMethod.appLanguage() == "English"
                              ? playerModel.data!.foot!.englishName!
                              : playerModel.data!.foot!.hebrewName!,
                          Colors.black,
                          FontWeight.bold,
                          "rubikregular",
                          1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Foot'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.appGreyColor[500],
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(child: Container())
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: playerModel.data!.yellowCard == 0
                          ? Container()
                          : Icon(
                              Icons.done,
                              color: Colors.black,
                              size: 30,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Yellow'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.yellowColor,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Container(
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokeColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: AppColors.tabGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: playerModel.data!.redCard == 0
                          ? Container()
                          : Icon(
                              Icons.done,
                              color: Colors.black,
                              size: 30,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        TeamCenterLocalizations.of(context)!.find('Red'),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "rubikregular",
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Container(
                height: 80,
              ))
            ],
          ),
        ],
      ),
    );
  }

  @override
  void onFailure(message) {
    Navigator.pop(context);
    isLoader = false;
  }

  @override
  void onSuccess(data) {
    Navigator.pop(context);
    isLoader = false;
    playerModel = PlayerModel.fromJson(data);
    _phoneController.text = playerModel.data!.loginMobileNumber.toString();
    _addressController.text =
        "${playerModel.data!.address == "null" ? "" : playerModel.data!.address} ${playerModel.data!.city == "null" ? "" : playerModel.data!.city} ${CommonMethod.appLanguage() == "English" ? playerModel.data!.country!.countryEng : playerModel.data!.country!.countryHb}";
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
  void updateBadge(id, String type) {
    // TODO: implement updateBadge
  }
}
