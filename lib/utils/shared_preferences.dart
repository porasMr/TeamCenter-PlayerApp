import 'package:shared_preferences/shared_preferences.dart';

import 'GlobalConstants.dart';

class SharedPref {
  static SharedPreferences? prefs;
  static SharedPreferences? regPrefs;

  SharedPref() {
    loadPrefs();
  }

  //set data into shared preferences like this
  static Future<void> saveBooleanInPrefs(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool(key, value);
  }

//get value from shared preferences
  static getBooleanFromPrefs(String key) {
    return prefs!.getBool(key) ?? false;
  }

  static Future<bool> getBool(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(key) ?? false;
  }

  static Future<void> saveStringInPrefs(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(key, value);
  }

//get value from shared preferences
  static getStringFromPrefs(String key) {
    return prefs!.getString(key) ?? "";
  }

  static Future<void> saveIntInPrefs(String key, int value) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setInt(key, value);
  }

//get value from shared preferences
  static getIntFromPrefs(String key) {
    return prefs!.getInt(key) ?? 0;
  }

  static loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    regPrefs = await SharedPreferences.getInstance();
  }

  static remove(String key) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.remove(key);
  }

  static Future clear() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.clear();
  }

  static Future<String> getLoginStatus(String key) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key) ?? "0";
  }

  static Future<bool> setLoginStatus(String key, String value) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setString(key, value);
  }

  //-----------------------------Gernal data end--------------------------
  static Future<void> saveProfileData(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.profile, v);
  }

  static getProfileData() {
    return prefs!.getString(GlobalConstants.profile) ?? "";
  }

  static Future<void> saveLoginToken(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.token, v);
  }

  static getLoginToken() {
    return prefs!.getString(GlobalConstants.token) ?? "";
  }

  static Future logout() async {
    saveLoginToken("");
    saveBooleanInPrefs(GlobalConstants.LOGINSTATUS, false);
    saveProfileData("");
  }

  //==================User permission
  static Future<void> playerPermission(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.player, v);
  }

  static Future<void> trainingPermission(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.training, v);
  }

  static Future<void> gamePermission(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.game, v);
  }

  static Future<void> testsPermission(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.tests, v);
  }

  static Future<void> statisticPermission(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.statistic, v);
  }

  static Future<void> attendancePermission(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.attendance, v);
  }

  static Future<void> managmentPermission(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.managment, v);
  }

  static Future<void> professionalPermission(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.professional, v);
  }

  static getPlayerdata() {
    return prefs!.getString(GlobalConstants.player) ?? "";
  }

  static getTrainingData() {
    return prefs!.getString(GlobalConstants.training) ?? "";
  }

  static getGameData() {
    return prefs!.getString(GlobalConstants.game) ?? "";
  }

  static getTestData() {
    return prefs!.getString(GlobalConstants.tests) ?? "";
  }

  static getStatisticData() {
    return prefs!.getString(GlobalConstants.statistic) ?? "";
  }

  static getAttandenceData() {
    return prefs!.getString(GlobalConstants.attendance) ?? "";
  }

  static getManagmentData() {
    return prefs!.getString(GlobalConstants.managment) ?? "";
  }

  static getProfessionalData() {
    return prefs!.getString(GlobalConstants.professional) ?? "";
  }

  static Future<void> savePlayerId(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.playerId, v);
  }

  static Future<void> saveNotificationId(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.id, v);
  }

  static Future<void> saveNotificationType(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(GlobalConstants.type, v);
  }

  static getNotificationId() {
    return prefs!.getString(GlobalConstants.id) ?? "";
  }

  static getNotificationType() {
    return prefs!.getString(GlobalConstants.type) ?? "";
  }

  static getPlayerId() {
    return prefs!.getString(GlobalConstants.playerId) ?? "";
  }
}
