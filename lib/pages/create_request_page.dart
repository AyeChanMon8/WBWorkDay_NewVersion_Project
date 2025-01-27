

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CreateRequestPage extends StatefulWidget {
  CreateRequestPage({Key? key}) : super(key: key);

  @override
  _CreateRequestPageState createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  var box = GetStorage();
  String image = '';
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(8.0),
        child: appbar(context, labels!.expense,image)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, top: 30),
              child: Text(
                // labels?.expenserequest,
                "Expense Request",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueAccent, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(labels.outOfPocket),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(child: Text(labels.type)),
                        IconButton(
                            icon: Icon(Icons.keyboard_arrow_down),
                            onPressed: () {
                              print("Out of Pocket");
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueAccent, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // padding: EdgeInsets.only(left: 10),
                    child: Text("YGN to MDY"),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(child: Text("Travel Info")),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Card(
                elevation: 2,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(labels.expense),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(child: Text(labels.expenseType)),
                                IconButton(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    onPressed: () {
                                      print("Expense Type");
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // padding: EdgeInsets.only(left: 10),
                            child: Text("2"),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(child: Text(labels.quantity)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // padding: EdgeInsets.only(left: 10),
                            child: Text("10,000 MMK"),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(child: Text(labels.unitPrice)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // padding: EdgeInsets.only(left: 10),
                            child: Text(labels.reason),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(child: Text(labels.reason)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      // margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.indigo, width: 2)),
                      child: IconButton(
                          iconSize: 30,
                          color: Colors.white,
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {

                          }),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 100,
                          height: 100,
                          child: Image.network(
                            "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 30, right: 30),
              // margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.indigo, width: 2)),
              child: IconButton(
                  iconSize: 30,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    // setState(() {
                    //   Navigator.of(context).pushNamedAndRemoveUntil(
                    //       '/request_list', ModalRoute.withName('/home'));
                    // });
                    Get.back();
                  }),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
