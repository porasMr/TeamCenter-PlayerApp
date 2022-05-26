import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/ui/professional_package/model/CategoryModle.dart';
import 'package:team_center/ui/professional_package/model/ProfessionalModle.dart';
import 'package:team_center/utils/shared_preferences.dart';

import '../../apiservice/api_call.dart';
import '../../apiservice/api_interface.dart';
import '../../apiservice/url_string.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppTextSize.dart';
import '../../utils/CommonMethod.dart';
import '../../utils/TeamCenterLocalizations.dart';
import '../../utils/play_video.dart';
import '../managment_instruction_package/InAppWebViewExampleScreen.dart';
import 'ProfessionalDetail.dart';
import 'package:http/http.dart' as http;

class ProfessionalKnowledagePage extends StatefulWidget {
  String? id;
  String? type;
  ProfessionalKnowledagePage({this.id, this.type});
  @override
  State<ProfessionalKnowledagePage> createState() {
    return _ProfessionalKnowledagePageState();
  }
}

class _ProfessionalKnowledagePageState extends State<ProfessionalKnowledagePage>
    implements ApiInterface {
  var categoryId = "";
  var searchMstring = "";
  var model;
  CategoryModle catModel = new CategoryModle();
  String categoryTxt = "";
  @override
  void initState() {
    ApiCall.professionalKnowledge(searchMstring, this, context);
    getCategory();
    hundler();
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Column(children: [
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
                                  .find('professional_knowledge'),
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
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (v) {
                            searchMstring = v;

                            if (v == "") {
                              hundler();
                            }
                            setState(() {});
                            ApiCall.professionalKnowledge(
                                searchMstring, this, context);
                          },
                          onChanged: (v) {
                            searchMstring = v;
                            if (v == "") {
                              hundler();
                            }
                            setState(() {});
                            ApiCall.professionalKnowledge(
                                searchMstring, this, context);
                          },
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "rubikregular",
                              fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                            hintText: TeamCenterLocalizations.of(context)!
                                .find('Search'),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: "rubikregular",
                                fontWeight: FontWeight.normal),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            /* contentPadding:
                                              EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),*/
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 1, color: AppColors.strokeColor),
                model != null
                    ? Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            model.latest!.length == 0
                                ? Container()
                                : Container(
                                    height: 280,
                                    child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.professionalBackColor,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 12, right: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextSize.textSize16(
                                                      TeamCenterLocalizations
                                                              .of(context)!
                                                          .find('Latest'),
                                                      AppColors
                                                          .blackColor[500]!,
                                                      FontWeight.bold,
                                                      "rubikregular",
                                                      1),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      model.latest!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  child:
                                                                      ProfessionalDetailsScreen(
                                                                    professional:
                                                                        model.latest![
                                                                            index],
                                                                  ))).then(
                                                              (value) {
                                                            ApiCall
                                                                .professionalKnowledge(
                                                                    searchMstring,
                                                                    this,
                                                                    context);
                                                            getCategory();
                                                            hundler();
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SizedBox(
                                                              width: 12,
                                                            ),
                                                            Container(
                                                                height: 200,
                                                                width: 140,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.6),
                                                                      blurRadius:
                                                                          2.0, // soften the shadow
                                                                      offset:
                                                                          Offset(
                                                                        0.5, // Move to right 10  horizontally
                                                                        0.5, // Move to bottom 10 Vertically
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        (model.latest![index].videoUrl == "null" && model.latest![index].mainImage == "null") ||
                                                                                (model.latest![index].videoUrl == "" && model.latest![index].mainImage == "")
                                                                            ? Container()
                                                                            : Container(
                                                                                width: 140,
                                                                                height: 120,
                                                                                child: Stack(
                                                                                  children: [
                                                                                    model.latest![index].videoUrl == "null" || model.latest![index].videoUrl == ""
                                                                                        ? CachedNetworkImage(
                                                                                            imageUrl: model.latest![index].mainImage == "null" ? "" : model.latest![index].mainImage!,
                                                                                            imageBuilder: (context, imageProvider) => Container(
                                                                                              width: 140,
                                                                                              height: 120,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                                shape: BoxShape.rectangle,
                                                                                                image: DecorationImage(
                                                                                                  image: imageProvider,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            placeholder: (context, url) => Container(
                                                                                              width: 140,
                                                                                              height: 120,
                                                                                              child: Container(
                                                                                                width: 70,
                                                                                                height: 70,
                                                                                                alignment: Alignment.center,
                                                                                                child: CircularProgressIndicator(
                                                                                                  color: AppColors.primaryColor,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            errorWidget: (context, url, error) => Container(
                                                                                                width: 140,
                                                                                                height: 120,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.black,
                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                                  shape: BoxShape.rectangle,
                                                                                                ),
                                                                                                child: Container(width: 70, height: 70, child: Icon(Icons.error))),
                                                                                          )
                                                                                        : CachedNetworkImage(
                                                                                            imageUrl: model.latest![index].thumbnail_image == "null" ? "" : model.latest![index].thumbnail_image!,
                                                                                            imageBuilder: (context, imageProvider) => Container(
                                                                                              width: 140,
                                                                                              height: 120,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                                shape: BoxShape.rectangle,
                                                                                                image: DecorationImage(
                                                                                                  image: imageProvider,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            placeholder: (context, url) => Container(
                                                                                              width: 140,
                                                                                              height: 120,
                                                                                              child: Container(
                                                                                                width: 70,
                                                                                                height: 70,
                                                                                                alignment: Alignment.center,
                                                                                                child: CircularProgressIndicator(
                                                                                                  color: AppColors.primaryColor,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            errorWidget: (context, url, error) => Container(
                                                                                                width: 140,
                                                                                                height: 120,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.black,
                                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                                                                                  shape: BoxShape.rectangle,
                                                                                                ),
                                                                                                child: Container(width: 70, height: 70, child: Icon(Icons.error))),
                                                                                          ),
                                                                                    model.latest![index].videoUrl == "null" || model.latest![index].videoUrl == ""
                                                                                        ? Container()
                                                                                        : Container(
                                                                                            width: 140,
                                                                                            height: 100,
                                                                                            alignment: Alignment.center,
                                                                                            child: GestureDetector(
                                                                                                onTap: () {
                                                                                                  Navigator.push(
                                                                                                      context,
                                                                                                      PageTransition(
                                                                                                          type: PageTransitionType.fade,
                                                                                                          child: InAppWebViewExampleScreen(
                                                                                                            url: model.latest![index].videoUrl!,
                                                                                                            name: model.latest![index].videoUrl!.split("/").last.split(".").first,
                                                                                                            isProfessionalKnowledge: true,
                                                                                                          ))).then((value) {});
                                                                                                  // Navigator.push(
                                                                                                  //     context,
                                                                                                  //     PageTransition(
                                                                                                  //         type: PageTransitionType.fade,
                                                                                                  //         child: PlayVideoScreen(
                                                                                                  //           url: model.latest![index].videoUrl!,
                                                                                                  //         ))).then((value) {
                                                                                                  //   setState(() {});
                                                                                                  // });
                                                                                                },
                                                                                                child: Image.asset("assets/images/play_icon.png", width: 50, height: 50))),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                        model.latest![index].title == null ||
                                                                                model.latest![index].title == ""
                                                                            ? Container()
                                                                            : Padding(padding: (model.latest![index].videoUrl == "null" && model.latest![index].mainImage == "null") || (model.latest![index].videoUrl == "" && model.latest![index].mainImage == "") ? EdgeInsets.only(top: 20, left: 5, right: 5) : EdgeInsets.all(5), child: AppTextSize.textSize14(model.latest![index].title!, AppColors.blackColor[500]!, FontWeight.w500, "rubikregular", 1)),
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            margin: EdgeInsets.only(
                                                                                bottom: 4,
                                                                                left: 4,
                                                                                right: 4),
                                                                            padding:
                                                                                EdgeInsets.all(5),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                                                            ),
                                                                            child: AppTextSize.textSizeShortDesc12(
                                                                                model.latest![index].shortDescription!,
                                                                                AppColors.textColor,
                                                                                FontWeight.normal,
                                                                                "rubikregular",
                                                                                2),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    model.latest![index].status ==
                                                                            0
                                                                        ? Container(
                                                                            width:
                                                                                14,
                                                                            height:
                                                                                14,
                                                                          )
                                                                        : Container(
                                                                            margin: EdgeInsets.only(
                                                                                top: 5,
                                                                                left: 5,
                                                                                right: 5),
                                                                            width:
                                                                                14,
                                                                            height:
                                                                                14,
                                                                            decoration:
                                                                                BoxDecoration(color: AppColors.defaultAppColor[500]!, shape: BoxShape.circle),
                                                                          ),
                                                                  ],
                                                                )),
                                                            SizedBox(
                                                              width: 10,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Container(
                                      height: 1, color: AppColors.strokeColor),
                                  Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(10),
                                      itemCount: model.data!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child:
                                                            ProfessionalDetailsScreen(
                                                          professional: model
                                                              .data![index],
                                                        ))).then((value) {
                                                  ApiCall.professionalKnowledge(
                                                      searchMstring,
                                                      this,
                                                      context);
                                                  hundler();
                                                });
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.6),
                                                        blurRadius:
                                                            10.0, // soften the shadow
                                                        offset: Offset(
                                                          0.5, // Move to right 10  horizontally
                                                          0.5, // Move to bottom 10 Vertically
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      (model.data![index].videoUrl ==
                                                                      "null" &&
                                                                  model
                                                                          .data![
                                                                              index]
                                                                          .mainImage ==
                                                                      "null") ||
                                                              (model
                                                                          .data![
                                                                              index]
                                                                          .videoUrl ==
                                                                      "" &&
                                                                  model.data![index]
                                                                          .mainImage ==
                                                                      "")
                                                          ? Container(
                                                              width: 100,
                                                              height: 100,
                                                            )
                                                          : Container(
                                                              width: 100,
                                                              height: 100,
                                                              child: Stack(
                                                                children: [
                                                                  model.data![index].videoUrl ==
                                                                              "null" ||
                                                                          model.data![index].videoUrl ==
                                                                              ""
                                                                      ? CachedNetworkImage(
                                                                          imageUrl: model.data![index].mainImage == "null"
                                                                              ? ""
                                                                              : model.data![index].mainImage!,
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                100,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              shape: BoxShape.rectangle,
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                100,
                                                                            child:
                                                                                Container(
                                                                              width: 50,
                                                                              height: 50,
                                                                              alignment: Alignment.center,
                                                                              child: CircularProgressIndicator(
                                                                                color: AppColors.primaryColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          errorWidget: (context, url, error) => Container(
                                                                              width: 100,
                                                                              height: 100,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.black,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                                shape: BoxShape.rectangle,
                                                                              ),
                                                                              child: Container(width: 50, height: 50, child: Icon(Icons.error))),
                                                                        )
                                                                      : CachedNetworkImage(
                                                                          imageUrl: model.data![index].thumbnail_image == "null"
                                                                              ? ""
                                                                              : model.data![index].thumbnail_image!,
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                100,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              shape: BoxShape.rectangle,
                                                                              image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          placeholder: (context, url) =>
                                                                              Container(
                                                                            width:
                                                                                100,
                                                                            height:
                                                                                100,
                                                                            child:
                                                                                Container(
                                                                              width: 50,
                                                                              height: 50,
                                                                              alignment: Alignment.center,
                                                                              child: CircularProgressIndicator(
                                                                                color: AppColors.primaryColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          errorWidget: (context, url, error) => Container(
                                                                              width: 100,
                                                                              height: 100,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.black,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                                shape: BoxShape.rectangle,
                                                                              ),
                                                                              child: Container(width: 50, height: 50, child: Icon(Icons.error))),
                                                                        ),
                                                                  model.data![index].videoUrl == "null" ||
                                                                          model.data![index].videoUrl ==
                                                                              ""
                                                                      ? Container()
                                                                      : Container(
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              100,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child: GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                    context,
                                                                                    PageTransition(
                                                                                        type: PageTransitionType.fade,
                                                                                        child: InAppWebViewExampleScreen(
                                                                                          url: model.data![index].videoUrl!,
                                                                                          name: model.data![index].videoUrl!.split("/").last.split(".").first,
                                                                                          isProfessionalKnowledge: true,
                                                                                        ))).then((value) {});
                                                                                // Navigator.push(
                                                                                //     context,
                                                                                //     PageTransition(
                                                                                //         type: PageTransitionType.fade,
                                                                                //         child: PlayVideoScreen(
                                                                                //           url: model.data![index].videoUrl!,
                                                                                //         ))).then((value) {
                                                                                //   setState(() {});
                                                                                // });
                                                                              },
                                                                              child: Image.asset("assets/images/play_icon.png", width: 40, height: 40)))
                                                                ],
                                                              ),
                                                            ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  model.data![index].title ==
                                                                              null ||
                                                                          model.data![index].title ==
                                                                              ""
                                                                      ? Container()
                                                                      : Padding(
                                                                          padding: EdgeInsets.all(
                                                                              5),
                                                                          child: AppTextSize.textSize14(
                                                                              model.data![index].title!,
                                                                              AppColors.blackColor[500]!,
                                                                              FontWeight.w500,
                                                                              "rubikregular",
                                                                              1)),
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child: AppTextSize.textSizeShortDesc12(
                                                                        model
                                                                            .data![
                                                                                index]
                                                                            .shortDescription!,
                                                                        AppColors
                                                                            .textColor,
                                                                        FontWeight
                                                                            .normal,
                                                                        "rubikregular",
                                                                        3),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            model.data![index]
                                                                        .status ==
                                                                    0
                                                                ? Container(
                                                                    width: 14,
                                                                    height: 14,
                                                                  )
                                                                : Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: 5,
                                                                        left: 5,
                                                                        right:
                                                                            5),
                                                                    width: 14,
                                                                    height: 14,
                                                                    decoration: BoxDecoration(
                                                                        color: AppColors.defaultAppColor[
                                                                            500]!,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                  ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ))
                    : Container()
              ]),
            )),
      ),
    );
  }

  @override
  void onFailure(message) {
    if (searchMstring == "") {
      Navigator.pop(context);
    }
    CommonMethod.showErrorFlushbar(context, message);
  }

  @override
  void onSuccess(data) {
    if (searchMstring == "") {
      Navigator.pop(context);
    }
    model = ProfessionalModle.fromJson(data);
    if (widget.id != null) {
      for (int i = 0; i < model.data!.length; i++) {
        if (widget.id == model.latest![i].id.toString()) {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: ProfessionalDetailsScreen(
                    professional: model.data![i],
                  ))).then((value) {
            setState(() {});
          });
          break;
        }
      }
    }
    setState(() {});
  }

  Future<http.Response?> getCategory() async {
    try {
      final response = await http
          .get(Uri.parse(UrlConstant.professionalKnowledgeCategory), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          catModel = CategoryModle.fromJson(data);
          setState(() {});
        } else {}
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.

      }
    } catch (e) {}
  }
}
