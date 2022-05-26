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

import '../../main.dart';
import '../../utils/SelectImageInterface.dart';
import '../../utils/SelectOtherImageWithCrop.dart';
import '../home_package copy/homePage.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    implements ApiInterface, SelectedImage, NotificationClick {
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();

  TextEditingController phoneController = new TextEditingController();

  TextEditingController countryController = new TextEditingController();

  TextEditingController cityController = new TextEditingController();

  TextEditingController addressController = new TextEditingController();

  TextEditingController appLanguageController = new TextEditingController();

  List<String> appLanguageList = ["English", "עברית"];
  String languageDropdownvalue = "עברית";
  String? _imagePath = "";
  String countryId = "";
  String whichApiCall = "getProfile";

  @override
  void initState() {
    super.initState();
    ApiCall.getProfile(this, context);
    nameController.text = CommonMethod.userName()!;
    lastNameController.text = CommonMethod.userLastName()!;

    phoneController.text = CommonMethod.phone()!;
    countryController.text =
        CommonMethod.country() == "null" ? "" : CommonMethod.country()!;

    cityController.text =
        CommonMethod.city() == "null" ? "" : CommonMethod.city()!;

    addressController.text =
        CommonMethod.address() == "null" ? "" : CommonMethod.address()!;

    appLanguageController.text = CommonMethod.appLanguage()!;
    languageDropdownvalue = CommonMethod.appLanguage()!;
    countryId = CommonMethod.countryId()!;
    CommonMethod.initPlatformState(this);
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
                                              .find('account'),
                                          AppColors.blue,
                                          FontWeight.normal,
                                          "rubikregular",
                                          1),
                                    ),
                                  ]),
                            ),
                            Row(children: [
                              InkWell(
                                onTap: () {
                                  whichApiCall = "updateProfile";
                                  hundler();
                                  ApiCall.editProfile(
                                      nameController.text,
                                      lastNameController.text,
                                      countryId,
                                      cityController.text,
                                      addressController.text,
                                      phoneController.text,
                                      languageDropdownvalue,
                                      _imagePath!,
                                      this,
                                      context);
                                },
                                child: AppTextSize.textSize18(
                                    TeamCenterLocalizations.of(context)!
                                        .find('Done'),
                                    AppColors.blue,
                                    FontWeight.normal,
                                    "rubikregular",
                                    1),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ]),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        )
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
                        Container(
                          alignment: Alignment.center,
                          height: 140,
                          child: Stack(
                            children: [
                              _imagePath == ""
                                  ? Container(
                                      width: 135.0,
                                      height: 135.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0, color: Colors.grey),
                                        shape: BoxShape.circle,
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
                                          width: 135,
                                          height: 135,
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
                                          width: 135,
                                          height: 135,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                                width: 135,
                                                height: 135,
                                                child:
                                                    Icon(Icons.perm_identity)),
                                      ),
                                    )
                                  : new ClipOval(
                                      child: Image.file(
                                        File(_imagePath!),
                                        alignment: Alignment.center,
                                        width: 135,
                                        height: 135,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              InkWell(
                                onTap: () {
                                  SelectImageWithCrop.photoClickDiloag(
                                      context, this);
                                },
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  margin: EdgeInsets.only(bottom: 15),
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      padding: EdgeInsets.all(2),
                                      child: Image.asset(AppImages.edit)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: nameController,
                                cursorColor: AppColors.blue,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (v) {
                                  setState(() {});
                                },
                                onChanged: (v) {
                                  setState(() {});
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mediumGrey),
                                    ),
                                    labelText:
                                        TeamCenterLocalizations.of(context)!
                                            .find('first_name'),
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
                                      EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: lastNameController,
                                cursorColor: AppColors.blue,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (v) {
                                  setState(() {});
                                },
                                onChanged: (v) {
                                  setState(() {});
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mediumGrey),
                                    ),
                                    labelText:
                                        TeamCenterLocalizations.of(context)!
                                            .find('last_name'),
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
                                      EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                textDirection: TextDirection.ltr,
                                controller: phoneController,
                                cursorColor: AppColors.blue,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (v) {
                                  setState(() {});
                                },
                                onChanged: (v) {
                                  setState(() {});
                                },
                                textAlign:
                                    CommonMethod.appLanguage() == "English"
                                        ? TextAlign.left
                                        : TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mediumGrey),
                                    ),
                                    labelText:
                                        TeamCenterLocalizations.of(context)!
                                            .find('Phone'),
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
                                      EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: countryController,
                                cursorColor: AppColors.blue,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: CountryList()))
                                      .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        countryController.text =
                                            CommonMethod.appLanguage() ==
                                                    "English"
                                                ? value.countryEng
                                                : value.countryHb;
                                        print(countryId);
                                        countryId = value.id.toString();
                                      });
                                    }
                                  });
                                },
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (v) {
                                  setState(() {});
                                },
                                onChanged: (v) {
                                  setState(() {});
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mediumGrey),
                                    ),
                                    labelText:
                                        TeamCenterLocalizations.of(context)!
                                            .find('Country'),
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
                                      EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: cityController,
                                cursorColor: AppColors.blue,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onTap: () {},
                                onFieldSubmitted: (v) {
                                  setState(() {});
                                },
                                onChanged: (v) {
                                  setState(() {});
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mediumGrey),
                                    ),
                                    labelText:
                                        TeamCenterLocalizations.of(context)!
                                            .find('City'),
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
                                      EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: addressController,
                                cursorColor: AppColors.blue,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (v) {
                                  setState(() {});
                                },
                                onChanged: (v) {
                                  setState(() {});
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mediumGrey),
                                    ),
                                    labelText:
                                        TeamCenterLocalizations.of(context)!
                                            .find('Address'),
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
                                      EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTextSize.textSize16(
                                  TeamCenterLocalizations.of(context)!
                                      .find('appLanguage'),
                                  AppColors.blue,
                                  FontWeight.normal,
                                  "rubikregular",
                                  1),
                              DropdownButton<String>(
                                value: languageDropdownvalue,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                onChanged: (data) {
                                  setState(() {
                                    languageDropdownvalue = data!;
                                  });
                                },
                                items: appLanguageList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal)));
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
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
    CommonMethod.showErrorFlushbar(context, message);

    setState(() {});
  }

  @override
  void onSuccess(data) {
    if (whichApiCall == "getProfile") {
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
    }

    var d = jsonEncode(data['data']);
    print(d);
    var type = jsonDecode(d);
    if (languageDropdownvalue == "English") {
      Locale newLocale = Locale("en");
      MyHomePage.setLocale(context, newLocale);
    } else {
      Locale newLocale = Locale("he");
      MyHomePage.setLocale(context, newLocale);
    }
    SharedPref.saveProfileData(d);
    setState(() {});
  }

  @override
  void onImage(file) {
    _imagePath = file;
    setState(() {});
  }

  @override
  void onClick(id, type) {}

  @override
  void updateBadge(id, String type) {}
}
