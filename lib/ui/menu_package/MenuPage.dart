import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/game_section_package/GameScreen.dart';

import 'package:team_center/main.dart';
import 'package:team_center/ui/menu_package/MyAbility.dart';

import 'package:team_center/ui/menu_package/account.dart';
import 'package:team_center/ui/menu_package/PlayerObjectiveScreen.dart';
import 'package:team_center/ui/menu_package/test_details.dart';

import 'package:team_center/ui/terms_and_consitions_package/TermsAndConditions.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:package_info/package_info.dart';
import 'package:team_center/utils/shared_preferences.dart';
import 'package:team_center/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;

import '../managment_instruction_package/managment_instruaction.dart';
import '../professional_package/ProfessionalKnowledagePage.dart';
import '../tranning_package/TimeTrainingScreen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var packageInfo;
  String versionname = "";
  int managementCount = 0;
  int professionaKnowledgeCount = 0;
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      versionname = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      setState(() {});
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 25,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: AccountScreen()))
                                            .then((value) {});
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: Container(
                                              width: 70.0,
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              padding: EdgeInsets.all(1.0),
                                              child: CachedNetworkImage(
                                                imageUrl: CommonMethod
                                                            .clubLogoImage() ==
                                                        "null"
                                                    ? ""
                                                    : CommonMethod
                                                        .clubLogoImage()!,
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
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Container(
                                                        width: 70,
                                                        height: 70,
                                                        child: Icon(Icons
                                                            .perm_identity)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 20, left: 40),
                                            child: Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              padding: EdgeInsets.all(1.0),
                                              child: CachedNetworkImage(
                                                imageUrl: CommonMethod
                                                            .profileImage() ==
                                                        "null"
                                                    ? ""
                                                    : CommonMethod
                                                        .profileImage()!,
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
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Container(
                                                        width: 50,
                                                        height: 50,
                                                        child: Icon(Icons
                                                            .perm_identity)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                AppTextSize.textSize14(
                                    CommonMethod.userName()! +
                                        " " +
                                        CommonMethod.userLastName()!,
                                    Colors.black,
                                    FontWeight.normal,
                                    "rubikregular",
                                    1),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: AccountScreen()))
                              .then((value) {});
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.setting,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('account'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.myprofile,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('myprofile'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: PlayerObjectiveScreen()))
                              .then((value) {});
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.myobjective,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('myObjective'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: MyAbilityScreen()))
                              .then((value) {});
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.checkIcon,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('myAbilities'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ManagmentInstructionScreen()))
                              .then((value) {});
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                child: Container(
                                  width: 25.0,
                                  height: 25.0,
                                  padding: EdgeInsets.all(1.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        CommonMethod.clubLogoImage() == "null"
                                            ? ""
                                            : CommonMethod.clubLogoImage()!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            width: 25,
                                            height: 25,
                                            child: Icon(Icons.perm_identity)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('management_instructions'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                              Spacer(),
                              managementCount == 0
                                  ? Container()
                                  : Container(
                                      width: 40,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: AppTextSize.textSize12(
                                          "$managementCount",
                                          Colors.white,
                                          FontWeight.normal,
                                          "rubikregular",
                                          1),
                                      decoration: BoxDecoration(
                                          color: AppColors.defaultAppColor[500],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                              SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: TimeTrainingScreen()))
                              .then((value) {});
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.traning,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('Training'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: GameScreen()))
                              .then((value) {});
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.games,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('Games'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: TestDetailsScreen()))
                              .then((value) {});
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.tests,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('Tests'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.feedback,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('feedbacks'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.note,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('messages'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.medical,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('medical'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ProfessionalKnowledagePage()))
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.info,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('professional_knowledge'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: TermsAndConditionsScreen()))
                              .then((value) {});
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset(
                                AppImages.terms,
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AppTextSize.textSize14(
                                  TeamCenterLocalizations.of(context)!
                                      .find('tc'),
                                  Colors.black,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
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
                    InkWell(
                      onTap: () {
                        logoutDiloag();
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Image.asset(
                              AppImages.logout,
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            AppTextSize.textSize14(
                                TeamCenterLocalizations.of(context)!
                                    .find('logout'),
                                Colors.red,
                                FontWeight.normal,
                                "rubikregular",
                                1),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    AppTextSize.textSize12(
                        "${globals.model.data!.generalSetting!.creater}",
                        Colors.black,
                        FontWeight.normal,
                        "rubikregular",
                        1),
                    SizedBox(height: 5),
                    AppTextSize.textSize14(
                        TeamCenterLocalizations.of(context)!.find('Version') +
                            " $versionname",
                        Colors.black,
                        FontWeight.w400,
                        "rubikregular",
                        1),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          )),
    );
  }

  void logoutDiloag() {
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
                    TeamCenterLocalizations.of(context)!.find('logout_msg'),
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
                  height: 20,
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
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              TeamCenterLocalizations.of(context)!.find('No'),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'rubikregular',
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                        width: 1,
                        color: AppColors.mediumGrey,
                        height: 50,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            SharedPref.logout();
                            if (Platform.localeName.contains("he")) {
                              Locale newLocale = Locale("he");
                              MyHomePage.setLocale(context, newLocale);
                            } else {
                              Locale newLocale = Locale("en");
                              MyHomePage.setLocale(context, newLocale);
                            }
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/LoginScreen',
                                (Route<dynamic> route) => false);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            alignment: Alignment.center,
                            height: 50,
                            child: Text(
                              TeamCenterLocalizations.of(context)!.find('Yes'),
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

  @override
  void onClick(id, type) {}
}
