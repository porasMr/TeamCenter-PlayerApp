import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:team_center/apiservice/key_string.dart';
import 'package:team_center/main.dart';
import 'package:team_center/utils/AppImages.dart';
import 'package:intl/intl.dart';
import 'package:team_center/utils/GlobalConstants.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'TeamCenterLocalizations.dart';
import 'package:team_center/utils/globals.dart' as globals;

class CommonMethod {
  static List<String> days = [
    "ראשון",
    "שני",
    "שלישי",
    "רביעי",
    "חמישי",
    "שישי",
    "שבת"
  ];
  static List<String> daysEng = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];

  static var monthNameList = [
    "ינואר",
    "פברואר",
    "מרץ",
    "אפריל",
    "מאי",
    "יוני",
    "יולי",
    "אוגוסט",
    "ספטמבר",
    "אוקטובר",
    "נובמבר",
    "דצמבר"
  ];

  static var monthNameListEng = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static Widget loader(BuildContext context) {
    return Center(
        child: Image.asset(AppImages.loaderGif, width: 100, height: 100));
  }

  static void dialogLoader(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Image.asset(AppImages.loaderGif, width: 100, height: 100),
          );
        });
  }

  static void showErrorFlushbar(BuildContext context, String meaage) {
    Flushbar(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      borderRadius: 8,
      duration: Duration(milliseconds: 2000),
      backgroundGradient: LinearGradient(
        colors: [Colors.red.shade800, Colors.red.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: "",
      message: meaage,
    )..show(context);
  }

  static void showSuccessFlushbar(BuildContext context, String meaage) {
    Flushbar(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      borderRadius: 8,

      duration: Duration(milliseconds: 2000),
      backgroundGradient: LinearGradient(
        colors: [Colors.green.shade800, Colors.green.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: "",
      message: meaage,
    )..show(context);
  }

  static String timeRetrun(String value) {
    if (value.contains(":")) {
      return value;
    } else {
      print("time value:= $value");
      return new DateFormat("h:mm a").format(
          new DateTime.fromMillisecondsSinceEpoch((int.parse(value)))
              .toLocal());
    }
  }

  static String dateRetrun(String value) {
    var p;
    for (int i = 0; i < daysEng.length; i++) {
      if (new DateFormat("EEE d.MM")
          .format(DateTime.parse(value))
          .contains(daysEng[i])) {
        p = i;
        break;
      }
    }
    if (appLanguage() == "English") {
      return new DateFormat("EEE d.MM").format(DateTime.parse(value));
    } else {
      return new DateFormat("EEE d.MM")
          .format(DateTime.parse(value))
          .replaceAll(daysEng[p], days[p]);
    }
  }

  static String datysName(String value) {
    var p;
    for (int i = 0; i < daysEng.length; i++) {
      if (daysEng[i] == new DateFormat("EEE").format(DateTime.parse(value))) {
        p = i;
        break;
      }
    }
    if (appLanguage() == "English") {
      return new DateFormat("EEE").format(DateTime.parse(value));
    } else {
      return days[p];
    }
  }

  static String dateStatRetrun(String value) {
    return new DateFormat("d.MM.yy").format(DateTime.parse(value));
  }

  static String dateChangeRetrun(String value) {
    return new DateFormat("d/MM/yy").format(DateTime.parse(value));
  }

  static String dateMonthRetrun(String value) {
    return new DateFormat("d.MM").format(DateTime.parse(value));
  }

  static String? validateNameField(String value, BuildContext context) {
// Indian Mobile number are of 10 digit only
    if (value.isEmpty) {
      return TeamCenterLocalizations.of(context)!.find('thisFieldRequired');
    } else
      return null;
  }

  static String? validatePhoneNumber(String value, String phoneError) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Phone number can't be empty";
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    } else if (phoneError != "") {
      return phoneError;
    }
    return null;
  }

  static String? profileImage() {
    return jsonDecode(SharedPref.getProfileData())[KeyConstant.profile_image]
        .toString();
  }

  static String? clubLogoImage() {
    return jsonDecode(SharedPref.getProfileData())[KeyConstant.club_logo]
            [KeyConstant.club_logo]
        .toString();
  }

  static String? userName() {
    return jsonDecode(SharedPref.getProfileData())[GlobalConstants.firstName];
  }

  static String? userId() {
    return jsonDecode(SharedPref.getProfileData())[GlobalConstants.id]
        .toString();
  }

  static String? userLastName() {
    String? last;
    if (jsonDecode(SharedPref.getProfileData())[GlobalConstants.lastName]
            .toString() ==
        "null") {
      last = "";
    } else {
      last = jsonDecode(SharedPref.getProfileData())[GlobalConstants.lastName];
    }
    return last;
  }

  static String? country() {
    return appLanguage() == "English"
        ? jsonDecode(SharedPref.getProfileData())[GlobalConstants.country]
                [GlobalConstants.countryEng]
            .toString()
        : jsonDecode(SharedPref.getProfileData())[GlobalConstants.country]
                [GlobalConstants.countryHb]
            .toString();
  }

  static String? countryId() {
    return jsonDecode(SharedPref.getProfileData())[GlobalConstants.country]
            [GlobalConstants.countryId]
        .toString();
  }

  static String? phone() {
    return jsonDecode(SharedPref.getProfileData())[GlobalConstants.phone]
        .toString();
  }

  static String? appLanguage() {
    return SharedPref.getProfileData() != ""
        ? jsonDecode(SharedPref.getProfileData())[GlobalConstants.app_language]
        : Platform.localeName.contains("en")
            ? "English"
            : "עברית";
  }

  static String? city() {
    return jsonDecode(SharedPref.getProfileData())[GlobalConstants.city]
        .toString();
  }

  static String? email() {
    return jsonDecode(SharedPref.getProfileData())[GlobalConstants.email]
        .toString();
  }

  static String? address() {
    return jsonDecode(SharedPref.getProfileData())[GlobalConstants.addressData]
        .toString();
  }

  static String? groupID() {
    return jsonDecode(SharedPref.getProfileData())[GlobalConstants.group_id]
        .toString();
  }

  static List<String> stataData(String type) {
    List<String> data = new List.empty(growable: true);
    if (type != "") {
      var s = type.toString().split(",");
      for (int i = 0; i < s.length; i++) {
        data.add(s[i]);
      }
      return data;
    } else {
      return data;
    }
  }

  static List<String> fileDesciptionData(String type) {
    List<String> data = new List.empty(growable: true);
    if (type != "") {
      var s = type.toString().split("~");
      for (int i = 0; i < s.length; i++) {
        data.add(s[i]);
      }
      return data;
    } else {
      return data;
    }
  }

  // static PermissionData playerPermission() {
  //   return PermissionData.fromJson(jsonDecode(SharedPref.getPlayerdata()));
  // }

  // static PermissionData trainingPermission() {
  //   return PermissionData.fromJson(jsonDecode(SharedPref.getTrainingData()));
  // }

  // static PermissionData gamePermission() {
  //   return PermissionData.fromJson(jsonDecode(SharedPref.getGameData()));
  // }

  // static PermissionData testPermission() {
  //   return PermissionData.fromJson(jsonDecode(SharedPref.getTestData()));
  // }

  // static PermissionData stataisticPermission() {
  //   return PermissionData.fromJson(jsonDecode(SharedPref.getStatisticData()));
  // }

  // static PermissionData attendencePermission() {
  //   return PermissionData.fromJson(jsonDecode(SharedPref.getAttandenceData()));
  // }

  // static PermissionData managementPermission() {
  //   return PermissionData.fromJson(jsonDecode(SharedPref.getManagmentData()));
  // }

  // static PermissionData professionalPermission() {
  //   return PermissionData.fromJson(
  //       jsonDecode(SharedPref.getProfessionalData()));
  // }
  static initPlatformState(NotificationClick callBack) async {
    await OneSignal.shared.setAppId(GlobalConstants.oneSignalAppId);
    final status = await OneSignal.shared.getDeviceState();
    String? osUserID = status?.userId;
    print("One Signal Player ID == > $osUserID ");
    SharedPref.savePlayerId(osUserID!);
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
      print("addinal data ${result.notification.additionalData}");

      var data = json.encode(result.notification.additionalData);
      Map p = jsonDecode(data);
      // print("result type==========" +
      //     result.notification.payload.rawPayload!.toString());

      callBack.onClick(p['id'].toString(), p['type']);
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event}');
      int ID = event.notification.androidNotificationId!;
      print("addinal data ${event.notification.additionalData}");

      var data = json.encode(event.notification..additionalData);
      Map p = jsonDecode(data);
      print("result type==========" + p['type']);

      callBack.updateBadge(p['id'].toString(), p['type']);
    });
  }

  // static initPlatformState(NotificationClick callBack) async {
  //   OneSignal.shared.init(GlobalConstants.oneSignalAppId, iOSSettings: {
  //     OSiOSSettings.autoPrompt: true,
  //     OSiOSSettings.inAppLaunchUrl: true
  //   });
  //   OneSignal.shared
  //       .setInFocusDisplayType(OSNotificationDisplayType.notification);
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();
  //   var playerId = status.subscriptionStatus.userId;
  //   print("One Signal Player ID == > $playerId ");
  //   SharedPref.savePlayerId(playerId);

  //   OneSignal.shared.setNotificationReceivedHandler((notification) {
  //     int ID = notification.androidNotificationId;
  //     print("addinal data ${notification.payload.additionalData}");

  //     var data = json.encode(notification.payload.additionalData);
  //     Map p = jsonDecode(data);
  //     print("result type==========" + p['type']);

  //     callBack.updateBadge(p['id'].toString(), p['type']);
  //   });
  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     // print("result typedsfgfgdfgdgdgdgdgdg");
  //     print("addinal data ${result.notification.payload.additionalData}");

  //     var data = json.encode(result.notification.payload.additionalData);
  //     Map p = jsonDecode(data);
  //     // print("result type==========" +
  //     //     result.notification.payload.rawPayload!.toString());

  //     callBack.onClick(p['id'].toString(), p['type']);
  //   });
  //   OneSignal.shared
  //       .setInAppMessageClickedHandler((OSInAppMessageAction action) {});
  // }

  static Future<void> launchInWebViewWithJavaScript(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    )) {
      throw 'Could not launch $url';
    }
  }

  static openloginPage(BuildContext context, String message) {
    SharedPref.logout();
    if (Platform.localeName.contains("he")) {
      Locale newLocale = Locale("he");
      MyHomePage.setLocale(context, newLocale);
    } else {
      Locale newLocale = Locale("en");
      MyHomePage.setLocale(context, newLocale);
    }
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/LoginScreen', (Route<dynamic> route) => false);
  }

