

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/globals.dart';
import '../controllers/auth_controller.dart';
import '../controllers/forget_password_controller.dart';
import '../controllers/login_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginPage extends StatelessWidget {
  final AuthController controller = Get.put(
    // ignore: missing_required_param
    AuthController(),
  );
  final LoginController _loginController = Get.put(LoginController());
  ForgetPasswordController _forgetPasswordController =
      Get.put(ForgetPasswordController());
  late String barcode;
  var box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    //
    // toggle() {
    //   setState(() {
    //     _obscureText = !_obscureText;

    //   });
    // }

    _login() {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => BottomNavigationWidget()),
      // );

      // Get.toNamed(Routes.BOTTOM_NAVIGATION);
      Get.toNamed(Routes.HR_PAGE);
    }

    //Color(0xffB4804C)
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 80, left: 90, right: 90),
                child: Image.asset('assets/icon/icon.jpg'),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'WB WORK DAY',
                  style: GoogleFonts.ptSerif(
                      textStyle: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 63, 51, 128),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      controller: _loginController.emailTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (labels?.employeeID),
                      ),
                      onChanged: (text) {},
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Theme(
                      data: new ThemeData(
                        primaryColor: textFieldTapColor,
                      ),
                      child: Obx(
                        () => TextField(
                          controller: _loginController.passwordTextController,
                          obscureText: _loginController.passwordToggle.value,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon:
                                  _loginController.passwordToggle.value != false
                                      ? Icon(FontAwesomeIcons.eyeSlash)
                                      : Icon(FontAwesomeIcons.eye),
                              onPressed: () {
                                _loginController.passwordToggle.value =
                                    !_loginController.passwordToggle.value;
                              },
                            ),
                            border: OutlineInputBorder(),
                            hintText: (labels?.password),
                          ),
                        ),
                      ))),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: _loginController.rememberme.value,
                          onChanged: (value) {
                            box.write('rememberme', value);
                            _loginController.rememberme.value = value!;
                          }),
                      Text(
                        labels!.rememberMe,
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textFieldTapColor,
                  ),
                  onPressed: () {
                    box.write('emp_image',"");
                    _loginController.apiLogin();
                  },
                  child: Text(
                    (labels!.login),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: InkWell(
                        onTap: () {
                          // _forgetPasswordController.forgetPassword(barcode);
                          Get.toNamed(Routes.FORGET_PASSWORD);
                        },
                        child: Text(labels.forgotPassword,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text('Version-'+Globals.app_version,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
