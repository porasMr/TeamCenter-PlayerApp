import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:team_center/apiservice/api_call.dart';

import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/utils/AppColors.dart';
import 'package:team_center/utils/AppTextSize.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/strings.dart';
import 'package:html/dom.dart' as dom;
import 'package:team_center/utils/globals.dart' as globals;

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen>
    implements ApiInterface {
  String hmtlText = "";
  hundler() async {
    Timer(Duration(microseconds: 100), () {
      CommonMethod.dialogLoader(context);
    });
  }

  @override
  void initState() {
    super.initState();

    hmtlText = CommonMethod.appLanguage() == "English"
        ? "${globals.model.data!.appScreen![2].text![0].text!}"
        : "${globals.model.data!.appScreen![2].text![1].text!}";
    //hundler();
    //ApiCall.termsAndCondition(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor[500],
      body: SafeArea(
          top: false,
          bottom: false,
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
                            Navigator.pop(context, true);
                          },
                          child: AppTextSize.textSize16(
                              TeamCenterLocalizations.of(context)!.find('tc'),
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
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      child: Container(
                        margin: EdgeInsets.only(left: 24, right: 24, top: 20),
                        child: Html(
                          data: hmtlText,
                          customTextAlign: (_) =>
                              CommonMethod.appLanguage() == "English"
                                  ? TextAlign.left
                                  : TextAlign.right,
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  @override
  void onFailure(message) {
    Navigator.pop(context);
  }

  @override
  void onSuccess(data) {
    print(data);
    Navigator.pop(context);
    hmtlText = data['data']['text'];
    setState(() {});
  }
}
