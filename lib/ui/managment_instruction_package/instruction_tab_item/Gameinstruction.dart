import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/ui/managment_instruction_package/instruction_tab_item/GameInstuctionDetails.dart';
import 'package:team_center/ui/managment_instruction_package/model/InstructionModel.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';

import '../instruction_interface.dart';

class GameInstructionScreen extends StatefulWidget {
  List<GameInstructions>? gameInstructions;
  InstructionUpdate? callBack;
  VoidCallback? refershCallBack;
  GameInstructionScreen(
      {this.gameInstructions, this.callBack, this.refershCallBack});
  @override
  _GameInstructionScreenState createState() => _GameInstructionScreenState();
}

class _GameInstructionScreenState extends State<GameInstructionScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<void> onRefresh() async {
    widget.callBack!.refershPage(1);
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
              itemCount: widget.gameInstructions!.length,
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
                child: GameInstructionDetailsScreen(
                  gameInstructions: widget.gameInstructions![index],
                ))).then((value) {
          widget.callBack!.refershInstruction(1);
        });
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
                                widget.gameInstructions![index].title!,
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
                                CommonMethod.dateChangeRetrun(
                                    widget.gameInstructions![index].updatedAt!),
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
                      widget.gameInstructions![index].status == 0
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widget.gameInstructions![index].description ==
                                    "null"
                                ? Container()
                                : Html(
                                    data: widget.gameInstructions![index]
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
