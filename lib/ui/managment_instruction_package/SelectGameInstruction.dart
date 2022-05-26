import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/ui/managment_instruction_package/instruction_tab_item/GameInstuctionDetails.dart';
import 'package:team_center/ui/managment_instruction_package/model/InstructionModel.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';

import '../../apiservice/api_call.dart';
import 'InAppWebViewExampleScreen.dart';
import 'chrome_safari_browser_example.screen.dart';

class SelectGameInstructionScreen extends StatefulWidget {
  @override
  _SelectGameInstructionScreenState createState() =>
      _SelectGameInstructionScreenState();
}

class _SelectGameInstructionScreenState
    extends State<SelectGameInstructionScreen>
    with TickerProviderStateMixin
    implements ApiInterface {
  List<GameInstructions>? gameInstructions = <GameInstructions>[];
  InstructionModel model = new InstructionModel();
  List<bool> listSelected = [];

  @override
  void initState() {
    super.initState();
    hundler();
    ApiCall.instruction(this, context);
  }

  List<String> imagesList(GameInstructions gameInstruction) {
    List<String> filePath;
    if (gameInstruction.imageFile!.length == 0) {
      gameInstruction.imageFile =
          CommonMethod.stataData(gameInstruction.images!);
      print("image arr ${gameInstruction.imageFile!.length}");
      filePath = gameInstruction.imageFile!;
    } else {
      filePath = gameInstruction.imageFile!;
    }

    return filePath;
  }

  List<bool> boolList(GameInstructions gameInstruction) {
    List<bool> selectArr = [];
    List<String> filePath = [];

    if (gameInstruction.selectedFile!.length == 0) {
      gameInstruction.imageFile =
          CommonMethod.stataData(gameInstruction.images!);
      filePath = gameInstruction.imageFile!;
      for (int i = 0; i < filePath.length; i++) {
        selectArr.add(false);
      }
      gameInstruction.selectedFile = selectArr;
    } else {}

    return gameInstruction.selectedFile!;
  }

  List<String> fileList(GameInstructions gameInstruction) {
    print(gameInstruction.file_description!);
    List<String> fileDescription = [];
    if (gameInstruction.fileFile!.length == 0) {
      gameInstruction.fileFile =
          CommonMethod.fileDesciptionData(gameInstruction.file_description!);
      fileDescription = gameInstruction.fileFile!;
      print("filePath arr ${fileDescription.length}");
    } else {
      fileDescription = gameInstruction.fileFile!;
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
            padding: EdgeInsets.only(top:16),
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
                                  .find('games_instruction'),
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
                    itemCount: gameInstructions!.length,
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
      onTap: () {
        // Navigator.push(
        //     context,
        //     PageTransition(
        //         type: PageTransitionType.fade,
        //         child: GameInstructionDetailsScreen(
        //           gameInstructions: widget.gameInstructions![index],
        //         ))).then((value) {
        //   widget.callBack!.refershInstruction(1);
        // });
      },
      child: Container(
        // color: widget.gameInstructions![index].status == 0
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextSize.textSize16(
                                gameInstructions![index].title!,
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
                                    gameInstructions![index].updatedAt!),
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
    imagesList(gameInstructions![index]);
    boolList(gameInstructions![index]);
    fileList(gameInstructions![index]);
    return Wrap(
      direction: Axis.horizontal,
      children: [
        for (int i = 0; i < gameInstructions![index].imageFile!.length; i++)
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
                if (gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("mp4") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("jpg") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("png") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("jpeg") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("JPG") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("JPEG") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("3gp") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("avi") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("wmv") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("MTS") ||
                    gameInstructions![index]
                        .imageFile![i]
                        .split("/")
                        .last
                        .contains("M2TS") ||
                    gameInstructions![index]
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
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (gameInstructions![index].selectedFile![i] ==
                                    false) {
                                  gameInstructions![index].selectedFile![i] =
                                      true;
                                  setState(() {});
                                } else {
                                  gameInstructions![index].selectedFile![i] =
                                      false;
                                  setState(() {});
                                }
                              },
                              child:
                                  gameInstructions![index].selectedFile![i] ==
                                          false
                                      ? Image.asset(AppImages.unselected)
                                      : Image.asset(AppImages.selected),
                            ),
                            SizedBox(width: 10),
                            gameInstructions![index].fileFile![i] == "null"
                                ? Expanded(
                                    flex: 1,
                                    child: AppTextSize.textSize16(
                                        gameInstructions![index]
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
                                        gameInstructions![index].fileFile![i],
                                        AppColors.blue,
                                        FontWeight.normal,
                                        "rubikregular",
                                        2),
                                  ),
                          ],
                        ),
                      ),
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
    for (int i = 0; i < gameInstructions!.length; i++) {
      for (int j = 0; j < gameInstructions![i].selectedFile!.length; j++) {
        if (gameInstructions![i].selectedFile![j] == true) {
          if (gameInstructions![i].fileFile![j] == "null") {
            path.add(gameInstructions![i].imageFile![j]);
          } else {
            path.add(gameInstructions![i].imageFile![j] +
                "+" +
                gameInstructions![i].fileFile![j]);
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
    gameInstructions = model.data!.gameInstructions;

    Navigator.pop(context);

    setState(() {});
  }
}
