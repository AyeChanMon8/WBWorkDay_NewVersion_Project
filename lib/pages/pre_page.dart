
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../pages/bottom_navigation.dart';
import '../pages/business_travel_list.dart';
import '../pages/login_page.dart';
import '../pages/network_util.dart';
import '../pages/request_list.dart';
import '../tools/internet_provider.dart';
import '../tools/theme_bloc.dart';
import '../tools/theme_provider.dart';

class PrePage extends StatefulWidget {
  @override
  _PrePageState createState() => _PrePageState();
}

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

class _PrePageState extends State<PrePage> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = new Connectivity();

  bool internetConnected = false;
  Future<void> initConnectivity() async {
    ConnectivityResult connectionStatus;
    try {
      connectionStatus = await _connectivity.checkConnectivity();
      if (connectionStatus == ConnectivityResult.none) {
        setState(() {
          internetConnected = false;
        });
      } else {
        var result = await NetworkUtil.PingSuccessed();
        if (result) {
          setState(() {
            internetConnected = true;
          });
        } else {
          setState(() {
            internetConnected = false;
          });
        }
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();

    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        setState(() {
          internetConnected = false;
        });
      } else {
        var result = await NetworkUtil.PingSuccessed();
        if (result) {
          setState(() {
            internetConnected = true;
          });
        } else {
          setState(() {
            internetConnected = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: InternetProvider(
        // child: MyApp(),
        internet: internetConnected,
      ),
      nightMode: ThemeBloc(),
    );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // AppTranslationsDelegate _newLocaleDelegate;

//   @override
//   void initState() {
//     super.initState();
//     // _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
//     // application.onLocaleChanged = onLocaleChange;
//   }

//   @override
//   Widget build(BuildContext context) {
//   /*  var provider = ThemeProvider.of(context);
//     provider.nightMode.listenDarkMode();

//     return StreamBuilder(
//         stream: provider.nightMode.nightModeStream,
//         builder: (context, snapshot) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             supportedLocales: [
//               const Locale('en', 'US'),
//               const Locale('mm', 'MM')
//             ],
//             localizationsDelegates: [
//               // _newLocaleDelegate,
//               // const AppTranslationsDelegate(),
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//             ],
//             home: LoginPage(),
//             routes: <String, WidgetBuilder>{
//               '/home': (BuildContext context) => LoginPage(),
//               '/bottomNavigation': (BuildContext context) =>
//                   BottomNavigationWidget(),
//               '/request_list': (BuildContext context) => RequestListPage(),
//               './business_travel_list': (BuildContext context) =>
//                   BusinessTravelList(),
//             },
//             theme: snapshot.data == null || snapshot.data == "off"
//                 ? firstTD()
//                 : secondTD(),
//           );
//         });*/
//   }

//   void onLocaleChange(Locale locale) {
//     setState(() {
//       // _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
//     });
//   }

//   ThemeData firstTD() => ThemeData(
//         fontFamily: 'Roboto',
//         primarySwatch: white,
//         brightness: Brightness.light,
//       );
//   ThemeData secondTD() => ThemeData(
//       fontFamily: 'Roboto', primarySwatch: white, brightness: Brightness.dark);
// }
