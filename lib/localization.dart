

// import 'package:flutter/widgets.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

// part 'localization.g.dart';

// @SheetLocalization("1N30fIqCDKUuGEB-IeM6htO7nrd98Z-IIMd0T9fs1jAg", "1",1) // <- See 1. to get DOCID and SHEETID
// // the `1` is the generated version. You must increment it each time you want to regenerate
// // a new version of the labels.
// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) =>
//       AppLocalizations.languages.containsKey(locale);
//   @override
//   Future<AppLocalizations> load(Locale locale) =>
//       SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
//   @override
//   bool shouldReload(AppLocalizationsDelegate old) => false;
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AppLocalizations {
//   final Locale locale;

//   AppLocalizations(this.locale);

//   static AppLocalizations? of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations);
//   }

//   static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

//   Map<String, String>? _localizedStrings;

//   Future<bool> load() async {
//     String jsonString = await rootBundle.loadString('assets/languages/${locale.languageCode}.json');
//     Map<String, dynamic> jsonMap = json.decode(jsonString);

//     _localizedStrings = jsonMap.map((key, value) {
//       return MapEntry(key, value.toString());
//     });

//     return true;
//   }

//   String translate(String key) {
//     return _localizedStrings![key] ?? key;
//   }
// }

// class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const _AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'es'].contains(locale.languageCode);
//   }

//   @override
//   Future<AppLocalizations> load(Locale locale) async {
//     AppLocalizations localizations = new AppLocalizations(locale);
//     await localizations.load();
//     return localizations;
//   }

//   @override
//   bool shouldReload(_AppLocalizationsDelegate old) => false;
// }
