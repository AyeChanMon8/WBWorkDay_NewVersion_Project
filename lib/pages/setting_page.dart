

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import '../pages/drawer.dart';
import '../pages/change_password_page.dart';
import '../routes/app_pages.dart';
import '../shared_pref.dart';
import '../tools/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}
 
class _SettingPageState extends State<SettingPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool bswitch = false;
  final box = GetStorage();
  List hr = [];
  final labels = AppLocalizations.of(Get.context!);
  @override
  void initState() {
    super.initState();
    _checkTheme();
    final reward = box.read("allow_reward");
    final warning = box.read("allow_warning");
    final payslip = box.read("allow_payslip");
    final loan = box.read("allow_loan");
    final insurance = box.read("allow_insurance");
      hr.add(
        [Icons.person, labels?.profile, Routes.PROFILE_PAGE]);
    hr.add(
        [Icons.security, labels?.changePassword, Routes.CHANGE_PASSWORD]);
    if (payslip != null) {
      hr.add([
        FontAwesomeIcons.moneyCheckAlt,
        labels?.paySlip,
        Routes.PAY_SLIP_PAGE
      ]);
    }
    if (loan != null) {
      hr.add(
          [FontAwesomeIcons.handHoldingUsd, labels?.loan, Routes.LOAN_PAGE]);
    }
    if (insurance != null) {
      hr.add([FontAwesomeIcons.shieldAlt, labels?.insurance, Routes.INSURANCE]);
    }

    if (reward != null) {
      hr.add([FontAwesomeIcons.award, labels?.rewards, Routes.REWARD_PAGE]);
    }
    if (warning != null) {
      hr.add(
          [FontAwesomeIcons.exclamationTriangle, labels?.warning, Routes.WARNING_PAGE]);
    }
    hr.add(
        [FontAwesomeIcons.folderOpen, labels?.employeeDocument, Routes.EMPLOYEE_DOCEMENT_PAGE]);
  }

  void changePassword() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ChangePasswordPage()),
    // );
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }

  void _checkTheme() async {
    await SharedPref.getData(key: SharedPref.isNightMode).then((str) {
      if (str == "on") {
        setState(() {
          bswitch = true;
        });
      } else {
        setState(() {
          bswitch = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: backgroundIconColor,
          elevation: 1,
          title: Text(
            labels!.more,
             style: appBarTextStyle(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(8.0),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color.fromRGBO(216, 181, 0, 1),
                    const Color.fromRGBO(231, 235, 235, 1)
                  ],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed(Routes.LANGUAGE_PAGE);
              },
            )
          ],
        ),
        drawer: DrawerPage(),
        body: Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child:GridView.builder(
            // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 3,
              ),
              itemCount: hr.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: backgroundIconColor,
                        child: IconButton(
                          iconSize: 30,
                          padding: EdgeInsets.zero,
                          icon: Icon(hr[index][0]),
                          color: barBackgroundColorStyle,
                          onPressed: () {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (BuildContext context) {
                            //   return LeaveTripReport();
                            // }));

                            Get.toNamed(hr[index][2]);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            (hr[index][1]),
                            style: menuTextStyle(),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
        ));
    //   body: ListView(
    //     children: <Widget>[
    //       Divider(),
    //       ListTile(
    //         leading: Icon(
    //           Icons.fingerprint,
    //           color: Color.fromRGBO(60, 47, 126, 1),
    //         ),
    //         title: Text(
    //           MyTheme.mmText(AppTranslations.of(context).trans("attendance")),
    //         ),
    //         trailing: Icon(
    //           Icons.arrow_forward_ios,
    //           color: Color.fromRGBO(60, 47, 126, 1),
    //         ),
    //       ),
    //       Divider(),
    //       ListTile(
    //         leading: Icon(
    //           FontAwesomeIcons.calendarCheck,
    //           color: Color.fromRGBO(60, 47, 126, 1),
    //         ),
    //         title: Text(MyTheme.mmText(
    //             AppTranslations.of(context).trans("attendance_record"))),
    //         trailing: Icon(
    //           Icons.arrow_forward_ios,
    //           color: Color.fromRGBO(60, 47, 126, 1),
    //         ),
    //       ),
    //       Divider(),
    //       ListTile(
    //         leading: Icon(
    //           Icons.check,
    //           color: Color.fromRGBO(60, 47, 126, 1),
    //         ),
    //         title: Text(MyTheme.mmText(
    //             AppTranslations.of(context).trans("approve_request"))),
    //         trailing: Icon(Icons.arrow_forward_ios,
    //             color: Color.fromRGBO(60, 47, 126, 1)),
    //       ),
    //       Divider(),
    //       ListTile(
    //         leading: Icon(Icons.people, color: Color.fromRGBO(60, 47, 126, 1)),
    //         title: Text(MyTheme.mmText(
    //             AppTranslations.of(context).trans("organization_charts"))),
    //         trailing: Icon(Icons.arrow_forward_ios,
    //             color: Color.fromRGBO(60, 47, 126, 1)),
    //       ),
    //       Divider(),
    //       InkWell(
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => OverTimePage()),
    //           );
    //         },
    //         child: ListTile(
    //           leading: Icon(Icons.watch_later,
    //               color: Color.fromRGBO(60, 47, 126, 1)),
    //           title: Text(MyTheme.mmText(
    //               AppTranslations.of(context).trans("over_time"))),
    //           trailing: Icon(Icons.arrow_forward_ios,
    //               color: Color.fromRGBO(60, 47, 126, 1)),
    //         ),
    //       ),
    //       Divider(),
    //       InkWell(
    //         onTap: () {
    //           Navigator.of(context)
    //               .push(MaterialPageRoute(builder: (BuildContext context) {
    //             return TripPage();
    //           }));
    //         },
    //         child: ListTile(
    //           leading: Icon(Icons.map, color: Color.fromRGBO(60, 47, 126, 1)),
    //           title: Text(
    //               MyTheme.mmText(AppTranslations.of(context).trans("trips"))),
    //           trailing: Icon(Icons.arrow_forward_ios,
    //               color: Color.fromRGBO(60, 47, 126, 1)),
    //         ),
    //       ),
    //       Divider(),
    //       ListTile(
    //         leading: Icon(Icons.settings_applications,
    //             color: Color.fromRGBO(60, 47, 126, 1)),
    //         title: Text(MyTheme.mmText(
    //             AppTranslations.of(context).trans("maintain_repair"))),
    //         trailing: Icon(Icons.arrow_forward_ios,
    //             color: Color.fromRGBO(60, 47, 126, 1)),
    //       ),
    //       Divider(),
    //       ListTile(
    //         leading:
    //             Icon(Icons.first_page, color: Color.fromRGBO(60, 47, 126, 1)),
    //         title: Text(
    //             MyTheme.mmText(AppTranslations.of(context).trans("document"))),
    //         trailing: Icon(Icons.arrow_forward_ios,
    //             color: Color.fromRGBO(60, 47, 126, 1)),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
