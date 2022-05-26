import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/main.dart';

import 'package:team_center/ui/login_package/LoginScreen.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/GlobalConstants.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/model/GernealStringModel.dart';
import 'package:team_center/utils/shared_preferences.dart';
import 'package:team_center/utils/globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    implements ApiInterface, NotificationClick {
  var deviceType;
  bool? isLoggedIn;
  getStatus() {
    Future<bool> status = SharedPref.getBool(GlobalConstants.LOGINSTATUS);
    status
        .then((value) => {isLoggedIn = value, print("Splash value ::: $value")},
            onError: (err) {
      print("Error occured :: $err");
    });
  }

  String versionName = "";
  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
  }

  String whichApiCall = "generalSetting";

  @override
  void initState() {
    super.initState();
    getStatus();
    CommonMethod.initPlatformState(this);
    getAppVersion();
    ApiCall.generalSetting(context, this);
  }

  getDeviceType() {
    if (Platform.isIOS) {
      deviceType = "ios";
    } else {
      deviceType = "android";
    }
  }

  hundler() {
    if (isLoggedIn == true) {
      if (CommonMethod.appLanguage() == "English") {
        Locale newLocale = Locale("en");
        MyHomePage.setLocale(context, newLocale);
      } else {
        Locale newLocale = Locale("he");
        MyHomePage.setLocale(context, newLocale);
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/HomePageScreen', (Route<dynamic> route) => false);
    } else {
      Navigator.pushReplacement(context,
          PageTransition(type: PageTransitionType.fade, child: LoginScreen()));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor[500],
        body: SafeArea(
          top: false,
          bottom: true,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    AppImages.appIcon,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.loaderGif,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 20),
                  child: AppTextSize.textSize16(
                      TeamCenterLocalizations.of(context)!.find('companyName'),
                      Colors.black,
                      FontWeight.normal,
                      "rubikregular",
                      1))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onFailure(message) {
    print("failuer");
    CommonMethod.showErrorFlushbar(context, message);
  }

  @override
  void onSuccess(data) {
    if (whichApiCall == "generalSetting") {
      globals.model = new GernealStringModel.fromJson(data);
      print(
          "version:=${new GernealStringModel.fromJson(data).data!.generalSetting!.android_latest_version!}");
      print("nkjdnbckjdnc${Platform.localeName}");
      if (isLoggedIn == false) {
        if (Platform.localeName.contains("he")) {
          Locale newLocale = Locale("he");
          MyHomePage.setLocale(context, newLocale);
        } else {
          Locale newLocale = Locale("en");
          MyHomePage.setLocale(context, newLocale);
        }
      }
      hundler();
      // if (Platform.isIOS) {
      //   if (versionCheck(new GernealStringModel.fromJson(data)
      //       .data!
      //       .generalSetting!
      //       .ios_latest_version!)) {
      //     updateDiloag();
      //   } else {
      //     if (isLoggedIn == false) {
      //       hundler();
      //     } else {
      //       whichApiCall = "";
      //       ApiCall.updateOneSignalToken(this, context);
      //     }
      //   }
      // } else {
      //   if (versionCheck(new GernealStringModel.fromJson(data)
      //       .data!
      //       .generalSetting!
      //       .android_latest_version!)) {
      //     updateDiloag();
      //   } else {
      //     if (isLoggedIn == false) {
      //       hundler();
      //     } else {
      //       whichApiCall = "";
      //       ApiCall.updateOneSignalToken(this, context);
      //     }
      //   }
      // }
    } else {
      hundler();
    }
  }

  bool versionCheck(String appVersion) {
    int intA = int.parse(versionName.replaceAll(".", ""));
    int intB = int.parse(appVersion.replaceAll(".", ""));

    if (intB > intA) {
      return true;
    }
    return false;
  }

  void updateDiloag() {
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
                  alignment: Alignment.center,
                  child: Text(
                    TeamCenterLocalizations.of(context)!
                        .find('Update_application'),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'rubikregular',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.0,
                        height: 1.5),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  alignment: Alignment.center,
                  child: Text(
                    TeamCenterLocalizations.of(context)!
                        .find('Your_application'),
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.0,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            if (Platform.isAndroid) {
                              LaunchReview.launch(
                                  androidAppId: "com.shtibel.teamcenter");
//                  _launchAppStore(url);
                            } else {
//                  _launchAppStore(url);
                              LaunchReview.launch(
                                  iOSAppId: "1569965895", writeReview: false);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            alignment: Alignment.center,
                            height: 50,
                            child: Text(
                              TeamCenterLocalizations.of(context)!
                                  .find('Update'),
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
  void onClick(id, type) {
    // TODO: implement onClick
  }
  @override
  void updateBadge(id, String type) {}
}
