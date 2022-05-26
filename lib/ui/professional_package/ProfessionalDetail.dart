import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/FullScreenImage.dart';

import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/globals.dart' as globals;

import '../../utils/play_video.dart';
import '../managment_instruction_package/InAppWebViewExampleScreen.dart';
import '../managment_instruction_package/chrome_safari_browser_example.screen.dart';

class ProfessionalDetailsScreen extends StatefulWidget {
  var professional;
  ProfessionalDetailsScreen({this.professional});
  @override
  _ProfessionalDetailsScreenScreenState createState() =>
      _ProfessionalDetailsScreenScreenState();
}

class _ProfessionalDetailsScreenScreenState
    extends State<ProfessionalDetailsScreen>
    with TickerProviderStateMixin
    implements ApiInterface {
  List<String> filePath = new List.empty(growable: true);
  List<String> fileDescription = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    imagesList();
    fileList();
    print(widget.professional!.id);
    ApiCall.readInstruction(widget.professional!.id.toString(),
        "professional_knowledge", this, context);
  }

  imagesList() {
    filePath = CommonMethod.stataData(widget.professional!.files!);
    print(filePath.length);
    setState(() {});
  }

  fileList() {
    fileDescription =
        CommonMethod.fileDesciptionData(widget.professional!.fileDescription!);
    print(fileDescription.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor[500],
      body: SafeArea(
          top: false,
          bottom: false,
          child: InkWell(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

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
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

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
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.pop(context, true);
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
                  (widget.professional!.videoUrl == "null" &&
                              widget.professional!.mainImage == "null") ||
                          (widget.professional!.videoUrl == "" &&
                              widget.professional!.mainImage == "")
                      ? Container()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Stack(
                            children: [
                              widget.professional!.videoUrl == "null" ||
                                      widget.professional!.videoUrl == ""
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          widget.professional!.mainImage! ==
                                                  "null"
                                              ? ""
                                              : widget.professional!.mainImage!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                              color: Colors.black,
                                              child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  child: Icon(Icons.error))),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: widget.professional!
                                                  .thumbnail_image! ==
                                              "null"
                                          ? ""
                                          : widget
                                              .professional!.thumbnail_image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                              color: Colors.black,
                                              child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  child: Icon(Icons.error))),
                                    ),
                              widget.professional!.videoUrl == "null" ||
                                      widget.professional!.videoUrl == ""
                                  ? Container()
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child:
                                                        InAppWebViewExampleScreen(
                                                      url: widget.professional!
                                                          .videoUrl!,
                                                      name: widget.professional!
                                                          .videoUrl!
                                                          .split("/")
                                                          .last
                                                          .split(".")
                                                          .first,
                                                      isProfessionalKnowledge:
                                                          true,
                                                    )));
                                            // Navigator.push(
                                            //     context,
                                            //     PageTransition(
                                            //         type:
                                            //             PageTransitionType.fade,
                                            //         child: PlayVideoScreen(
                                            //           url: widget.professional!
                                            //               .videoUrl!,
                                            //         ))).then((value) {
                                            //   setState(() {});
                                            // });
                                          },
                                          child: Image.asset(
                                              "assets/images/play_icon.png",
                                              width: 50,
                                              height: 50)))
                            ],
                          ),
                        ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: ListView(
                          children: [
                            AppTextSize.textSize16(
                                widget.professional!.title!,
                                AppColors.blackColor[500]!,
                                FontWeight.bold,
                                "rubikregular",
                                1),
                            SizedBox(
                              height: 5,
                            ),
                            AppTextSize.textSize14(
                                CommonMethod.dateChangeRetrun(
                                    widget.professional!.updatedAt!),
                                AppColors.blackColor[500]!,
                                FontWeight.normal,
                                "rubikregular",
                                1),
                            SizedBox(
                              height: 16,
                            ),
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                for (int index = 0;
                                    index < filePath.length;
                                    index++)
                                  InkWell(
                                    onTap: () {
                                      // CommonMethod
                                      //     .launchInWebViewWithJavaScript(
                                      //         filePath[index]);
                                      if (Platform.isIOS) {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child:
                                                    InAppWebViewExampleScreen(
                                                  url: filePath[index],
                                                  name: fileDescription[
                                                              index] ==
                                                          "null"
                                                      ? filePath[index]
                                                          .split("/")
                                                          .last
                                                          .split(".")
                                                          .first
                                                      : fileDescription[index],
                                                  isProfessionalKnowledge: true,
                                                )));
                                      } else {
                                        if (filePath[index]
                                                .split("/")
                                                .last
                                                .contains("mp4") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("jpg") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("png") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("jpeg") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("JPG") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("JPEG") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("3gp") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("avi") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("wmv") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("MTS") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("M2TS") ||
                                            filePath[index]
                                                .split("/")
                                                .last
                                                .contains("TS")) {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child:
                                                      InAppWebViewExampleScreen(
                                                    url: filePath[index],
                                                    name: fileDescription[
                                                                index] ==
                                                            "null"
                                                        ? filePath[index]
                                                            .split("/")
                                                            .last
                                                            .split(".")
                                                            .first
                                                        : fileDescription[
                                                            index],
                                                    isProfessionalKnowledge:
                                                        true,
                                                  )));
                                        } else {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child:
                                                      InAppBrowserExampleScreen(
                                                    url: filePath[index],
                                                    name: fileDescription[
                                                                index] ==
                                                            "null"
                                                        ? filePath[index]
                                                            .split("/")
                                                            .last
                                                            .split(".")
                                                            .first
                                                        : fileDescription[
                                                            index],
                                                  )));
                                        }
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                AppImages.arrowDown,
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              fileDescription[index] == "null"
                                                  ? AppTextSize.textSize16(
                                                      filePath[index]
                                                          .split("/")
                                                          .last,
                                                      AppColors.blue,
                                                      FontWeight.normal,
                                                      "rubikregular",
                                                      1)
                                                  : AppTextSize.textSize16(
                                                      fileDescription[index],
                                                      AppColors.blue,
                                                      FontWeight.normal,
                                                      "rubikregular",
                                                      1)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                            height: 1,
                                            color: AppColors.strokeColor),
                                        SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            widget.professional!.description == "null"
                                ? Container()
                                : Html(
                                    data: widget.professional!.description!,
                                    customTextAlign: (_) =>
                                        CommonMethod.appLanguage() == "English"
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    onLinkTap: (u) {
                                      CommonMethod
                                          .launchInWebViewWithJavaScript(u);
                                    },
                                    onImageTap: (s) {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: FullScreenImage(url: s)));
                                    },
                                  ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          )),
    );
  }

  @override
  void onFailure(message) {
    // TODO: implement onFailure
  }

  @override
  void onSuccess(data) {
    globals.totalCount = data['totalCount'];
    globals.gameCount = data['gameCont'];
    globals.trainingCount = data['trainingCount'];
    globals.professinalCount = data['professionalknowledge'];
  }
}
