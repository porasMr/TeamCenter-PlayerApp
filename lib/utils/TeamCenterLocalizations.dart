import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class TeamCenterLocalizations {
  TeamCenterLocalizations(this.locale);

  final Locale locale;

  static TeamCenterLocalizations? of(BuildContext context) {
    return Localizations.of<TeamCenterLocalizations>(
        context, TeamCenterLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = new Map();

  Future<bool> load() async {
    String data =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> _result = jsonDecode(data);
    Map<String, String> _values = new Map();

    _result.forEach((String key, dynamic value) {
      _values[key] = value.toString();
    });
    _localizedValues[this.locale.languageCode] = _values;
    return true;
  }

  String find(String key) {
    return _localizedValues[locale.languageCode]![key] ?? '';
  }
}

class TeamCenterLocalizationsDelegate
    extends LocalizationsDelegate<TeamCenterLocalizations> {
  const TeamCenterLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'he'].contains(locale.languageCode);

  @override
  Future<TeamCenterLocalizations> load(Locale locale) async {
    TeamCenterLocalizations localizations = new TeamCenterLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(TeamCenterLocalizationsDelegate old) => false;
}
