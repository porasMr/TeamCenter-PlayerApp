import 'dart:convert' show jsonDecode, json;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:team_center/apiservice/url_string.dart';

import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/GlobalConstants.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/shared_preferences.dart';

import 'api_interface.dart';
import 'key_string.dart';

class ApiCall {
  static Future<http.Response?> getStatePost(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse("https://restcountries.eu/rest/v2/all"));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        callBack.onSuccess(data);

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> fetchPlayer(
      String search, ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http.get(
          Uri.parse(UrlConstant.players +
              CommonMethod.groupID()! +
              "&search=$search"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${SharedPref.getLoginToken()}",
          });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> fetchPlayerPostions(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.playerPosition), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> sendOtpApi(String country_code, String phone,
      ApiInterface callBack, BuildContext context) async {
    print(country_code + " " + phone);
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.sendOtp), headers: {
        "Accept": "application/json"
      }, body: {
        KeyConstant.phone: phone,
        KeyConstant.country_code: country_code,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> contactUsApi(
      String name,
      String phone,
      String email,
      String message,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.contactUs), headers: {
        "Accept": "application/json"
      }, body: {
        KeyConstant.name: name,
        KeyConstant.phone: phone,
        KeyConstant.email: email,
        // KeyConstant.country_code: "+972",
        KeyConstant.message: message,
      });
      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> verifyOtpApi(
      String otp,
      String phone,
      String lang,
      String versionName,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response = await http.post(Uri.parse(UrlConstant.login), headers: {
        "Accept": "application/json"
      }, body: {
        KeyConstant.otp: otp,
        KeyConstant.phone: phone,
        KeyConstant.app_lang: lang,
        KeyConstant.device: Platform.isIOS ? "ios" : "android",
        KeyConstant.applicationVersion: versionName,
        KeyConstant.oneSignalId: SharedPref.getPlayerId()
      });
      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<dynamic> createPlayerProfile(
      String firstname,
      String lastname,
      String height,
      String weight,
      String fat,
      String muscle,
      String dob,
      String positionid,
      String phonenumber,
      String country,
      String city,
      String address,
      String shirtnumber,
      String iscaptian,
      String profile,
      String foot,
      String yellow_card,
      String red_card,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      var postUri = Uri.parse(UrlConstant.addPlayer);
      var request = await http.MultipartRequest('POST', postUri);
      request.fields[KeyConstant.group_id] = CommonMethod.groupID()!;

      request.fields[KeyConstant.firstname] = firstname;
      request.fields[KeyConstant.lastname] = lastname;
      request.fields[KeyConstant.height] = height;
      request.fields[KeyConstant.weight] = weight;
      request.fields[KeyConstant.fat] = fat;
      request.fields[KeyConstant.muscle] = muscle;
      request.fields[KeyConstant.dob] = dob;
      request.fields[KeyConstant.positionId] = positionid;
      request.fields[KeyConstant.phonenumber] = phonenumber;
      request.fields[KeyConstant.country] = country;
      request.fields[KeyConstant.city] = city;

      request.fields[KeyConstant.address] = address;
      request.fields[KeyConstant.shirtnumber] = shirtnumber;
      request.fields[KeyConstant.iscaptian] = iscaptian;
      request.fields[KeyConstant.foot] = foot;
      request.fields[KeyConstant.yellow_card] = yellow_card;

      request.fields[KeyConstant.red_card] = red_card;

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      };
      request.headers.addAll(headers);
      if (profile != "") {
        var multipartFile =
            await http.MultipartFile.fromPath(KeyConstant.profile, profile);
        request.files.add(multipartFile);
      }
      var streamedResponse = await request.send();
      /* streamedResponse.stream.transform(utf8.decoder).listen((value) {
      print("Response ===> $value");

    });*/
      final response = await http.Response.fromStream(streamedResponse);
      final int statusCode = response.statusCode;
      print("statusCode" + response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        callBack.onFailure("Failed to upload");

        throw new Exception("Error while fetching data");
      } else {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }

  static Future<dynamic> updatePlayerProfile(
      String playerId,
      String firstname,
      String lastname,
      String height,
      String weight,
      String fat,
      String muscle,
      String dob,
      String positionid,
      String phonenumber,
      String country,
      String city,
      String address,
      String shirtnumber,
      String iscaptian,
      String profile,
      String foot,
      String yellow_card,
      String red_card,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      var postUri = Uri.parse(UrlConstant.updatePlayer);
      var request = await http.MultipartRequest('POST', postUri);
      request.fields[KeyConstant.playerid] = playerId;
      request.fields[KeyConstant.group_id] = CommonMethod.groupID()!;

      request.fields[KeyConstant.firstname] = firstname;
      request.fields[KeyConstant.lastname] = lastname;
      request.fields[KeyConstant.height] = height;
      request.fields[KeyConstant.weight] = weight;
      request.fields[KeyConstant.fat] = fat;
      request.fields[KeyConstant.muscle] = muscle;
      request.fields[KeyConstant.dob] = dob;
      request.fields[KeyConstant.positionId] = positionid;
      request.fields[KeyConstant.phonenumber] = phonenumber;
      request.fields[KeyConstant.country] = country;
      request.fields[KeyConstant.city] = city;

      request.fields[KeyConstant.address] = address;
      request.fields[KeyConstant.shirtnumber] = shirtnumber;
      request.fields[KeyConstant.iscaptian] = iscaptian;
      request.fields[KeyConstant.foot] = foot;
      request.fields[KeyConstant.yellow_card] = yellow_card;

      request.fields[KeyConstant.red_card] = red_card;

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      };
      request.headers.addAll(headers);
      if (profile != "") {
        var multipartFile =
            await http.MultipartFile.fromPath(KeyConstant.profile, profile);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      /* streamedResponse.stream.transform(utf8.decoder).listen((value) {
      print("Response ===> $value");

    });*/
      final response = await http.Response.fromStream(streamedResponse);
      final int statusCode = response.statusCode;
      print("statusCode" + response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        callBack.onFailure("Failed to upload");

        throw new Exception("Error while fetching data");
      } else {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }

  static Future<http.Response?> getAbility(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.ability), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.playerid: CommonMethod.userId(),
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateAbility(
      String id,
      String speed,
      String agility,
      String burstingPower,
      String flexibility,
      String endurance,
      String aggressive,
      String physicalGoal,
      String kick,
      String delivery,
      String lifting,
      String stop,
      String ballTransport,
      String ballControl,
      String tackle,
      String technicalGoal,
      String movement,
      String decisionMaking,
      String gameUnderstand,
      String spaceOrientation,
      String location,
      String tacticalGoal,
      String mentalGoal,
      String pendelKick,
      String freeKick,
      String cornerKick,
      String outServing,
      String leader,
      String assist,
      String specialAbilitiyGoal,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.updataAbility), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.playerid: id,
        KeyConstant.speed: speed,
        KeyConstant.agility: agility,
        KeyConstant.burstingPower: burstingPower,
        KeyConstant.flexibility: flexibility,
        KeyConstant.endurance: endurance,
        KeyConstant.aggressive: aggressive,
        KeyConstant.physicalGoal: physicalGoal,
        KeyConstant.kick: kick,
        KeyConstant.delivery: delivery,
        KeyConstant.lifting: lifting,
        KeyConstant.stop: stop,
        KeyConstant.ballTransport: ballTransport,
        KeyConstant.ballControl: ballControl,
        KeyConstant.tackle: tackle,
        KeyConstant.technicalGoal: technicalGoal,
        KeyConstant.movement: movement,
        KeyConstant.decisionMaking: decisionMaking,
        KeyConstant.gameUnderstand: gameUnderstand,
        KeyConstant.spaceOrientation: spaceOrientation,
        KeyConstant.location: location,
        KeyConstant.tacticalGoal: tacticalGoal,
        KeyConstant.mentalGoal: mentalGoal,
        KeyConstant.pendelKick: pendelKick,
        KeyConstant.freeKick: freeKick,
        KeyConstant.cornerKick: cornerKick,
        KeyConstant.outServing: outServing,
        KeyConstant.leader: leader,
        KeyConstant.assist: assist,
        KeyConstant.specialAbilitiyGoal: specialAbilitiyGoal
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<dynamic> uploadPlayerImage(
      String profile, ApiInterface callBack, BuildContext context) async {
    try {
      var postUri = Uri.parse(UrlConstant.uploadLineUpImage);
      var request = await http.MultipartRequest('POST', postUri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      };
      request.headers.addAll(headers);
      if (profile != "") {
        var multipartFile = await http.MultipartFile.fromPath(
            KeyConstant.line_up_image, profile);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      /* streamedResponse.stream.transform(utf8.decoder).listen((value) {
      print("Response ===> $value");

    });*/
      final response = await http.Response.fromStream(streamedResponse);
      final int statusCode = response.statusCode;
      print("statusCode" + response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        callBack.onFailure("Failed to upload");

        throw new Exception("Error while fetching data");
      } else {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }

  static Future<http.Response?> fetchGameList(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http.get(
          Uri.parse(UrlConstant.gameList + CommonMethod.groupID()!),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${SharedPref.getLoginToken()}",
          });
      print(response.body.toString());

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> playerProfile(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.playerProfile), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });
      print(response.body.toString());

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> homepageData(
      ApiInterface callBack, BuildContext context) async {
    print("${SharedPref.getLoginToken()}");
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.homePageData), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });
      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> gameDetailsApi(
      String game_id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.getGameDetail), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.game_id: game_id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> deleteGameApi(
      String game_id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.deleteGame), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.game_id: game_id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> deletePlayer(
      String id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.deletePlayer), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
        KeyConstant.player_id: id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateGameAttendance(
      String id,
      String late,
      String attend,
      String allAttend,
      String playerID,
      ApiInterface callBack,
      BuildContext context) async {
    print(id + " " + late + " " + attend + " " + allAttend + " " + playerID);
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.updateGameAttendance), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.game_id: id,
        KeyConstant.player_id: playerID,
        KeyConstant.is_late: late,
        KeyConstant.is_attend: attend,
        KeyConstant.allAttend: allAttend,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateGameSummary(
      String id,
      String generalSummary,
      String offensiveSummary,
      String defensiveSummary,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.updateGameSummary), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.game_id: id,
        KeyConstant.general_summary: generalSummary,
        KeyConstant.offensive_summary: offensiveSummary,
        KeyConstant.defensive_summary: defensiveSummary,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateGameState(
      String id,
      String playerID,
      String stat_id,
      String value,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.updateGameState), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.game_id: id,
        KeyConstant.player_id: playerID,
        KeyConstant.stat_id: stat_id,
        KeyConstant.value: value,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateGameResult(
      String id,
      String status,
      String myTeamScore,
      String revelTeamScore,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.updateGameResult), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.game_id: id,
        KeyConstant.status: status,
        KeyConstant.my_team_score: myTeamScore,
        KeyConstant.revel_team_score: revelTeamScore,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> gameState(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.gameState), headers: {
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
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> editProfileWithContact(
      String country,
      String city,
      String address,
      String phone,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.editPlayer), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.country: country,
        KeyConstant.city: city,
        KeyConstant.address: address,
        KeyConstant.phone: phone
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<dynamic> editProfile(
      String firstname,
      String lastname,
      String country,
      String city,
      String address,
      String phone,
      String app_language,
      String profile_image,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      var postUri = Uri.parse(UrlConstant.updateProfile);
      var request = await http.MultipartRequest('POST', postUri);

      request.fields[KeyConstant.firstName] = firstname;
      request.fields[KeyConstant.lastName] = lastname;

      request.fields[KeyConstant.country] = country;
      request.fields[KeyConstant.city] = city;

      request.fields[KeyConstant.address] = address;
      request.fields[KeyConstant.phone] = phone;
      request.fields[GlobalConstants.app_language] = app_language;
      print(request.fields);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      };
      request.headers.addAll(headers);
      if (profile_image != "") {
        var multipartFile = await http.MultipartFile.fromPath(
            KeyConstant.profile_image, profile_image);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      /* streamedResponse.stream.transform(utf8.decoder).listen((value) {
      print("Response ===> $value");

    });*/
      final response = await http.Response.fromStream(streamedResponse);
      final int statusCode = response.statusCode;
      print("statusCode" + response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        callBack.onFailure("Failed to upload");

        throw new Exception("Error while fetching data");
      } else {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }

  static Future<http.Response?> getTestList(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http.get(
          Uri.parse(UrlConstant.testList + CommonMethod.groupID()!),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${SharedPref.getLoginToken()}",
          });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> addTest(
      String name,
      String unit_type_en,
      String unit_type_he,
      String good_result_type,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.addTest), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
        KeyConstant.name: name,
        KeyConstant.unit_type_en: unit_type_en,
        KeyConstant.unit_type_he: unit_type_he,
        KeyConstant.good_result_type: good_result_type,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> addTestResult(
      String test_id,
      String date,
      String number,
      String player_id,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      print("number==${number}");
      final response =
          await http.post(Uri.parse(UrlConstant.addTestResult), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
        KeyConstant.test_id: test_id,
        KeyConstant.date: date,
        KeyConstant.numberKey: number,
        KeyConstant.player_id: player_id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> getTestResult(
      String test_id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.getTestResult), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.test_id: test_id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateTest(
      String test_id,
      String name,
      String unit_type_en,
      String unit_type_he,
      String good_result_type,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.updateTest), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.test_id: test_id,
        KeyConstant.name: name,
        KeyConstant.unit_type_en: unit_type_en,
        KeyConstant.unit_type_he: unit_type_he,
        KeyConstant.good_result_type: good_result_type,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> deleteTest(String test_id, String date,
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.deleteTestResult), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.test_id: test_id,
        KeyConstant.date: date,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> trainingList(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.trainingList), headers: {
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
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<dynamic> uploadImage(
      String image, ApiInterface callBack, BuildContext context) async {
    try {
      var postUri = Uri.parse(UrlConstant.uploadTrainingImage);
      var request = await http.MultipartRequest('POST', postUri);

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      };
      print(image);
      request.headers.addAll(headers);
      if (image != "") {
        var multipartFile =
            await http.MultipartFile.fromPath(KeyConstant.image, image);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      /* streamedResponse.stream.transform(utf8.decoder).listen((value) {
      print("Response ===> $value");

    });*/
      final response = await http.Response.fromStream(streamedResponse);
      final int statusCode = response.statusCode;
      print("statusCode" + response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        callBack.onFailure("Failed to upload");

        throw new Exception("Error while fetching data");
      } else {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }

  static Future<http.Response?> getTrainingDetail(
      String id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.getTrainingDetail), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.training_id: id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateTrainingAttandence(
      String id,
      String late,
      String attend,
      String allAttend,
      String playerID,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.updateTrainingAttendance), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.training_id: id,
        KeyConstant.player_id: playerID,
        KeyConstant.is_late: late,
        KeyConstant.is_attend: attend,
        KeyConstant.allAttend: allAttend,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateTrainingSummary(
      String id,
      String images,
      String conservation,
      String improvement,
      String summary,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.updateTrainingSummary), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.training_id: id,
        KeyConstant.images: images,
        KeyConstant.conservation: conservation,
        KeyConstant.improvement: improvement,
        KeyConstant.summary: summary,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateTrainingPlanOrder(
      String id,
      String oldIndex,
      String newIndex,
      ApiInterface callBack,
      BuildContext context) async {
    print(id + " " + oldIndex + " " + newIndex);
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.updateTrainingPlanOrder), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.training_id: id,
        KeyConstant.old_order: oldIndex,
        KeyConstant.new_order: newIndex
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> playerGameState(
      String id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.playerGameState), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.player_id: id,
        KeyConstant.group_id: CommonMethod.groupID(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> playertrainingAttendance(
      String id, ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.playertrainingAttendance), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.player_id: id,
        KeyConstant.group_id: CommonMethod.groupID(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> playerState(
      String id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.playerState), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.player_id: id,
        KeyConstant.group_id: CommonMethod.groupID(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> playerTestWithResult(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.playerTestWithResult), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.player_id: CommonMethod.userId().toString(),
        KeyConstant.group_id: CommonMethod.groupID(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> stffMember(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.stffMember), headers: {
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
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateTraining(
      String id,
      String date,
      String fromTime,
      String untilTime,
      String field_id,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.updateTraining), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
        KeyConstant.date: date,
        KeyConstant.from_time: fromTime,
        KeyConstant.untill_time: untilTime,
        KeyConstant.field_id: field_id,
        KeyConstant.training_id: id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> addTrainingProgram(
      String id,
      String name,
      String plan_time_id,
      String plan_level_id,
      String stafffmember,
      String description,
      String image,
      String fileData,
      String professionalId,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.addTrainingProgram), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.name: name,
        KeyConstant.group_id: CommonMethod.groupID(),
        KeyConstant.plan_time_id: plan_time_id,
        KeyConstant.plan_level_id: plan_level_id,
        KeyConstant.training_id: id,
        KeyConstant.staff_member: stafffmember,
        KeyConstant.description: description,
        KeyConstant.image: image,
        KeyConstant.managment_file: fileData,
        KeyConstant.professional_id: professionalId,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> deleteTraining(
      String id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.deleteTraining), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.training_id: id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> deleteTrainingProgram(String id, String plan_id,
      ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.deleteTrainingProgram), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.training_id: id,
        KeyConstant.plan_id: plan_id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data['message']);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> editTrainingProgram(
      String id,
      String planId,
      String name,
      String plan_time_id,
      String plan_level_id,
      String stafffmember,
      String description,
      String image,
      String fileData,
      String professionalId,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.editTrainingProgram), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.name: name,
        KeyConstant.plan_id: planId,
        KeyConstant.plan_time_id: plan_time_id,
        KeyConstant.plan_level_id: plan_level_id,
        KeyConstant.training_id: id,
        KeyConstant.staff_member: stafffmember,
        KeyConstant.description: description,
        KeyConstant.image: image,
        KeyConstant.managment_file: fileData,
        KeyConstant.professional_id: professionalId
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> termsAndCondition(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.termsAndCondition), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> getCountry(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.countries), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> getProfile(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.getProfile), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> playerfullGameAttendance(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.playerfullGameAttendance), headers: {
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
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> playerfulltrainingAttendance(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.playerfulltrainingAttendance), headers: {
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
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> playerGameAttendance(
      String id, ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.playerGameAttendance), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.player_id: id,
        KeyConstant.group_id: CommonMethod.groupID(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> getStatistics(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.statistics), headers: {
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
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> addStatistic(String player_id,
      String result_type, ApiInterface callBack, BuildContext context) async {
    print(player_id + " " + result_type);
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.addStatistic), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
        KeyConstant.player_id: player_id,
        KeyConstant.result_type: result_type,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> generalSetting(
      BuildContext context, ApiInterface callBack) async {
    try {
      final response = await http.get(Uri.parse(UrlConstant.generalSetting));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        callBack.onSuccess(data);

        // If server returns an OK response, parse the JSON
      } else {
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));

        // If that response was not OK, throw an error.
      }
    } catch (e) {
      print(e);
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> appPermission(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.userPermission), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> editStatistic(
      String player_id,
      String result_type,
      String stat_id,
      ApiInterface callBack,
      BuildContext context) async {
    print(player_id + " " + result_type);
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.editStatistic), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
        KeyConstant.player_id: player_id,
        KeyConstant.result_type: result_type,
        KeyConstant.stat_id: stat_id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateOneSignalToken(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.updateOneSignalToken), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.oneSignalId: SharedPref.getPlayerId(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          print("status code 403");

          callBack.onFailure(data['message']);
          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<dynamic> uploadDrawingImage(
      String profile,
      String frontpath,
      String name,
      String selectedGround,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      var postUri = Uri.parse(UrlConstant.uploadDrawingImage);
      var request = await http.MultipartRequest('POST', postUri);
      request.fields[KeyConstant.name] = name;
      request.fields[KeyConstant.ground_name] = selectedGround;

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      };
      request.headers.addAll(headers);
      if (profile != "") {
        var multipartFile =
            await http.MultipartFile.fromPath("main_image", profile);
        request.files.add(multipartFile);
      }
      if (frontpath != "") {
        var multipartFile1 =
            await http.MultipartFile.fromPath("edit_able_image", frontpath);
        request.files.add(multipartFile1);
      }

      var streamedResponse = await request.send();
      /* streamedResponse.stream.transform(utf8.decoder).listen((value) {
      print("Response ===> $value");

    });*/
      final response = await http.Response.fromStream(streamedResponse);
      final int statusCode = response.statusCode;
      print("statusCode" + response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        callBack.onFailure("Failed to upload");

        throw new Exception("Error while fetching data");
      } else {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }

  static Future<http.Response?> drawingBoardImage(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.drawingBoardImage), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> deleteDrawingBoard(
      String id, ApiInterface callBack, BuildContext context) async {
    print("board id $id");
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.deleteDrawingBoard), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.id: id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> editDrawingBoard(String id, String name,
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.editDrawingBoard), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.id: id,
        KeyConstant.name: name,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> clubStat(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.clubStat), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<dynamic> ediDrawingImage(
      String profile,
      String frontpath,
      String name,
      String id,
      ApiInterface callBack,
      BuildContext context) async {
    try {
      var postUri = Uri.parse(UrlConstant.editDrawingBoardImage);
      var request = await http.MultipartRequest('POST', postUri);
      request.fields[KeyConstant.ground_name] = name;
      request.fields[KeyConstant.id] = id;

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      };
      request.headers.addAll(headers);
      if (profile != "") {
        var multipartFile =
            await http.MultipartFile.fromPath("main_image", profile);
        request.files.add(multipartFile);
      }
      if (frontpath != "") {
        var multipartFile1 =
            await http.MultipartFile.fromPath("edit_able_image", frontpath);
        request.files.add(multipartFile1);
      }

      var streamedResponse = await request.send();
      /* streamedResponse.stream.transform(utf8.decoder).listen((value) {
      print("Response ===> $value");

    });*/
      final response = await http.Response.fromStream(streamedResponse);
      final int statusCode = response.statusCode;
      print("statusCode" + response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        callBack.onFailure("Failed to upload");

        throw new Exception("Error while fetching data");
      } else {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }

  static Future<http.Response?> instruction(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.instruction), headers: {
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
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> updateDynamicAbility(String id, String value,
      String playerID, ApiInterface callBack, BuildContext context) async {
    print("id==$id   $playerID   $value");
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.updateDynamicAbility), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.id: id,
        KeyConstant.player_id: playerID,
        KeyConstant.value: value
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> readInstruction(String id, String type,
      ApiInterface callBack, BuildContext context) async {
    print("$id   $type");
    try {
      final response = await http
          .post(Uri.parse(UrlConstant.readInstructionMessage), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.group_id: CommonMethod.groupID(),
        KeyConstant.instruction_id: id,
        KeyConstant.type: type
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> getFiledLIst(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse(UrlConstant.filedList), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });
      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> getTrainingPlanTimeAndLevel(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response = await http
          .get(Uri.parse(UrlConstant.trainingPlanTimeAndLevel), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      });
      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }
        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> shareDrawing(
      String id, ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.shareDrawinig), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.id: id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> professionalKnowledge(
      String searchTxt, ApiInterface callBack, BuildContext context) async {
    try {
      var search;
      final response = await http
          .post(Uri.parse(UrlConstant.professionalKnowledge), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${SharedPref.getLoginToken()}",
      }, body: {
        KeyConstant.search: searchTxt,
        KeyConstant.group_id: CommonMethod.groupID(),
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        if (data['status'] == 1) {
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          callBack.onFailure(data['message']);

          CommonMethod.openloginPage(context, data['message']);
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }

  static Future<http.Response?> selectLineUp(
      ApiInterface callBack, BuildContext context) async {
    try {
      final response =
          await http.post(Uri.parse(UrlConstant.lineUpimage), headers: {
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
          callBack.onSuccess(data);
        } else if (data['status'] == 403) {
          CommonMethod.openloginPage(context, data['message']);
          ;
        } else {
          callBack.onFailure(data['message']);
        }

        // If server returns an OK response, parse the JSON
      } else {
        // If that response was not OK, throw an error.
        callBack.onFailure(
            TeamCenterLocalizations.of(context)!.find('serverError'));
      }
    } catch (e) {
      callBack
          .onFailure(TeamCenterLocalizations.of(context)!.find('serverError'));
    }
  }
}
