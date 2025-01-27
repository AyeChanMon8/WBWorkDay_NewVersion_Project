

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import '../localization.dart';
import '../ui/components/textbox.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CreatePlanTrip extends StatefulWidget {
  @override
  _CreatePlanTripState createState() => _CreatePlanTripState();
}

class _CreatePlanTripState extends State<CreatePlanTrip>
    with SingleTickerProviderStateMixin {
  var box = GetStorage();
  String image = '';
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    double width = MediaQuery.of(context).size.width;
    double customWidth = width * 0.30;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(labels!.planTrip),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Get.snackbar('title', 'message');
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBox(
              textEditingController: TextEditingController(),
              hintText: 'Name',
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: TextBox(
                  textEditingController: TextEditingController(),
                  hintText: 'From Date',
                  enable: false,
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextBox(
                  textEditingController: TextEditingController(),
                  hintText: 'To Date',
                  enable: false,
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Duration(days)'),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: TextBox(
                  textEditingController: TextEditingController(),
                  hintText: 'Vehicle',
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextBox(
                  textEditingController: TextEditingController(),
                  hintText: 'Driver',
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: TextBox(
                  textEditingController: TextEditingController(),
                  hintText: 'Spare 1',
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextBox(
                  textEditingController: TextEditingController(),
                  hintText: 'Spare 2',
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: backgroundIconColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text(
                      'Route',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Expense',
                      style: TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Use Fuel',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Add Fuel',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Advance',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Allowance',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Container(
                      child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: FloatingActionButton(
                          onPressed: () {},
                          mini: true,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Route Expense',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Standard Amt',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Actual Amt',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 0, left: 0),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(
                                  'Route',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text('Standard(Liter)',
                                    style:
                                        TextStyle(color: backgroundIconColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Consumption(Liter)',
                                  style: TextStyle(
                                    color: backgroundIconColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 0, left: 0),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Date',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Shop',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Liter',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Price',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Amount',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 0, left: 0),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: FloatingActionButton(
                          onPressed: () {},
                          mini: true,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Text(
                                  'Route',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Approved Adv.',
                                  style: TextStyle(
                                    color: backgroundIconColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 0, left: 0),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: FloatingActionButton(
                          onPressed: () {},
                          mini: true,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
