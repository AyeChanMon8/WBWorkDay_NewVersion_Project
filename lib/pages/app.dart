import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../bindings/home_binding.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_pages.dart';
import '../theme/app_theme.dart';
import '../ui/components/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  final box = GetStorage();
  Locale _locale = Locale('en');

  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    Get.put<AuthController>(AuthController());
    // var supportLocales = AppLocalizations.languages.keys.toList();
    return GetBuilder<AuthController>(
        builder: (controller) => Loading(
              child: GetMaterialApp(
                enableLog: true,
                locale: controller.getLocale,
                // locale: controller._locale, // Default locale

                defaultTransition: Transition.fade,
                localizationsDelegates:AppLocalizations.localizationsDelegates,
               //  supportedLocales: AppLocalizations.supportedLocales,
                // locale: _locale,
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('my', ''),
                ],
                // supportedLocales: [
                //   Locale('en', ''), // English
                //   Locale('my', ''), // Spanish
                // ],
                debugShowCheckedModeBanner: false,
                initialBinding: HomeBinding(),
                initialRoute: '/',
                theme: appThemeData,
                getPages: AppPages.pages,
                // home: LeaveTripTabBar(),
                //home: LoginPage(),
                // home: controller.isLogin ? SignUpPage() : LoginPage(),
              
              ),
            ));

    // return GetMaterialApp(
    //   locale: AppLocalizations.languages.keys.first,
    //   localizationsDelegates: [
    //     const AppLocalizationsDelegate(), // <- Your custom delegate
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //   ],
    //   debugShowCheckedModeBanner: false,
    //   initialBinding: HomeBinding(),
    //   initialRoute: '/',
    //   home: LoginPage(),
    //   theme: appThemeData,
    //   defaultTransition: Transition.fade,
    //   getPages: AppPages.pages,
    //   //home: LoginPage(),
    //   // home: Language(),
    //   // supportedLocales: [const Locale('en', 'US'), const Locale('mm', 'MM')],

    //   supportedLocales: AppLocalizations.languages.keys.toList(),
    //   // supportedLocales:
    //   //     AppLocalizations.languages.keys.where((locale) => false),
    // );
  }
}
