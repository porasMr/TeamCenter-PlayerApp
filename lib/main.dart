import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:team_center/ui/SplashScreen.dart';
import 'package:team_center/ui/home_package%20copy/homePage.dart';
import 'package:team_center/ui/login_package/LoginScreen.dart';
import 'package:team_center/ui/otp_package/OtpScreen.dart';
import 'package:team_center/ui/terms_and_consitions_package/TermsAndConditions.dart';
import 'package:team_center/utils/CommonMethod.dart';
import 'package:team_center/utils/GlobalConstants.dart';
import 'package:team_center/utils/NotificationCallBack.dart';
import 'package:team_center/utils/TeamCenterLocalizations.dart';
import 'package:team_center/utils/shared_preferences.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request();

  // HttpOverrides.global = MyHttpOverrides();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  static void setLocale(BuildContext? context, Locale newLocale) async {
    MyHomePageState state =
        context!.findAncestorStateOfType<MyHomePageState>()!;
    state.changeLanguage(newLocale);
  }

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Locale _locale = new Locale("he");

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return ScreenUtilInit(
        builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              routes: <String, WidgetBuilder>{
                '/OtpScreen': (BuildContext context) => new OtpScreen(),
                '/LoginScreen': (BuildContext context) => new LoginScreen(),
                '/HomePageScreen': (BuildContext context) =>
                    new HomePageScreen(),
              },
              locale: _locale,
              supportedLocales: [
                const Locale('en', 'US'),
                const Locale('he', 'IL'),
              ],
              localizationsDelegates: [
                const TeamCenterLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
            ));
  }

  initPlatformState() async {
    OneSignal.shared.init(GlobalConstants.oneSignalAppId, iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = status.subscriptionStatus.userId;
    print("One Signal Player ID == > $playerId ");
    SharedPref.savePlayerId(playerId);

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      int ID = notification.androidNotificationId;
      this.setState(() {
        print("addinal data ${notification.payload.additionalData}");

        var data = json.encode(notification.payload.additionalData);
        Map p = jsonDecode(data);

        SharedPref.saveNotificationId(p['id'].toString());
        SharedPref.saveNotificationType(p['type'].toString());
      });

      // //callBack.onClick(data['a']['id'].toString(), data['a']['type']);
      // print("result type==========" + p['id'].toString());
    });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        var data = json.encode(result.notification.payload.additionalData);
        Map p = jsonDecode(data);

        SharedPref.saveNotificationId(p['id'].toString());
        SharedPref.saveNotificationType(p['type'].toString());
        //callBack.onClick(data['a']['id'].toString(), data['a']['type']);
        print("result type==========" + p['id'].toString());
        // print("result typedsfgfgdfgdgdgdgdgdg");

        // print("result type==========" +
        //     result.notification.payload.rawPayload!.toString());
      });
    });
    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      this.setState(() {});
    });
  }

// //   initPlatformState() async {
// //     //Remove this method to stop OneSignal Debugging
// //     OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
// //     OneSignal.shared.setAppId(
// //       GlobalConstants.oneSignalAppId,
// //     );

// //     var deviceState = await OneSignal.shared.getDeviceState();

// //     if (deviceState == null || deviceState.userId == null) return;

// //     var playerId = deviceState.userId;
// //     print("PlayerId:----" + playerId!);

// //     SharedPref.savePlayerId(playerId);
// // // The promptForPushNotificationthUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
// //     OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
// //       print("Accepted permission: $accepted");
// //     });

// //     OneSignal.shared.setNotificationWillShowInForegroundHandler(
// //         (OSNotificationReceivedEvent event) {
// //       // Will be called whenever a notification is received in foreground
// //       // Display Notification, pass null param for not displaying the notification
// //       event.complete(event.notification);
// //       // print("notification type==========" +
// //       //     event.notification.rawPayload.toString());
// //       var data = json.decode(event.notification.rawPayload!['custom']);
// //       SharedPref.saveNotificationId(data['a']['id'].toString());
// //       SharedPref.saveNotificationType(data['a']['type'].toString());
// //       //callBack.onClick(data['a']['id'].toString(), data['a']['type']);
// //       print("notification type==========" + data['a']['id'].toString());
// //     });

// //     OneSignal.shared
// //         .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
// //       print("result typedsfgfgdfgdgdgdgdgdg");

// //       print(
// //           "result type==========" + result.notification.rawPayload!.toString());

// //       var data = json.decode(result.notification.rawPayload!['custom']);
// //       SharedPref.saveNotificationId(data['a']['id'].toString());
// //       SharedPref.saveNotificationType(data['a']['type'].toString());
// //       //callBack.onClick(data['a']['id'].toString(), data['a']['type']);
// //       print("result type==========" + data['a']['id'].toString());
// //       // Will be called whenever a notification is opened/button pressed.
// //     });

// //     OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
// //       // Will be called whenever the permission changes
// //       // (ie. user taps Allow on the permission prompt in iOS)
// //     });

// //     OneSignal.shared
// //         .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
// //       // Will be called whenever the subscription changes
// //       // (ie. user gets registered with OneSignal and gets a user ID)
// //     });

//     OneSignal.shared.setEmailSubscriptionObserver(
//         (OSEmailSubscriptionStateChanges emailChanges) {
//       // Will be called whenever then user's email subscription changes
//       // (ie. OneSignal.setEmail(email) is called and the user gets registered
//     });
//   }
}
