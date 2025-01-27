import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../models/partner.dart';
import '../my_class/my_style.dart';
// import '../localization.dart';
import 'package:graphite/core/matrix.dart';
import 'package:graphite/core/typings.dart';
import 'package:graphite/graphite.dart';
import 'package:getwidget/getwidget.dart';
import '../controllers/organization_chart_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// const employeeList =
//     '['
//     '{"id":"Zaw Aung","email":"testmail@gmail.com","next":["Kyaw Kyaw"]},'
//     '{"id":"Kyaw Kyaw","email":"aungaung@gmail.com","next":["Mg Mg","Ma Ma","Ko Ko","Aung Ko"]},'
//     '{"id":"Mg Mg","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Aung Ko","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Ma Ma","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Ko Ko","email":"aungaung@gmail.com","next":[]}'
//     ']';

// const employeeList = '['
//     '{"id":"Kyaw Zay Ya","email":"kzy@yopmail.com","next":["Hnin Nandar Linn","Myo Mg Mg Wan","Sitt Oo","Su Win Nwe","Wai Wai Mon"]},'
//     '{"id":"Hnin Nandar Linn","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Myo Mg Mg Wan","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Sitt Oo","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Su Win Nwe","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Wai Wai Mon","email":"aungaung@gmail.com","next":[]}'
//     ']';

// const test = '['
//     '{"id":"Administrator","email":"","next":["Kyaw Zay Ya"]},'
//     '{"id":"Kyaw Zay Ya","email":"kzy@yopmail.com","next":["Hnin Nandar Linn","Myo Mg Mg Wan","Sitt Oo","Su Win Nwe","Wai Wai Mon"]},'
//     '{"id":"Hnin Nandar Linn","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Myo Mg Mg Wan","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Sitt Oo","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Su Win Nwe","email":"aungaung@gmail.com","next":[]},'
//     '{"id":"Wai Wai Mon","email":"aungaung@gmail.com","next":[]}'
//     ']';

