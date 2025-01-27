import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../constants/globals.dart';
import '../controllers/user_profile_controller.dart';
// import '../localization.dart';
import '../routes/app_pages.dart';
import 'login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerPage extends StatelessWidget {
  final UserProfileController _userProfileController =
      Get.put(UserProfileController());
  bool checkcondition = true;
  List listdata = [];
  String name = '';
  String phone = '';
  var changePassswrod = "";
  var logout = "";
  var language = "";
  var setting = "";
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    changePassswrod = labels!.changePassword;
    logout = labels.logout;
    language = labels.language;
    setting = labels.setting;
    return Drawer(child: getNavDrawer(context));
  }

  Drawer getNavDrawer(BuildContext context) {
    Uint8List bytes =
        base64Decode(_userProfileController.empData.value.image_128);

    var headerChild = UserAccountsDrawerHeader(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      accountName: Text(
        '${_userProfileController.empData.value.name}',
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
      accountEmail: Text(
        _userProfileController.empData.value.mobile_phone == null
            ? ''
            : _userProfileController.empData.value.mobile_phone,
        style: TextStyle(color: Colors.black),
      ),
      currentAccountPicture: CircleAvatar(
        minRadius: 50,
        maxRadius: 75,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: bytes.isEmpty
              ? Image.asset("assets/images/person.jpeg")
              : Image.memory(
                  bytes,
                  fit: BoxFit.cover,
                  scale: 0.1,
                  height: 100,
                  width: 100,
                ),
        ),
        backgroundColor: Colors.blue[100],
      ),
    );
    /* var aboutChild = AboutListTile(
        child: Text("About"),
        applicationName: "Win Brother HR",
        applicationVersion: "v1.0.0",
        icon: Icon(
          Icons.info,
          color: Color.fromRGBO(216, 181, 0, 1),
        ));*/

    var myNavChildren = [
      headerChild,
      // Divider(
      //   color: Color.fromRGBO(216, 181, 0, 1),
      // ),
      /*ListTile(
        leading: Icon(
          FontAwesomeIcons.fingerprint,
          color: Color.fromRGBO(216, 181, 0, 1),
        ),
        title: Text("Attandance"),
        onTap: () {
          Get.back();
          Get.toNamed(Routes.ATTENDANCE);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.format_list_numbered,
          color: Color.fromRGBO(216, 181, 0, 1),
        ),
        title: Text("Attandance Report"),
        onTap: () {
          Get.back();
          Get.toNamed(Routes.ATTENDANCE_REPORT);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.attach_money,
          color: Color.fromRGBO(216, 181, 0, 1),
        ),
        title: Text("Pay-slip"),
        onTap: () {
          Get.back();
          Get.toNamed(Routes.PAY_SLIP_PAGE);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.account_tree_outlined,
          color: Color.fromRGBO(216, 181, 0, 1),
        ),
        title: Text("Organization chart"),
        onTap: () {
          Get.back();
          Get.toNamed(Routes.ORGANIZATION_CHART);
        },
      ),*/
      ListTile(
        leading: Icon(
          Icons.language_sharp,
          color: Color.fromRGBO(216, 181, 0, 1),
        ),
        title: Text(language),
        onTap: () {
          Get.back();
          Get.toNamed(Routes.LANGUAGE_PAGE);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.settings,
          color: Color.fromRGBO(216, 181, 0, 1),
        ),
        title: Text(setting),
        onTap: () {
          Get.back();
          Get.toNamed(Routes.CONFIGURATION_PAGE);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.lock_open,
          color: Color.fromRGBO(216, 181, 0, 1),
        ),
        title: Text(changePassswrod),
        onTap: () {
          Get.back();
          Get.toNamed(Routes.CHANGE_PASSWORD);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.power_settings_new,
          color: Colors.red,
        ),
        title: Text(logout),
        onTap: () {
          LogoutAlert(context);
        },
      ),
      ListTile(
        title: Text("Version " + Globals.app_version),
      ),
      // aboutChild,
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

  void LogoutAlert(BuildContext context) {
    final box = GetStorage();
    final labels = AppLocalizations.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              title: Text(labels!.logout,
                  style: TextStyle(color: Colors.redAccent)),
              content: Text(labels.areYousurewanttoLogout),
              actions: <Widget>[
                TextButton(
                  child:
                      Text(labels.no, style: TextStyle(color: Colors.blueGrey)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(labels.yes, style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    box.write('emp_image', "");
                    box.write('login_employee_id', "");
                    OneSignal.shared.removeExternalUserId();
                    Get.offAllNamed(Routes.LOGIN);
                    //Get.offAll(LoginPage());
                    // Navigator.of(context).pop();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => Logout()));
                  },
                ),
              ],
            ));
  }
}
