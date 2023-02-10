import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/ui/tranning_package/interfaces/TraningCallBack.dart';
import 'package:team_center/ui/tranning_package/model/TrainingDetailModel.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/strings.dart';

class PlanScreen extends StatefulWidget {
  var trainingId;
  var date;
  var fromTime;

  var untillTime;

  PlanScreen({this.trainingId, this.date, this.untillTime, this.fromTime});
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> implements ApiInterface {
  TrainingDetailModel? details = TrainingDetailModel();
  bool isLoader = true;

  @override
  void initState() {
    super.initState();
    hundler();
    ApiCall.getTrainingDetail(widget.trainingId!, this, context);
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
      body: Container(
        color: AppColors.whiteColor[500],
        child: Padding(
          padding: EdgeInsets.only(top: 16),
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
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios,
                            size: 24, color: AppColors.blue),
                      ),
                      InkWell(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: AppTextSize.textSize16(
                            CommonMethod.dateStatRetrun(widget.date!) +
                                " ${widget.fromTime}-${widget.untillTime}",
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
              Container(
                height: 1,
                decoration:
                    BoxDecoration(color: AppColors.strokeColor, boxShadow: [
                  BoxShadow(
                    color: AppColors.mediumGrey,
                    blurRadius: 2.0, // soften the shadow
                    offset: Offset(
                      0.5, // Move to right 10  horizontally
                      0.5, // Move to bottom 10 Vertically
                    ),
                  )
                ]),
              ),
              Expanded(
                child: isLoader
                    ? Container()
                    : ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 24, right: 24),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.strokeColor),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColors.tabGreyColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppTextSize.textSize14(
                                          CommonMethod.dateStatRetrun(
                                              details!.data![0].date!),
                                          Colors.black,
                                          FontWeight.bold,
                                          "rubikregular",
                                          1),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      AppTextSize.textSize14(
                                          "${details!.data![0].fromTime} - ${details!.data![0].untillTime}",
                                          Colors.black,
                                          FontWeight.bold,
                                          "rubikregular",
                                          1),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Color(int.parse(
                                                "0xFFF${details!.data![0].field!.color!.replaceAll("#", "")}"))),
                                        child: AppTextSize.textSize14(
                                            details!.data![0].field!.name!,
                                            AppColors.whiteColor[500]!,
                                            FontWeight.normal,
                                            "rubikregular",
                                            1),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          details!.data![0].club_comment == "null" ||
                                  details!.data![0].club_comment == ""
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 24, right: 24),
                                      child: AppTextSize.textSize16(
                                          TeamCenterLocalizations.of(context)!
                                              .find('club_comments'),
                                          Colors.black,
                                          FontWeight.bold,
                                          "rubikregular",
                                          1),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 24, right: 24),
                                      child: Html(
                                        data: details!.data![0].club_comment,
                                        customTextAlign: (_) =>
                                            CommonMethod.appLanguage() ==
                                                    "English"
                                                ? TextAlign.left
                                                : TextAlign.right,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                          Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: details!.data![0].plans!.length,
                                itemBuilder: ((context, items) {
                                  return InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 16, bottom: 16),
                                              child: Row(
                                                children: [
                                                  Image.asset(AppImages.drawer,
                                                      width: 20, height: 20),
                                                  SizedBox(width: 10),
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
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AppTextSize.textSize14(
                                                                    details!
                                                                        .data![
                                                                            0]
                                                                        .plans![
                                                                            items]
                                                                        .name!,
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .bold,
                                                                    "rubikregular",
                                                                    1),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                AppTextSize.textSize12(
                                                                    details!
                                                                        .data![
                                                                            0]
                                                                        .plans![
                                                                            items]
                                                                        .staffMember!
                                                                        .positionId!,
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .normal,
                                                                    "rubikregular",
                                                                    1),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                AppTextSize.textSize14(
                                                                    details!.data![0].plans![items].description ==
                                                                            "null"
                                                                        ? ""
                                                                        : details!
                                                                            .data![
                                                                                0]
                                                                            .plans![
                                                                                items]
                                                                            .description!,
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .normal,
                                                                    "rubikregular",
                                                                    2),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AppTextSize.textSize12(
                                                                    CommonMethod.appLanguage() ==
                                                                            "English"
                                                                        ? details!
                                                                            .data![
                                                                                0]
                                                                            .plans![
                                                                                items]
                                                                            .level!
                                                                            .engName!
                                                                        : details!
                                                                            .data![
                                                                                0]
                                                                            .plans![
                                                                                items]
                                                                            .level!
                                                                            .hebName!,
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .normal,
                                                                    "rubikregular",
                                                                    1),
                                                                AppTextSize.textSize12(
                                                                    "${details!.data![0].plans![items].time!.time} " +
                                                                        TeamCenterLocalizations.of(context)!.find(
                                                                            'Min'),
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .normal,
                                                                    "rubikregular",
                                                                    1),
                                                                details!.data![0].plans![items]
                                                                            .image ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        height:
                                                                            50.0,
                                                                        child: ListView
                                                                            .builder(
                                                                          reverse:
                                                                              true,
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          itemCount: details!
                                                                              .data![0]
                                                                              .plans![items]
                                                                              .image!
                                                                              .split(",")
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return Container(
                                                                              width: 50.0,
                                                                              height: 50.0,
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(width: 1.0, color: Colors.grey),
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                              ),
                                                                              padding: EdgeInsets.all(1.0),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: details!.data![0].plans![items].image!.split(",")[index],
                                                                                imageBuilder: (context, imageProvider) => Container(
                                                                                  width: 50,
                                                                                  height: 50,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.rectangle,
                                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                                    image: DecorationImage(
                                                                                      image: imageProvider,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                placeholder: (context, url) => Container(
                                                                                  width: 50,
                                                                                  height: 50,
                                                                                  alignment: Alignment.center,
                                                                                  child: CircularProgressIndicator(
                                                                                    color: AppColors.primaryColor,
                                                                                  ),
                                                                                ),
                                                                                errorWidget: (context, url, error) => Container(width: 50, height: 50, child: Icon(Icons.perm_identity)),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Image.asset(
                                                      CommonMethod.appLanguage() ==
                                                              "English"
                                                          ? AppImages.rightArrow
                                                          : AppImages.forward,
                                                      width: 20,
                                                      height: 20),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: AppColors.strokeColor,
                                          )
                                        ],
                                      ));
                                }),
                              ))
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sorting() {
    setState(() {
      details!.data![0].plans!.sort();
    });
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
    details = new TrainingDetailModel.fromJson(data);

    setState(() {
      isLoader = false;
    });
  }

  differnceMethod(String fromT, String untilT) {
    var d = DateFormat("HH:mm")
        .parse(untilT)
        .difference(DateFormat("HH:mm").parse(fromT));
    return d.toString().split(":")[0] == "0"
        ? d.toString().split(":")[1]
        : d.toString().split(":")[0] + ":" + d.toString().split(":")[1];
  }
}