//   static initPlatformState(NotificationClick callBack) async {
//     //Remove this method to stop OneSignal Debugging
//     OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//     OneSignal.shared.setAppId(
//       GlobalConstants.oneSignalAppId,
//     );

//     var deviceState = await OneSignal.shared.getDeviceState();

//     if (deviceState == null || deviceState.userId == null) return;

//     var playerId = deviceState.userId;
//     print("PlayerId:----" + playerId!);

//     SharedPref.savePlayerId(playerId);
// // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//     OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//       print("Accepted permission: $accepted");
//     });

//     OneSignal.shared.setNotificationWillShowInForegroundHandler(
//         (OSNotificationReceivedEvent event) {
//       // Will be called whenever a notification is received in foreground
//       // Display Notification, pass null param for not displaying the notification
//       event.complete(event.notification);
//       // print("notification type==========" +
//       //     event.notification.rawPayload.toString());
//       var data = json.decode(event.notification.rawPayload!['custom']);
//       callBack.onClick(data['a']['id'].toString(), data['a']['type']);
//       print("notification type==========" + data['a']['game_id'].toString());
//     });

//     OneSignal.shared
//         .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
//       print("result typedsfgfgdfgdgdgdgdgdg");
//       var data = json.decode(result.notification.rawPayload!['custom']);
//       callBack.onClick(data['a']['id'].toString(), data['a']['type']);
//       print("result type==========" + data['a']['game_id'].toString());
//       // Will be called whenever a notification is opened/button pressed.
//     });

//     OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
//       // Will be called whenever the permission changes
//       // (ie. user taps Allow on the permission prompt in iOS)
//     });

//     OneSignal.shared
//         .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
//       // Will be called whenever the subscription changes
//       // (ie. user gets registered with OneSignal and gets a user ID)
//     });

//     OneSignal.shared.setEmailSubscriptionObserver(
//         (OSEmailSubscriptionStateChanges emailChanges) {
//       // Will be called whenever then user's email subscription changes
//       // (ie. OneSignal.setEmail(email) is called and the user gets registered
//     });
//   }
  static Future<void> _launchInWebViewWithDomStorage(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      enableDomStorage: true,
    )) {
      throw 'Could not launch $url';
    }
  }
}
