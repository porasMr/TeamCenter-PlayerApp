import 'dart:async';
import 'dart:convert' show jsonDecode, json;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:team_center/apiservice/api_call.dart';

import '../../apiservice/api_interface.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppTextSize.dart';
import '../../utils/CommonMethod.dart';
import '../../utils/TeamCenterLocalizations.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with SingleTickerProviderStateMixin
    implements ApiInterface {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();
  FocusNode nameNode = new FocusNode();
  FocusNode emailNode = new FocusNode();
  FocusNode phoneNode = new FocusNode();
  FocusNode messageNode = new FocusNode();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          color: AppColors.whiteColor[500],
          child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
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
                              Navigator.pop(context);
                            },
                            child: AppTextSize.textSize20(
                                TeamCenterLocalizations.of(context)!
                                    .find('contact_us'),
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
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.all(24),
                          children: [
                            AppTextSize.textSize18(
                                "Want to join Team Center ?",
                                Colors.black,
                                FontWeight.bold,
                                "rubikregular",
                                1),
                            SizedBox(
                              height: 16,
                            ),
                            AppTextSize.textSize14(
                                "You can contact us at: ",
                                Colors.black,
                                FontWeight.normal,
                                "rubikregular",
                                1),
                            SizedBox(
                              height: 8,
                            ),
                            AppTextSize.textSize14(
                                "info@teamcenter.com",
                                AppColors.blue,
                                FontWeight.normal,
                                "rubikregular",
                                1),
                            SizedBox(
                              height: 16,
                            ),
                            AppTextSize.textSize16(
                                "Or leave a message and we will get back to you as soon as possible.",
                                Colors.black,
                                FontWeight.normal,
                                "rubikregular",
                                2),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              focusNode: nameNode,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textDirection: TextDirection.ltr,
                              textAlign: CommonMethod.appLanguage() == "English"
                                  ? TextAlign.left
                                  : TextAlign.right,
                              keyboardType: TextInputType.text,
                              controller: nameController,
                              onEditingComplete: () {
                                // setState(() {
                                //   autoNameValidate = AutovalidateMode.disabled;
                                // });
                              },
                              validator: (val) =>
                                  CommonMethod.validateNameField(val!, context),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "rubikregular",
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mediumGrey),
                                ),
                                labelText: TeamCenterLocalizations.of(context)!
                                    .find('Name'),
                                errorMaxLines: 1,
                                fillColor: Colors.white,
                                errorText: null,
                                labelStyle: TextStyle(
                                    color: AppColors.blue,
                                    fontSize: 16,
                                    fontFamily: "rubikregular",
                                    fontWeight: FontWeight.normal),
                                // contentPadding:
                                //     EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              ),
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onChanged: (fullName) {},
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              focusNode: phoneNode,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textDirection: TextDirection.ltr,
                              textAlign: CommonMethod.appLanguage() == "English"
                                  ? TextAlign.left
                                  : TextAlign.right,
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              onEditingComplete: () {},
                              validator: (val) =>
                                  CommonMethod.validateNameField(val!, context),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "rubikregular",
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mediumGrey),
                                ),
                                labelText: TeamCenterLocalizations.of(context)!
                                    .find('Phone'),
                                errorMaxLines: 1,
                                fillColor: Colors.white,
                                errorText: null,
                                labelStyle: TextStyle(
                                    color: AppColors.blue,
                                    fontSize: 16,
                                    fontFamily: "rubikregular",
                                    fontWeight: FontWeight.normal),
                                // contentPadding:
                                //     EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              ),
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onChanged: (fullName) {},
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              focusNode: emailNode,
                              textDirection: TextDirection.ltr,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textAlign: CommonMethod.appLanguage() == "English"
                                  ? TextAlign.left
                                  : TextAlign.right,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              onEditingComplete: () {
                                // setState(() {
                                //   autoNameValidate = AutovalidateMode.disabled;
                                // });
                              },
                              validator: (val) =>
                                  CommonMethod.validateNameField(val!, context),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "rubikregular",
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mediumGrey),
                                ),
                                labelText: TeamCenterLocalizations.of(context)!
                                    .find('Email'),
                                errorMaxLines: 1,
                                fillColor: Colors.white,
                                errorText: null,
                                labelStyle: TextStyle(
                                    color: AppColors.blue,
                                    fontSize: 16,
                                    fontFamily: "rubikregular",
                                    fontWeight: FontWeight.normal),
                                // contentPadding:
                                //     EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              ),
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              onChanged: (fullName) {},
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,

                              controller: messageController,
                              validator: (val) =>
                                  CommonMethod.validateNameField(val!, context),
                              focusNode: messageNode,
                              cursorColor: AppColors.blue,
                              keyboardType: TextInputType.multiline,
                              //textInputAction: TextInputAction.newline,
                              maxLines: null,
                              onFieldSubmitted: (v) {
                                setState(() {});
                              },
                              onChanged: (v) {
                                setState(() {});
                              },
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  height: 2.0,
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mediumGrey),
                                  ),
                                  labelText:
                                      TeamCenterLocalizations.of(context)!
                                          .find('message'),
                                  labelStyle: TextStyle(
                                      color: AppColors.blue,
                                      fontSize: 16,
                                      fontFamily: "rubikregular",
                                      fontWeight: FontWeight.normal),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontFamily: "rubikregular",
                                      fontWeight: FontWeight.normal)

                                  /* contentPadding:
                                                EdgeInsets.fromLTRB(10.0, 15.0, 24.0, 15.0),*/
                                  ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            sendButton(),
                            SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  sendButton() {
    if (Platform.isIOS) {
      return Container(
          width: MediaQuery.of(context).size.width,
          child: new CupertinoButton(
            padding: EdgeInsets.all(10),
            borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
            onPressed: () {
              _validateInputs();
            },
            color: AppColors.defaultAppColor[500],
            child: AppTextSize.textSize16(
                TeamCenterLocalizations.of(context)!.find('send'),
                Colors.white,
                FontWeight.normal,
                "rubikregular",
                1),
          ));
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          child: new MaterialButton(
            onPressed: () {
              _validateInputs();
            },
            color: AppColors.defaultAppColor[500],
            splashColor: Colors.black12,
            shape: RoundedRectangleBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(20.0)),
                side: BorderSide(
                  color: AppColors.progressBlueFill,
                )),
            padding: EdgeInsets.all(10),
            child: AppTextSize.textSize16(
                TeamCenterLocalizations.of(context)!.find('send'),
                Colors.white,
                FontWeight.normal,
                "rubikregular",
                1),
          ));
    }
  }

  void _validateInputs() async {
    if (_formKey.currentState!.validate()) {
      hundler();
      ApiCall.contactUsApi(nameController.text, phoneController.text,
          emailController.text, messageController.text, this, context);
    } else {
//
    }
  }

  @override
  void onFailure(message) {
    Navigator.pop(context);
    CommonMethod.showErrorFlushbar(context, message);
  }

  @override
  void onSuccess(data) {
    Navigator.pop(context);

    CommonMethod.showSuccessFlushbar(context, data['message']);
  }
}
