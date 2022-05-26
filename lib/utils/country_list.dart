import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_center/apiservice/api_call.dart';
import 'package:team_center/apiservice/api_interface.dart';
import 'package:team_center/utils/StateList.dart';
import 'package:team_center/utils/model/CountryModel.dart';

import 'AppColors.dart';
import 'AppTextSize.dart';
import 'CommonMethod.dart';
import 'TeamCenterLocalizations.dart';

class CountryList extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CountryList> implements ApiInterface {
  List dataList = [];

  TextEditingController controller = new TextEditingController();
  String? filter;
  bool _isInAsyncCall = true;
  CountryModel model = new CountryModel();

  @override
  initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    // setState(() {
    //   _isInAsyncCall = true;
    // });
    // ApiCall.getStatePost(this);
    readJson();
  }

  readJson() {
    ApiCall.getCountry(this, context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      body: _isInAsyncCall == true
          ? CommonMethod.loader(context)
          : Padding(
              padding: EdgeInsets.all(16),
              child: new Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, "");
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 24,
                          color: AppColors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, "");
                        },
                        child: AppTextSize.textSize20(
                            TeamCenterLocalizations.of(context)!
                                .find('Country'),
                            AppColors.blue,
                            FontWeight.normal,
                            "rubikregular",
                            1),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  new TextField(
                    decoration: new InputDecoration(
                        hintText: TeamCenterLocalizations.of(context)!
                            .find('Country'),
                        focusColor: Colors.black),
                    controller: controller,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  new Expanded(
                      child: new ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: model.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return filter == null || filter == ""
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pop(context, model.data![index]);
                              },
                              child: Container(
                                  height: 30,
                                  child: new Text(
                                      CommonMethod.appLanguage() == "English"
                                          ? model.data![index].countryEng!
                                          : model.data![index].countryHb!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.normal))))
                          : CommonMethod.appLanguage() == "English"
                              ? model.data![index].countryEng
                                      .toString()
                                      .toLowerCase()
                                      .contains(filter!.toLowerCase())
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.pop(
                                            context, model.data![index]);
                                      },
                                      child: Container(
                                          height: 30,
                                          child: new Text(
                                              model.data![index].countryEng!,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight:
                                                      FontWeight.normal))))
                                  : new Container()
                              : model.data![index].countryHb
                                      .toString()
                                      .toLowerCase()
                                      .contains(filter!.toLowerCase())
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.pop(
                                            context, model.data![index]);
                                      },
                                      child:
                                          Container(height: 30, child: new Text(model.data![index].countryHb!, style: TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.normal))))
                                  : new Container();
                    },
                  )),
                ],
              )),
    );
  }

  @override
  void onFailure(message) {}

  @override
  void onSuccess(data) {
    model = new CountryModel.fromJson(data);
    setState(() {
      _isInAsyncCall = false;
    });
  }
}
