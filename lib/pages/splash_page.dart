import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/login_controller.dart';
import '../controllers/splash_controller.dart';
import '../controllers/user_profile_controller.dart';
import '../routes/app_pages.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController controller = Get.put(SplashController());

  var box = GetStorage();
  static const alignment = [
    AlignmentDirectional.bottomCenter,
    AlignmentDirectional.center,
  ];
  int index = 0;
  double width = 100;
  @override
  void initState() {
    Timer(Duration(seconds: 1), (){
      setState(() {
        index = 1;
        width = 200;
      });
    });
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitCircle(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    Future.delayed(Duration(seconds: 4),(){
      var remember = box.read('rememberme')??false;
      if(remember)
        controller.apiForRememberLogin();
      else
        Get.offAllNamed(Routes.LOGIN);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image(
            image: AssetImage('assets/icon/icon.jpg'),
          ),
        ),
      ),
    );
  }
}