class OrganizationChart extends StatelessWidget {
  OrganizationalChartController controller =
      Get.put(OrganizationalChartController());
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    // print(employeeList);
    /* String json = box.read("org_json");
    print("json##");
    print(json.toString());
    List<NodeInput> list = nodeInputFromJson(json.toString());
    var admin = list[0].id.split("#image")[0];*/
    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.organizationChart,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              controller
                  .getEmployeeInfo(
                      controller.empData.value.parent_id!.id.toString())
                  .then((value) => showBarModalBottomSheet(
                      expand: true,
                      context: context,
                      builder: (context) => Container(
                            color: Color(0xff757575),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(241, 249, 255, 1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0))),
                              child: Container(
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        child: value!.image_128 == null
                                            ? Image.memory(
                                                base64Decode(
                                                    "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"),
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : Image.memory(
                                                base64Decode(value.image_128),
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fitWidth,
                                              ),
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                      value.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: backgroundIconColor,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Divider(
                                      height: 1,
                                    ),
                                    Center(
                                        child: Text(
                                      value.job_id!.name,
                                      style: datalistStyle(),
                                    )),
                                    Divider(
                                      height: 1,
                                    ),
                                    Center(
                                        child: Text(
                                      value.company_id!.name,
                                      style: datalistStyle(),
                                    )),
                                    Divider(
                                      height: 1,
                                    ),
                                    Center(
                                        child: Text(
                                      value.department_id!.name,
                                      style: datalistStyle(),
                                    )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Work Mobile',
                                      style: datalistStyle(),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          value.mobile_phone,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: backgroundIconColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Work Email',
                                      style: datalistStyle(),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          value.work_email,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: backgroundIconColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Work Location',
                                      style: datalistStyle(),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          value.work_location,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: backgroundIconColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Employee counts',
                                      style: datalistStyle(),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          value.child_ids!.length.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: backgroundIconColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Obx(() => Row(
                    children: [
                      controller.empData.value.parent_id == null ||
                              controller.empData.value.parent_id!.name == null
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(right: 5),
                              child: CircleAvatar(
                                backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                                child: ClipRRect(
                                  child: Image.memory(
                                    base64Decode(
                                        "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"),
                                    fit: BoxFit.fitWidth,
                                    width: 20,
                                    height: 20,
                                  ),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                      controller.empData.value.parent_id == null ||
                              controller.empData.value.parent_id!.name == null
                          ? SizedBox()
                          : Text(controller.empData.value.parent_id!.name),
                    ],
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              controller
                  .getEmployeeInfo(controller.empData.value.id.toString())
                  .then((value) => showBarModalBottomSheet(
                      expand: false,
                      context: context,
                      builder: (context) => Container(
                            color: Color(0xff757575),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(241, 249, 255, 1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0))),
                              child: Container(
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        child: value!.image_128 == null
                                            ? Image.memory(
                                                base64Decode(
                                                    "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"),
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : Image.memory(
                                                base64Decode(value.image_128),
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fitWidth,
                                              ),
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                      value.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: backgroundIconColor,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Divider(
                                      height: 1,
                                    ),
                                    Center(
                                        child: Text(
                                      value.job_id!.name,
                                      style: datalistStyle(),
                                    )),
                                    Divider(
                                      height: 1,
                                    ),
                                    Center(
                                        child: Text(
                                      value.company_id!.name,
                                      style: datalistStyle(),
                                    )),
                                    Divider(
                                      height: 1,
                                    ),
                                    Center(
                                        child: Text(
                                      value.department_id!.name,
                                      style: datalistStyle(),
                                    )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Work Mobile',
                                      style: datalistStyle(),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          value.mobile_phone,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: backgroundIconColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Work Email',
                                      style: datalistStyle(),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          value.work_email,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: backgroundIconColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Work Location',
                                      style: datalistStyle(),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          value.work_location,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: backgroundIconColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Employee counts',
                                      style: datalistStyle(),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          value.child_ids!.length.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: backgroundIconColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )));
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Obx(() => IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        controller.empData.value.parent_id == null ||
                                controller.empData.value.parent_id!.name == null
                            ? SizedBox()
                            : VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                                width: 1,
                              ),
                        controller.empData.value.parent_id == null ||
                                controller.empData.value.parent_id!.name == null
                            ? SizedBox()
                            : Text('___'),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: ClipRRect(
                              child: controller.empData.value.image_128 != null && controller.empData.value.image_128 != ""
                                  ? new Image.memory(
                                      base64Decode(
                                          controller.empData.value.image_128),
                                      fit: BoxFit.fitWidth,
                                      width: 20,
                                      height: 20,
                                    )
                                  : new Container(),
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        controller.empData.value.name == null
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 20.0),
                                child: Column(
                                  children: [
                                    Text(controller.empData.value.name),
                                    Text(controller.empData.value.department_id
                                            ?.name ??
                                        ''),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  )),
            ),
          ),
          Container(
            height: Get.height - 100,
            padding: EdgeInsets.only(left: 70, bottom: 100),
            child: Obx(() => ListView.builder(
                itemCount: controller.empData.value.child_ids == null
                    ? 0
                    : controller.empData.value.child_ids!.length,
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        controller
                            .getEmployeeInfo(controller
                                .empData.value.child_ids![index].id
                                .toString())
                            .then((value) => showBarModalBottomSheet(
                                  expand: true,
                                  context: context,
                                  builder: (context) => Container(
                                    color: Color(0xff757575),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(241, 249, 255, 1),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0))),
                                      child: Container(
                                        margin: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                child: value!.image_128 == null
                                                    ? Image.memory(
                                                        base64Decode(
                                                            "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"),
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fitWidth,
                                                      )
                                                    : Image.memory(
                                                        base64Decode(
                                                            value.image_128),
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                              ),
                                            ),
                                            Center(
                                                child: Text(
                                              value!.name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: backgroundIconColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Divider(
                                              height: 1,
                                            ),
                                            Center(
                                                child: Text(
                                              value!.job_id!.name,
                                              style: datalistStyle(),
                                            )),
                                            Divider(
                                              height: 1,
                                            ),
                                            Center(
                                                child: Text(
                                              value.company_id!.name,
                                              style: datalistStyle(),
                                            )),
                                            Divider(
                                              height: 1,
                                            ),
                                            Center(
                                                child: Text(
                                              value.department_id!.name ?? '',
                                              style: datalistStyle(),
                                            )),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              'Work Mobile',
                                              style: datalistStyle(),
                                            ),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Text(
                                                  value.mobile_phone,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          backgroundIconColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Work Email',
                                              style: datalistStyle(),
                                            ),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Text(
                                                  value.work_email,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          backgroundIconColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Work Location',
                                              style: datalistStyle(),
                                            ),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Text(
                                                  value.work_location,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          backgroundIconColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Employee counts',
                                              style: datalistStyle(),
                                            ),
                                            Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Text(
                                                  value.child_ids!.length
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          backgroundIconColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                  width: 1,
                                ),
                                Text('____'),
                                Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: ClipRRect(
                                      child: Image.memory(
                                        base64Decode(
                                            "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"),
                                        fit: BoxFit.fitWidth,
                                        width: 20,
                                        height: 20,
                                      ),
                                      borderRadius:
                                          new BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${controller.empData.value.child_ids![index].name}'),
                                      Text(
                                          '${controller.empData.value.child_ids![index].work_email}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}

class CustomPage extends StatefulWidget {
  CustomPage({Key? key}) : super(key: key);

  @override
  _CustomPageState createState() {
    return _CustomPageState();
  }
}

class _CustomPageState extends State<CustomPage> {
  var box = GetStorage();
  int _selectedIndex = 1;
  Map<String, bool> selected = {};

  void _onItemSelected(String? nodeId) {
    setState(() {
      selected[nodeId!] =
          selected[nodeId] == null || !selected[nodeId]! ? true : false;
    });
  }

  Widget? adminBox(BuildContext context, String emp_image, String emp_name) {
    Container(
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
            width: 10.0,
          ),
          // GFAvatar(
          //     backgroundImage: NetworkImage(
          //         'https://images.unsplash.com/photo-1599667228840-48e3d43d4e03?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80'),
          //     shape: GFAvatarShape.circle),
          Container(
            padding: EdgeInsets.only(right: 5),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(216, 181, 0, 1),
              child: ClipRRect(
                child: emp_image != null && emp_image != ""
                    ? new Image.memory(
                        base64Decode(emp_image),
                        fit: BoxFit.fitWidth,
                        width: 50,
                        height: 50,
                      )
                    : new Container(),
                borderRadius: new BorderRadius.circular(50.0),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
            width: 10.0,
          ),
          // if (emp_name == admin)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                emp_name,
                style: TextStyle(fontSize: 10.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Employee",
                style: TextStyle(fontSize: 8.0),
              ),
            ],
          ),

          //Text(emp_email==null?"-":emp_email),

          // Text(
          //   controller.empData.value.work_email,
          // ),
        ],
      ),
    );
  }

  Widget? employeeBox(BuildContext context, String emp_image, String emp_name) {
    Container(
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
            width: 10.0,
          ),
          // GFAvatar(
          //     backgroundImage: NetworkImage(
          //         'https://images.unsplash.com/photo-1599667228840-48e3d43d4e03?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80'),
          //     shape: GFAvatarShape.circle),
          Container(
            padding: EdgeInsets.only(right: 5),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(216, 181, 0, 1),
              child: ClipRRect(
                child: emp_image != null && emp_image != ""
                    ? new Image.memory(
                        base64Decode(emp_image),
                        fit: BoxFit.fitWidth,
                        width: 50,
                        height: 50,
                      )
                    : new Container(),
                borderRadius: new BorderRadius.circular(50.0),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
            width: 10.0,
          ),
          // if (emp_name == admin)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                emp_name,
                style: TextStyle(fontSize: 10.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Employee",
                style: TextStyle(fontSize: 8.0),
              ),
            ],
          ),

          //Text(emp_email==null?"-":emp_email),

          // Text(
          //   controller.empData.value.work_email,
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String jsonString = box.read("org_json");
    // print(json.toString());
    // List<NodeInput>.from(json.decode(str).map((x) => NodeInput.fromJson(x)));
    /* Partner partner= Partner.fromMap(json.decode(box.read('parent')));
    print(partner.name);*/
    List<NodeInput> list = nodeInputFromJson(jsonString.toString());
    // print("list##");
    // print(list[1].id.split("#")[0]);
    // print("test out superviser");
    // print(list[0].id.split("#")[0]);
    var admin = list[0].id.split("#image")[0];
    list.forEach((element) {
      print(element.id);
      print(element.next);
    });

    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: DirectGraph(
        list: list,
        cellWidth: 180.0,
        // cellHeigh: ,
        cellPadding: 20,
        contactEdgesDistance: 0.0,
        pathBuilder: customEdgePathBuilder,
        orientation: MatrixOrientation.Vertical,
        builder: (ctx, node) {
          print("NODEVALUE");
          print(node.toJson());
          //var emp_email = node.id.split("emp_email")[1];
          var emp_name = node.id.split("#image")[0];
          var emp_image;
          if (node.id.split("#image")[1].isEmpty ||
              node.id.split("#image")[1] == null) {
            print("imageNull");
            emp_image = null;
          } else {
            print("imageNotNull");
            emp_image = node.id.split("#image")[1];
          }

          if (emp_name == admin) {
            print("admin");
          }
          //var emp_email = node.id.split("emp_email")[1];
          // print(node.email);
          return Container(
            color: Colors.transparent,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              crossAxisAlignment: emp_name == admin
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.0,
                  width: 10.0,
                ),
                // GFAvatar(
                //     backgroundImage: NetworkImage(
                //         'https://images.unsplash.com/photo-1599667228840-48e3d43d4e03?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80'),
                //     shape: GFAvatarShape.circle),
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                    child: ClipRRect(
                      child: emp_image != null && emp_image != ""
                          ? new Image.memory(
                              base64Decode(emp_image),
                              fit: BoxFit.fitWidth,
                              width: 20,
                              height: 20,
                            )
                          : new Container(),
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                  width: 0.0,
                ),
                // if (emp_name == admin)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      emp_name,
                      style: TextStyle(fontSize: 10.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Employee",
                      style: TextStyle(fontSize: 8.0),
                    ),
                  ],
                ),

                //Text(emp_email==null?"-":emp_email),

                // Text(
                //   controller.empData.value.work_email,
                // ),
              ],
            ),
          );
        },
        // Diagram connecter design
        paintBuilder: (edge) {
          var p = Paint()
            ..color = Colors.blueGrey
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.square
            ..strokeJoin = StrokeJoin.miter
            ..strokeWidth = 2;
          if ((selected[edge.from.id] ?? false) &&
              (selected[edge.to.id] ?? false)) {
            p.color = Colors.red;
          }
          return p;
        },
        onNodeTapDown: (_, node) {
          _onItemSelected(node.id);
        },
      ),
    );
  }
}

Path customEdgePathBuilder(List<List<double>> points) {
  var path = Path();
  path.moveTo(points[0][0], points[0][1]);
  points.sublist(1).forEach((p) {
    path.lineTo(p[0], p[1]);
  });
  return path;
}
