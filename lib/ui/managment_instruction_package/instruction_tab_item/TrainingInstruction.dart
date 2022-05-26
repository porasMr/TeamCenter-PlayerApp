import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/ui/managment_instruction_package/instruction_tab_item/TrainingInstructionDetail.dart';
import 'package:team_center/ui/managment_instruction_package/model/InstructionModel.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';

import '../instruction_interface.dart';

class TrainingInstructionScreen extends StatefulWidget {
  List<TrainingInstructions>? trainingInstructions;
  InstructionUpdate? callBack;
  VoidCallback? refershCallBack;

  TrainingInstructionScreen(
      {this.trainingInstructions, this.callBack, this.refershCallBack});
  @override
  _TrainingInstructionScreenState createState() =>
      _TrainingInstructionScreenState();
}

class _TrainingInstructionScreenState extends State<TrainingInstructionScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<void> onRefresh() async {
    widget.callBack!.refershPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Container(
        color: AppColors.whiteColor[500],
        child: InkWell(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.trainingInstructions!.length,
              itemBuilder: (context, index) {
                return listItem(index);
              },
            )),
      ),
    );
  }

  Widget listItem(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: TrainingInstructionDetailsScreen(
                  traningInstructions: widget.trainingInstructions![index],
                ))).then((value) {
          widget.callBack!.refershInstruction(0);
        });
      },
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
                                widget.trainingInstructions![index].title!,
                                AppColors.blackColor[500]!,
                                FontWeight.bold,
                                "rubikregular",
                                1),
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
                                CommonMethod.dateChangeRetrun(widget
                                    .trainingInstructions![index].updatedAt!),
                                AppColors.blackColor[500]!,
                                FontWeight.normal,
                                "rubikregular",
                                1),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.trainingInstructions![index].status == 0
                          ? Container(
                              width: 16,
                              height: 16,
                            )
                          : Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  color: AppColors.defaultAppColor[500]!,
                                  shape: BoxShape.circle),
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
                            widget.trainingInstructions![index].description ==
                                    "null"
                                ? Container()
                                : Html(
                                    data: widget.trainingInstructions![index]
                                        .short_description!,
                                    customTextAlign: (_) =>
                                        CommonMethod.appLanguage() == "English"
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    onLinkTap: (u) {
                                      CommonMethod
                                          .launchInWebViewWithJavaScript(u);
                                    },
                                  ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: AppColors.selectedGrey,
                      ),
                    ],
                  ),
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
}
