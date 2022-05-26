import 'dart:async';
import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:http/http.dart' as http;

import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/apiservice/key_string.dart';
import 'package:team_center/apiservice/url_string.dart';

import 'package:team_center/ui/managment_instruction_package/instruction_tab_item/Gameinstruction.dart';
import 'package:team_center/ui/managment_instruction_package/instruction_tab_item/TrainingInstruction.dart';

import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/shared_preferences.dart';

import 'instruction_interface.dart';
import 'instruction_tab_item/GameInstuctionDetails.dart';
import 'instruction_tab_item/TrainingInstructionDetail.dart';
import 'model/InstructionModel.dart';
import 'package:team_center/utils/globals.dart' as globals;

class ManagmentInstructionScreen extends StatefulWidget {
  @override
  _ManagmentInstructionScreenState createState() =>
      _ManagmentInstructionScreenState();
}

class _ManagmentInstructionScreenState extends State<ManagmentInstructionScreen>
    with TickerProviderStateMixin
    implements ApiInterface, InstructionUpdate {
  List<Tab> _tabs = List<Tab>.empty(growable: true);
  late TabController _tabController;
  bool isLoader = true;
  InstructionModel model = new InstructionModel();
  int k = 0;
  @override
  void initState() {
    super.initState();
    _tabs = getTabs();
    _tabController = getTabController();
    // getselectedData();
    hundler();
    ApiCall.instruction(this, context);
    // totalInstruction(context);
  }

  hundler() async {
    Timer(Duration(microseconds: 100), () {
      CommonMethod.dialogLoader(context);
    });
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this, initialIndex: k);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
                                    .find('management_instructions'),
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
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTabController(
                    length: _tabs.length,
                    child: TabBar(
                      isScrollable: false,
                      indicatorColor: AppColors.blue,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      unselectedLabelStyle: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.appGreyColor[500],
                          fontFamily: "rubikregular"),
                      labelStyle: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.blue,
                          fontFamily: "rubikregular"),
                      labelColor: AppColors.blue,
                      unselectedLabelColor: AppColors.appGreyColor[500],
                      tabs: _tabs,
                      controller: _tabController,
                    ),
                  ),
                  Container(
                      height: 1,
                      decoration: BoxDecoration(
                          color: AppColors.strokeColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mediumGrey,
                              blurRadius: 2.0, // soften the shadow
                              offset: Offset(
                                0.5, // Move to right 10  horizontally
                                0.5, // Move to bottom 10 Vertically
                              ),
                            )
                          ])),
                  isLoader == true
                      ? Container()
                      : Expanded(
                          child: Container(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                TrainingInstructionScreen(
                                  trainingInstructions:
                                      model.data!.trainingInstructions,
                                  callBack: this,
                                ),
                                GameInstructionScreen(
                                  gameInstructions:
                                      model.data!.gameInstructions!,
                                  callBack: this,
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          )),
    );
  }

  List<Tab> getTabs() {
    _tabs.clear();

    if (CommonMethod.appLanguage() == "English") {
      _tabs.add(globals.trainingCount != 0
          ? getPracticTab("Practice")
          : getTab("Practice"));

      _tabs.add(globals.gameCount != 0 ? getGameTab("Games") : getTab("Games"));
    } else {
      _tabs.add(globals.trainingCount != 0
          ? getPracticTab("אימונים")
          : getTab("אימונים"));

      _tabs.add(
          globals.gameCount != 0 ? getGameTab("משחקים") : getTab("משחקים"));
    }

    setState(() {});
    return _tabs;
  }

  Tab getTab(String tabName) {
    return Tab(
      text: tabName,
    );
  }

  Tab getPracticTab(String tabName) {
    return Tab(
      icon: Badge(
        shape: BadgeShape.square,
        badgeColor: AppColors.defaultAppColor[500]!,
        borderRadius: BorderRadius.circular(5),
        position: BadgePosition.topStart(start: 20, top: -20),
        padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
        badgeContent: Text(
          "${globals.trainingCount}",
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        child: Text(
          '$tabName',
        ),
      ),
      //  text: "$tabName",
    );
  }

  Tab getGameTab(String tabName) {
    return Tab(
      icon: Badge(
        shape: BadgeShape.square,
        badgeColor: AppColors.defaultAppColor[500]!,
        borderRadius: BorderRadius.circular(5),
        position: BadgePosition.topStart(start: 20, top: -20),
        padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
        badgeContent: Text(
          "${globals.gameCount}",
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        child: Text(
          '$tabName',
        ),
      ),
      //  text: "$tabName",
    );
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
    isLoader = false;
    Navigator.pop(context);

    setState(() {});
  }

  @override
  void onUpdate() {}

  @override
  void refershInstruction(int i) {
    k = i;
    setState(() {});
    print("refersh");
    _tabs = getTabs();
    _tabController = getTabController();
    // getselectedData();
    hundler();
    ApiCall.instruction(this, context);
  }

  @override
  void refershPage(int i) {
    k = i;
    setState(() {});
    print("refersh");
    _tabs = getTabs();
    _tabController = getTabController();
    // getselectedData();
    hundler();
    ApiCall.instruction(this, context);
  }

  @override
  void updateBadge(id, String type) {
    print(type);
    if (type == "game") {
    } else if (type == "game_instruction" || type == "training_instruction") {
      totalInstruction(context);
      hundler();
      ApiCall.instruction(this, context);
    } else {}
  }

  Future<http.Response?> totalInstruction(BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.totalInstruction), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          globals.totalCount = data['totalCount'];
          globals.gameCount = data['gameCont'];
          globals.trainingCount = data['trainingCount'];
          print(globals.totalCount);
          setState(() {});
        } else {
          setState(() {});
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.

      }
    } catch (e) {}
  }
}
