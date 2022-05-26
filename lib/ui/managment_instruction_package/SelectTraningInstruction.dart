import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/ui/managment_instruction_package/instruction_tab_item/TrainingInstructionDetail.dart';
import 'package:team_center/ui/managment_instruction_package/model/InstructionModel.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';

import '../../apiservice/api_call.dart';

class SelectTrainingInstructionScreen extends StatefulWidget {
  @override
  _SelectTrainingInstructionScreenState createState() =>
      _SelectTrainingInstructionScreenState();
}

class _SelectTrainingInstructionScreenState
    extends State<SelectTrainingInstructionScreen>
    with TickerProviderStateMixin
    implements ApiInterface {
  List<TrainingInstructions>? trainingInstructions = <TrainingInstructions>[];
  InstructionModel model = new InstructionModel();

  @override
  void initState() {
    super.initState();
    hundler();
    ApiCall.instruction(this, context);
  }

  List<String> imagesList(TrainingInstructions trainingInstruction) {
    List<String> filePath;
    if (trainingInstruction.imageFile!.length == 0) {
      trainingInstruction.imageFile =
          CommonMethod.stataData(trainingInstruction.images!);
      print("image arr ${trainingInstruction.imageFile!.length}");
      filePath = trainingInstruction.imageFile!;
    } else {
      filePath = trainingInstruction.imageFile!;
    }

    return filePath;
  }

  List<bool> boolList(TrainingInstructions trainingInstruction) {
    List<bool> selectArr = [];
    List<String> filePath = [];

    if (trainingInstruction.selectedFile!.length == 0) {
      trainingInstruction.imageFile =
          CommonMethod.stataData(trainingInstruction.images!);
      filePath = trainingInstruction.imageFile!;
      for (int i = 0; i < filePath.length; i++) {
        selectArr.add(false);
      }
      trainingInstruction.selectedFile = selectArr;
    } else {}

    return trainingInstruction.selectedFile!;
  }

  List<String> fileList(TrainingInstructions trainingInstruction) {
    print(trainingInstruction.file_description!);
    List<String> fileDescription = [];
    if (trainingInstruction.fileFile!.length == 0) {
      trainingInstruction.fileFile = CommonMethod.fileDesciptionData(
          trainingInstruction.file_description!);
      fileDescription = trainingInstruction.fileFile!;
      print("filePath arr ${fileDescription.length}");
    } else {
      fileDescription = trainingInstruction.fileFile!;
      print("filePath arr ${fileDescription.length}");
    }

    print(fileDescription.length);
    return fileDescription;
  }

  hundler() async {
    Timer(Duration(microseconds: 100), () {
      CommonMethod.dialogLoader(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor[500],
        child: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(top:16.0),
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
                                  .find('practice_instruction'),
                              AppColors.blue,
                              FontWeight.normal,
                              "rubikregular",
                              1),
                        ),
                      ]),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: InkWell(
                        onTap: () {
                          doneClick();
                        },
                        child: AppTextSize.textSize16(
                            TeamCenterLocalizations.of(context)!.find('Done'),
                            AppColors.blue,
                            FontWeight.normal,
                            "rubikregular",
                            1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(height: 1, color: AppColors.strokeColor),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: trainingInstructions!.length,
                    itemBuilder: (context, index) {
                      return listItem(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        // color: widget.trainingInstructions![index].status == 0
        //     ? Colors.white
        //     : AppColors.selectedGrey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Image.asset(
                          AppImages.note,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextSize.textSize16(
                                trainingInstructions![index].title!,
                                AppColors.blackColor[500]!,
                                FontWeight.bold,
                                "rubikregular",
                                2),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextSize.textSize14(
                                CommonMethod.dateChangeRetrun(
                                    trainingInstructions![index].updatedAt!),
                                AppColors.blackColor[500]!,
                                FontWeight.normal,
                                "rubikregular",
                                2),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  selectedView(index),
                ],
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: AppColors.strokeColor,
            )
          ],
        ),
      ),
    );
  }

  selectedView(int index) {
    imagesList(trainingInstructions![index]);
    boolList(trainingInstructions![index]);
    fileList(trainingInstructions![index]);
    return Wrap(
      direction: Axis.horizontal,
      children: [
        for (int i = 0; i < trainingInstructions![index].imageFile!.length; i++)
          InkWell(
            onTap: () {
              if (Platform.isIOS) {
                // Navigator.push(
                //     context,
                //     PageTransition(
                //         type: PageTransitionType.fade,
                //         child: InAppWebViewExampleScreen(
                //           url: imagesList(
                //               gameInstructions![index])[i],
                //           name: fileList(gameInstructions![
                //                       index])[i] ==
                //                   "null"
                //               ? imagesList(
                //                       gameInstructions![index])[i]
                //                   .split("/")
                //                   .last
                //                   .split(".")
                //                   .first
                //               : fileList(
                //                   gameInstructions![index])[i],
                //           isProfessionalKnowledge: false,
                //         )));
              } else {
                if (trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("mp4") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("jpg") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("png") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("jpeg") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("JPG") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("JPEG") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("3gp") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("avi") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("wmv") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("MTS") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("M2TS") ||
                    trainingInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("TS")) {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         type: PageTransitionType.fade,
                  //         child: InAppWebViewExampleScreen(
                  //           url: imagesList(
                  //               gameInstructions![index])[i],
                  //           name: fileList(gameInstructions![
                  //                       index])[i] ==
                  //                   "null"
                  //               ? imagesList(gameInstructions![
                  //                       index])[i]
                  //                   .split("/")
                  //                   .last
                  //                   .split(".")
                  //                   .first
                  //               : fileList(
                  //                   gameInstructions![index])[i],
                  //           isProfessionalKnowledge: false,
                  //         )));
                } else {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         type: PageTransitionType.fade,
                  //         child: InAppBrowserExampleScreen(
                  //           url: imagesList(
                  //               gameInstructions![index])[i],
                  //           name: fileList(gameInstructions![
                  //                       index])[i] ==
                  //                   "null"
                  //               ? imagesList(gameInstructions![
                  //                       index])[i]
                  //                   .split("/")
                  //                   .last
                  //                   .split(".")
                  //                   .first
                  //               : fileList(
                  //                   gameInstructions![index])[i],
                  //         )));
                }
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (trainingInstructions![index]
                                        .selectedFile![i] ==
                                    false) {
                                  trainingInstructions![index]
                                      .selectedFile![i] = true;
                                  setState(() {});
                                } else {
                                  trainingInstructions![index]
                                      .selectedFile![i] = false;
                                  setState(() {});
                                }
                              },
                              child: trainingInstructions![index]
                                          .selectedFile![i] ==
                                      false
                                  ? Image.asset(AppImages.unselected)
                                  : Image.asset(AppImages.selected),
                            ),
                            SizedBox(width: 10),
                            trainingInstructions![index].fileFile![i] == "null"
                                ? Flexible(
                                    flex: 1,
                                    child: AppTextSize.textSize16(
                                        trainingInstructions![index]
                                            .imageFile![i]
                                            .split("/")
                                            .last,
                                        AppColors.blue,
                                        FontWeight.normal,
                                        "rubikregular",
                                        2),
                                  )
                                : Flexible(
                                    flex: 1,
                                    child: AppTextSize.textSize16(
                                        trainingInstructions![index]
                                            .fileFile![i],
                                        AppColors.blue,
                                        FontWeight.normal,
                                        "rubikregular",
                                        2),
                                  ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        AppImages.arrowDown,
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          )
      ],
    );
  }

  doneClick() {
    List<String> path = [];
    for (int i = 0; i < trainingInstructions!.length; i++) {
      for (int j = 0; j < trainingInstructions![i].selectedFile!.length; j++) {
        if (trainingInstructions![i].selectedFile![j] == true) {
          if (trainingInstructions![i].fileFile![j] == "null") {
            path.add(trainingInstructions![i].imageFile![j]);
          } else {
            path.add(trainingInstructions![i].imageFile![j] +
                "+" +
                trainingInstructions![i].fileFile![j]);
          }
        }
      }
    }
    Navigator.pop(context, path);
  }

  @override
  void onFailure(message) {
    Navigator.pop(context);
    CommonMethod.showErrorFlushbar(context, message);
    setState(() {});
  }

  @override
  void onSuccess(data) {
    model = InstructionModel.fromJson(data);
    trainingInstructions = model.data!.trainingInstructions;

    Navigator.pop(context);

    setState(() {});
  }
}
