

import 'package:flutter/material.dart';
// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_class/my_style.dart';

class ExpenseOpenReport extends StatefulWidget {
  @override
  _ExpenseOpenReportState createState() => _ExpenseOpenReportState();
}

class _ExpenseOpenReportState extends State<ExpenseOpenReport> {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        labels!.reports,
                        // "Reports",
                        style: maintitleStyle(),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            labels.sortBy,
                            // "Sort By",
                            style: maintitleStyle(),
                          ),
                          IconButton(
                            icon: Icon(Icons.sort),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
              height: 0,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Trip to NPT for president prize"),
                            Text("350000 Ks")
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("09/09/2020 - 11/09/2020"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Reimbursed"),
                                Icon(Icons.check),
                              ],
                            )
                          ],
                        ),
                        trailing: arrowforwardIcon,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
