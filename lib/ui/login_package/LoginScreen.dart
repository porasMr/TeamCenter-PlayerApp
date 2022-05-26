import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/picker/country_code_picker.dart';
import 'package:team_center/ui/contactus_package/ContactUs.dart';
import 'package:team_center/ui/otp_package/OtpScreen.dart';
import 'package:team_center/ui/terms_and_consitions_package/TermsAndConditions.dart';
import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/globals.dart' as globals;
import 'package:team_center/utils/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements ApiInterface {
  TextEditingController phoneController = new TextEditingController();
  final GlobalKey _textKey = new GlobalKey();

  bool _isLoading = false;
  String isError = "";
  @override
  void initState() {
    super.initState();
    print("player id:==" + SharedPref.getPlayerId());
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   if (widget.message != null) {
    //     if (widget.message != "") {
    //       CommonMethod.showErrorFlushbar(context, widget.message!);
    //     }
    //   }
    // });
  }

  String countryCode = "+972";

  @override
  void dispose() {
    super.dispose();
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
                padding: EdgeInsets.all(16),
                child: Column(
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
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      alignment: CommonMethod.appLanguage() == "English"
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: AppTextSize.textSize16(
                          TeamCenterLocalizations.of(context)!
                              .find('loginWithPhone'),
                          AppColors.appGreyColor[300]!,
                          FontWeight.normal,
                          "rubikregular",
                          1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: CommonMethod.appLanguage() == "English"
                            ? Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextSize.textSize16(
                                                TeamCenterLocalizations.of(
                                                        context)!
                                                    .find('countryCode'),
                                                AppColors.appGreyColor[300]!,
                                                FontWeight.normal,
                                                "rubikregular",
                                                1),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: CountryCodePicker(
                                                      padding: EdgeInsets.zero,
                                                      onChanged: (v) {
                                                        countryCode =
                                                            v.dialCode!;
                                                      },

                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                      initialSelection: 'IL',
                                                      favorite: ['+972', '+91'],
                                                      // optional. Shows only country name and flag
                                                      showCountryOnly: false,
                                                      // optional. Shows only country name and flag when popup is closed.
                                                      showOnlyCountryWhenClosed:
                                                          false,
                                                      flagWidth: 0,
                                                      showFlag: false,

                                                      // optional. aligns the flag and the Text left
                                                      alignLeft: false,
                                                    ),
                                                  ),
                                                  Icon(Icons.arrow_drop_down,
                                                      color: Colors.grey)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextSize.textSize16(
                                                TeamCenterLocalizations.of(
                                                        context)!
                                                    .find('phoneNumber'),
                                                AppColors.appGreyColor[300]!,
                                                FontWeight.normal,
                                                "rubikregular",
                                                1),
                                            Container(
                                              height: 55,
                                              child: TextFormField(
                                                controller: phoneController,
                                                cursorColor: Colors.black,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                onFieldSubmitted: (v) {},
                                                onChanged: (v) {
                                                  setState(() {
                                                    isError = "";
                                                  });
                                                },
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: "rubikregular"),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,

                                                  /* contentPadding:
                                      EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextSize.textSize16(
                                                TeamCenterLocalizations.of(
                                                        context)!
                                                    .find('phoneNumber'),
                                                AppColors.appGreyColor[300]!,
                                                FontWeight.normal,
                                                "rubikregular",
                                                1),
                                            Container(
                                              height: 55,
                                              child: TextFormField(
                                                controller: phoneController,
                                                cursorColor: Colors.black,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                onFieldSubmitted: (v) {},
                                                onChanged: (v) {
                                                  setState(() {
                                                    isError = "";
                                                  });
                                                },
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: "rubikregular"),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,

                                                  /* contentPadding:
                                      EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            AppTextSize.textSize16(
                                                TeamCenterLocalizations.of(
                                                        context)!
                                                    .find('countryCode'),
                                                AppColors.appGreyColor[300]!,
                                                FontWeight.normal,
                                                "rubikregular",
                                                1),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: CountryCodePicker(
                                                      padding: EdgeInsets.zero,
                                                      onChanged: (v) {
                                                        countryCode =
                                                            v.dialCode!;
                                                      },

                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                      initialSelection: 'IL',
                                                      favorite: ['+972', '+91'],
                                                      // optional. Shows only country name and flag
                                                      showCountryOnly: false,
                                                      // optional. Shows only country name and flag when popup is closed.
                                                      showOnlyCountryWhenClosed:
                                                          false,
                                                      flagWidth: 0,
                                                      showFlag: false,

                                                      // optional. aligns the flag and the Text left
                                                      alignLeft: false,
                                                    ),
                                                  ),
                                                  Icon(Icons.arrow_drop_down,
                                                      color: Colors.grey)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              )),
                    isError == ""
                        ? Container()
                        : SizedBox(
                            height: 10,
                          ),
                    isError == ""
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerRight,
                            child: AppTextSize.textSize14(isError, Colors.red,
                                FontWeight.normal, "rubikregular", 1),
                          ),
                    SizedBox(height: 40),
                    registerButton(),
                    SizedBox(height: 80),
                    CommonMethod.appLanguage() == "English"
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: TermsAndConditionsScreen()));
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "By continuing, you agree to accept our",
                                      style: TextStyle(
                                        fontFamily: "rubikregular",
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 0.5,
                                        color: AppColors.appGreyColor[300]!,
                                      ),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "Terms and conditions",
                                        style: TextStyle(
                                          fontFamily: "rubikregular",
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.5,
                                          color: AppColors.blue,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 16, right: 16),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ע\"י לחיצה על המשך אני מאשר שקראתי ואני",
                                    style: TextStyle(
                                      fontFamily: "rubikregular",
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.5,
                                      color: AppColors.appGreyColor[300]!,
                                    ),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16, right: 16),
                                alignment: Alignment.center,
                                child: RichText(
                                  key: _textKey,
                                  text: TextSpan(
                                    text: 'מסכים ',
                                    style: TextStyle(
                                      fontFamily: "rubikregular",
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.5,
                                      color: AppColors.appGreyColor[300]!,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            await Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child:
                                                        TermsAndConditionsScreen()));
                                          },
                                        text: 'לתנאי השימוש ',
                                        style: TextStyle(
                                          fontFamily: "rubikregular",
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.blue,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'של האפליקציה',
                                          style: TextStyle(
                                            fontFamily: "rubikregular",
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.appGreyColor[300]!,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: AppTextSize.textSize16(
                                TeamCenterLocalizations.of(context)!
                                    .find('dont_have_account'),
                                AppColors.appGreyColor[300]!,
                                FontWeight.normal,
                                "rubikregular",
                                1),
                          ),
                          SizedBox(height: 10),
                          contactUsButton(),
                          SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  contactUsButton() {
    if (Platform.isIOS) {
      return Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          child: new CupertinoButton(
            padding: EdgeInsets.all(10),
            borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: ContactUsScreen()));
            },
            color: AppColors.progressBlueFill,
            child: AppTextSize.textSize16(
                TeamCenterLocalizations.of(context)!.find('contact_us'),
                Colors.white,
                FontWeight.normal,
                "rubikregular",
                1),
          ));
    } else {
      return Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          child: new MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: ContactUsScreen()));
            },
            color: Colors.grey[200],
            splashColor: Colors.black12,
            shape: RoundedRectangleBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(20.0)),
                side: BorderSide(
                  color: AppColors.progressBlueFill,
                )),
            padding: EdgeInsets.all(10),
            child: AppTextSize.textSize16(
                TeamCenterLocalizations.of(context)!.find('contact_us'),
                Colors.white,
                FontWeight.normal,
                "rubikregular",
                1),
          ));
    }
  }

  registerButton() {
    if (Platform.isIOS) {
      return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        child: _isLoading == false
            ? new CupertinoButton(
                padding: EdgeInsets.all(10),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(20.0)),
                onPressed: () {
                  if (phoneController.text.length == 0) {
                    setState(() {
                      isError = TeamCenterLocalizations.of(context)!
                          .find('thisFieldRequired');
                    });
                  } else if (phoneController.text.length < 10) {
                    setState(() {
                      isError = TeamCenterLocalizations.of(context)!
                          .find('thisNumberDoesNotExits');
                    });
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    ApiCall.sendOtpApi(
                        countryCode, phoneController.text, this, context);
                  }
                },
                color: AppColors.defaultAppColor[500],
                child: AppTextSize.textSize16(
                    TeamCenterLocalizations.of(context)!.find('next'),
                    AppColors.whiteColor[500]!,
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
      return _isLoading == false
          ? Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: new MaterialButton(
                onPressed: () {
                  if (phoneController.text.length == 0) {
                    setState(() {
                      isError = TeamCenterLocalizations.of(context)!
                          .find('thisFieldRequired');
                    });
                  } else if (phoneController.text.length < 10) {
                    setState(() {
                      isError = TeamCenterLocalizations.of(context)!
                          .find('thisNumberDoesNotExits');
                    });
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    ApiCall.sendOtpApi(
                        countryCode, phoneController.text, this, context);
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
                    FontWeight.normal,
                    "rubikregular",
                    1),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              child: Image.asset(AppImages.loaderGif, width: 60, height: 60));
    }
  }

  @override
  void onFailure(message) {
    setState(() {
      _isLoading = false;
      isError = message;
    });
  }

  @override
  void onSuccess(data) {
    setState(() {
      _isLoading = false;
    });
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: OtpScreen(
              countryCode: countryCode,
              phone: phoneController.text,
            )));
  }
}
