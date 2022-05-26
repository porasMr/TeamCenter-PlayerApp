import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/main.dart';
import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/GlobalConstants.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/shared_preferences.dart';
import 'package:team_center/utils/globals.dart' as globals;

import '../home_package copy/homePage.dart';


class OtpScreen extends StatefulWidget {
  var countryCode;
  var phone;
  OtpScreen({this.countryCode, this.phone});
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    implements ApiInterface, NotificationClick {
  TextEditingController otpcontroller = new TextEditingController();
  bool _isLoading = false;
  String isError = "";
  bool _isSendagain = false;
  String whichApiCall = "otp_verify";
  String versionName = "";

  @override
  void initState() {
    super.initState();
    getAppVersion();
    CommonMethod.initPlatformState(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AppTextSize.textSize20(
                            CommonMethod.appLanguage() == "English"
                                ? "${globals.model.data!.appScreen![1].text![0].label!}"
                                : "${globals.model.data!.appScreen![1].text![1].label!}",
                            AppColors.blue,
                            FontWeight.bold,
                            "rubikbold",
                            2),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      alignment: Alignment.center,
                      child: AppTextSize.textSize14(
                          CommonMethod.appLanguage() == "English"
                              ? "${globals.model.data!.appScreen![1].text![0].text!}"
                              : "${globals.model.data!.appScreen![1].text![1].text!}",
                          AppColors.appGreyColor[300]!,
                          FontWeight.normal,
                          "rubikregular",
                          3),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 32, right: 32),
                            child: AppTextSize.textSize16(
                                TeamCenterLocalizations.of(context)!
                                    .find('enterVerification'),
                                AppColors.appGreyColor[300]!,
                                FontWeight.normal,
                                "rubikregular",
                                1),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 32, right: 32),
                              alignment: CommonMethod.appLanguage() == "English"
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextSize.textSize16(
                                      widget.countryCode + "-" + widget.phone,
                                      AppColors.blackColor[500]!,
                                      FontWeight.normal,
                                      "rubikregular",
                                      1)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: PinCodeTextField(
                              hideCharacter: false,
                              autofocus: true,
                              controller: otpcontroller,
                              pinBoxWidth: 60.0,
                              pinBoxHeight: 60.0,
                              highlight: true,
                              pinBoxRadius: 5.0,
/*
                      highlightColor: Color.fromARGB(255, 191, 9, 48),
*/

                              defaultBorderColor: Colors.grey,
                              hasTextBorderColor: AppColors.textColor,

                              errorBorderColor: Colors.red,
                              pinBoxBorderWidth: 0.5,
                              isCupertino: true,
                              maxLength: 4,
                              onTextChanged: (text) {
                                setState(() {
                                  isError = "";
                                });
                              },
                              onDone: (text) {
                                if (text.length < 4) {
                                  setState(() {
                                    isError =
                                        TeamCenterLocalizations.of(context)!
                                            .find('thisFieldRequired');
                                  });
                                  // CommonMethod.showErrorFlushbar(
                                  //   context,
                                  //   TeamCenterLocalizations.of(context)!
                                  //       .find('thisFieldRequired'),
                                  // );
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  ApiCall.verifyOtpApi(
                                      otpcontroller.text,
                                      widget.phone,
                                      CommonMethod.appLanguage()!,
                                      versionName,
                                      this,
                                      context);
                                }
                              },

                              wrapAlignment: WrapAlignment.spaceBetween,
                              pinBoxDecoration: ProvidedPinBoxDecoration
                                  .defaultPinBoxDecoration,
                              pinTextStyle: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                              pinTextAnimatedSwitcherTransition:
                                  ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                              pinTextAnimatedSwitcherDuration:
                                  Duration(milliseconds: 300),
//                    highlightAnimation: true,
                              highlightAnimationBeginColor: Colors.black,
                              highlightAnimationEndColor: Colors.white12,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          isError == ""
                              ? Container()
                              : SizedBox(
                                  height: 10,
                                ),
                          isError == ""
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.only(left: 52, right: 52),
                                  width: MediaQuery.of(context).size.width,
                                  child: AppTextSize.textSize14(
                                      isError,
                                      Colors.red,
                                      FontWeight.normal,
                                      "rubikregular",
                                      1),
                                ),
                          SizedBox(height: 20),
                          registerButton(),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 32, right: 32),
                              alignment: Alignment.center,
                              child: AppTextSize.textSize16(
                                  TeamCenterLocalizations.of(context)!
                                      .find('changePhoneNumber'),
                                  AppColors.blue,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 32, right: 32),
                          child: AppTextSize.textSize16(
                              TeamCenterLocalizations.of(context)!
                                  .find('didNotGetTheCode'),
                              AppColors.appGreyColor[300]!,
                              FontWeight.normal,
                              "rubikregular",
                              1),
                        ),
                        SizedBox(height: 10),
                        sendAgainButton(),
                        SizedBox(height: 40),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  registerButton() {
    if (Platform.isIOS) {
      return Container(
        margin: EdgeInsets.only(left: 32, right: 32),
        width: MediaQuery.of(context).size.width,
        child: _isLoading == false
            ? new CupertinoButton(
                padding: EdgeInsets.all(10),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(20.0)),
                onPressed: () {
                  if (otpcontroller.text.length == 0) {
                    setState(() {
                      isError = TeamCenterLocalizations.of(context)!
                          .find('thisFieldRequired');
                    });
                    // CommonMethod.showErrorFlushbar(
                    //   context,
                    //   TeamCenterLocalizations.of(context)!
                    //       .find('thisFieldRequired'),
                    // );
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    whichApiCall = "otp_verify";

                    ApiCall.verifyOtpApi(
                        otpcontroller.text,
                        widget.phone,
                        CommonMethod.appLanguage()!,
                        versionName,
                        this,
                        context);
                  }
                },
                color: AppColors.defaultAppColor[500],
                child: AppTextSize.textSize16(
                    TeamCenterLocalizations.of(context)!.find('next'),
                    AppColors.whiteColor[500]!,
                    FontWeight.bold,
                    "rubikregular",
                    1),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: Image.asset(AppImages.loaderGif, width: 60, height: 60)),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 32, right: 32),
        width: MediaQuery.of(context).size.width,
        child: _isLoading == false
            ? new MaterialButton(
                onPressed: () {
                  if (otpcontroller.text.length == 0) {
                    setState(() {
                      isError = TeamCenterLocalizations.of(context)!
                          .find('thisFieldRequired');
                    });
                    // CommonMethod.showErrorFlushbar(
                    //   context,
                    //   TeamCenterLocalizations.of(context)!
                    //       .find('thisFieldRequired'),
                    // );
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    whichApiCall = "otp_verify";

                    ApiCall.verifyOtpApi(
                        otpcontroller.text,
                        widget.phone,
                        CommonMethod.appLanguage()!,
                        versionName,
                        this,
                        context);
                  }
                },
                color: AppColors.defaultAppColor[500],
                splashColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20.0)),
                ),
                padding: EdgeInsets.all(10),
                child: AppTextSize.textSize16(
                    TeamCenterLocalizations.of(context)!.find('next'),
                    AppColors.whiteColor[500]!,
                    FontWeight.bold,
                    "rubikregular",
                    1),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: Image.asset(AppImages.loaderGif, width: 60, height: 60)),
      );
    }
  }

  sendAgainButton() {
    if (Platform.isIOS) {
      return Container(
        margin: EdgeInsets.only(left: 32, right: 32),
        width: MediaQuery.of(context).size.width,
        child: _isSendagain == false
            ? new CupertinoButton(
                padding: EdgeInsets.all(10),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(20.0)),
                onPressed: () {
                  setState(() {
                    _isSendagain = true;
                  });
                  whichApiCall = "send_again";
                  ApiCall.sendOtpApi(
                      widget.countryCode, widget.phone, this, context);
                },
                color: Colors.grey[200],
                child: AppTextSize.textSize16(
                    TeamCenterLocalizations.of(context)!.find('sentAgain'),
                    AppColors.blackColor[300]!,
                    FontWeight.normal,
                    "rubikregular",
                    1),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: Image.asset(AppImages.loaderGif, width: 60, height: 60)),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 32, right: 32),
        width: MediaQuery.of(context).size.width,
        child: _isSendagain == false
            ? new MaterialButton(
                onPressed: () {
                  setState(() {
                    _isSendagain = true;
                  });
                  whichApiCall = "send_again";

                  ApiCall.sendOtpApi(
                      widget.countryCode, widget.phone, this, context);
                },
                color: Colors.grey[200],
                splashColor: Colors.black12,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20.0)),
                    side: BorderSide(color: Colors.grey)),
                padding: EdgeInsets.all(10),
                child: AppTextSize.textSize16(
                    TeamCenterLocalizations.of(context)!.find('sentAgain'),
                    AppColors.blackColor[300]!,
                    FontWeight.normal,
                    "rubikregular",
                    1),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: Image.asset(AppImages.loaderGif, width: 60, height: 60)),
      );
    }
  }

  @override
  void onFailure(message) {
    setState(() {
      _isLoading = false;
      isError = message;
      _isSendagain = false;
    });
  }

  @override
  void onSuccess(data) {
    if (whichApiCall == "otp_verify") {
      setState(() {
        _isLoading = false;
      });
      var d = jsonEncode(data['data']);
      print(d);
      var type = jsonDecode(d);
      SharedPref.saveProfileData(d);
      SharedPref.saveLoginToken(data[GlobalConstants.token]);
      SharedPref.saveBooleanInPrefs(GlobalConstants.LOGINSTATUS, true);
      if (data['data'][GlobalConstants.app_language] == "English") {
        Locale newLocale = Locale("en");
        MyHomePage.setLocale(context, newLocale);
      } else {
        Locale newLocale = Locale("he");
        MyHomePage.setLocale(context, newLocale);
      }
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: HomePageScreen()));
    } else {
      setState(() {
        _isSendagain = false;
      });
    }
  }

  @override
  void onClick(id, String type) {
    // TODO: implement onClick
  }
  @override
  void updateBadge(id, String type) {}
}
