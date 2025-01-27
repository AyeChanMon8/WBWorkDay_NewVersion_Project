

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/button/gf_button.dart';
import '../controllers/configuration_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

import '../localization.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  ConfigurationController controller = Get.put(ConfigurationController());
  List homepage = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, 'Settings', '')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Hr',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  decoration: TextDecoration.underline),
            ),
            Container(
             padding: EdgeInsets.symmetric(vertical: 20),
              child: GridView.builder(
                  itemCount: controller.hr.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      onChanged: (value) {
                        setState(() {
                          controller.hr[index][3] = value;
                          if (value!) {
                              controller.home.add(controller.hr[index]);
                          } else {
                            controller.home.removeWhere((element) =>
                                element[1] == controller.hr[index][1]);
                          }
                        });
                      },
                      value: controller.hr[index][3],
                      title: Text(
                        controller.hr[index][1],
                        style: TextStyle(color: backgroundIconColor),
                      ),
                    );
                  }),
            ),
            Text(
              'Admin',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                  decoration: TextDecoration.underline),
            ),
            Container(
              child: GridView.builder(
                  itemCount: controller.admin.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      value: controller.admin[index][3],
                      onChanged: (value) {
                        setState(() {
                          controller.admin[index][3] = value;
                          if (value!) {
                            controller.home.forEach((element) {
                              print(element);
                            });
                              controller.home.add(controller.admin[index]);
                          } else {
                            controller.home.removeWhere((element) =>
                                element[1] == controller.admin[index][1]);
                          }
                        });
                      },
                      title: Text(
                        controller.admin[index][1],
                        style: TextStyle(color: backgroundIconColor),
                      ),
                    );
                  }),
            ),
            GFButton(
              onPressed: () {
                controller.saveData();
              },
              text: 'Save',
              color: backgroundIconColor,
              hoverColor: Colors.white,
            ),
          ],
        ),
      ),
    ));
  }
}
