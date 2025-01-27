import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';

import '../constants/globals.dart';
import '../localization.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../ui/components/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  AuthService? authService;
  final otp = ''.obs;
  final language = "".obs;
  final store = GetStorage();
  String get currentLanguage => language.value;
  final RxBool show_loading = false.obs;
  Locale? _locale;
  // AuthController({@required this.authService}) : assert(authService != null);

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final RxBool isLogin = false.obs;
  Rxn<User> loginUser = Rxn<User>();

  generateToken() async {
    showLoadingIndicator();
    String mobile = phoneController.text.trim();
    otp.value = '';
    await authService?.generateToken(mobile).then((data) {
      otp.value = data;
      //hideLoadingIndicator();
    });
  }

  loginMobile(mobile, token) {
    isLogin.value = true;
  }

  // Gets current language stored
  RxString get currentLanguageStore {
    String currentLang = "";
    if (store.read('language') == null) {
      currentLang = "en";
      updateLanguage(currentLang);
      language.value = currentLang;
    } else {}
    language.value = store.read('language');
    return language;
  }

  // gets the language locale app is set to
  Locale get getLocale {
    if ((currentLanguageStore.value == '') ||
        (currentLanguageStore.value == null)) {
      language.value = Globals.defaultLanguage;
      updateLanguage(Globals.defaultLanguage);
    }
    // gets the default language key (from the translation language system)
    Locale updatedLocal = const Locale('en', 'mm');
    if (store.read('language') != null) {
      language.value = store.read('language');
    }
    // looks for matching language key stored and sets to it
    for (var locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == currentLanguage) {
        updatedLocal = locale;
      }
    }
    return updatedLocal;
  }

  // updates the language stored
  Future<void> updateLanguage(String value) async {
    language.value = value;
    await store.write('language', value);
    Locale loc = getLocale;
    Get.updateLocale(loc);
    update();
  }

  @override
  void onReady() async {
    //run every time auth state changes
    super.onReady();
  }

  @override
  void onClose() {
    phoneController?.dispose();
    otpController?.dispose();
    super.onClose();
  }

  // Sign out
  void signOut() {
    otp.value = '';
    phoneController.clear();
    otpController.clear();
    isLogin.value = false;
    loginUser.value = null;
  }
}
