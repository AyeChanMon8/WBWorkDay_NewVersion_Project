

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import '../models/claiminsurancemodel.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/pdf_view.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ClaimInsuranceDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Claiminsurancemodel insurance = Get.arguments;
    final labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, 'Claim Insurance Detail', '')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //   AutoSizeText(labels?.insuranceType,style: detailsStyle()),
              //   AutoSizeText(' : ${insurance.insuranceTypeId.policyType}',style: maintitleStyle()),
              // ],),
              // SizedBox(height: 10,),
              // insurance.insurance_ids.length > 0 ?Row(children: [
              //   AutoSizeText('Insurance Reference',style: detailsStyle()),
              //   AutoSizeText(' : ${insurance.insurance_ids[0].name}',style: maintitleStyle()),
              // ],):SizedBox(),
              // SizedBox(height: 10,),
              // Row(children: [
              //   AutoSizeText(labels?.employeeName,style: detailsStyle()),
              //   AutoSizeText(' : ${insurance.employeeId.name}',style: maintitleStyle()),
              // ],),
              // SizedBox(height: 10,),
              // Row(children: [
              //   AutoSizeText('Date',style: detailsStyle()),
              //   AutoSizeText(' : ${AppUtils.changeDateFormat(insurance.date)}',style: maintitleStyle()),
              // ],),
              // SizedBox(height: 10,),
              // Row(children: [
              //   AutoSizeText('Field Description',style: detailsStyle()),
              //   AutoSizeText(' : ${AppUtils.removeNullString(insurance.description)}',style: maintitleStyle()),
              // ],),
              // SizedBox(height: 10,),
              // Row(children: [
              //   AutoSizeText('Coverage Amount',style: detailsStyle()),
              //   AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.coverageAmount.toString()))}',style: maintitleStyle()),
              // ],),
              // SizedBox(height: 10,),
              // Row(children: [
              //   AutoSizeText('Claim Amount',style: detailsStyle()),
              //   AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.claimAmount.toString()))}',style: maintitleStyle()),
              // ],),
              // SizedBox(height: 10,),
              // Row(children: [
              //   AutoSizeText('Balance Amount',style: detailsStyle()),
              //   AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.balance.toString()))}',style: maintitleStyle()),
              // ],),
              // SizedBox(height: 10,),
              // Row(children: [
              //   Text(
              //     '${labels?.attachment} : ',
              //     style: detailsStyle(),
              //   ),
              //   InkWell(
              //     onTap: () async{
              //       File file = await AppUtils.createPDF(insurance.attachmentId, "attachmentId.png","application/png");
              //       if (AppUtils.isImage(file.path)) {
              //         Get.dialog(Stack(
              //           children: [
              //             Center(child: Image.file(file)),
              //             Positioned(right : 0,child: FlatButton(onPressed: (){Get.back();}, child: Text('Close',style:TextStyle(color: Colors.white,fontSize: 20) ,)))
              //           ],
              //         ));
              //       } else {
              //         await OpenFile.open(file.path);
              //         //Get.to(PdfView(file.path,"attachment_file.png"));
              //       }
              //     },
              //     child: Card(
              //       elevation: 5,
              //       child: Container(
              //         padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
              //         child: Icon(Icons.attachment),
              //       ),
              //     ),
              //   ),
              // ],),
              Table(children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(labels!.insuranceType,
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('${insurance.insuranceTypeId.policyType}',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('Insurance Reference',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: insurance.insurance_ids.length > 0 &&
                            insurance.insurance_ids[0].name != null
                        ? Text('${insurance.insurance_ids[0].name}',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1)))
                        : Text("-"),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(labels.employeeName,
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('${insurance.employeeId.name}',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('Date',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('${AppUtils.changeDateFormat(insurance.date)}',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('Field Description',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                        '${AppUtils.removeNullString(insurance.description)}',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('Coverage Amount',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                        '${NumberFormat('#,###').format(double.tryParse(insurance.coverageAmount.toString()))}',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('Claim Amount',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                        '${NumberFormat('#,###').format(double.tryParse(insurance.claimAmount.toString()))}',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text('Balance Amount',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                        '${NumberFormat('#,###').format(double.tryParse(insurance.balance.toString()))}',
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  )
                ]),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        '${labels?.attachment} : ',
                        style: TextStyle(color: Color.fromRGBO(58, 47, 112, 1)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: InkWell(
                        onTap: () async {
                          File? file = await AppUtils.createPDF(
                              insurance.attached_file,
                              "attachmentId.png",
                              "application/png");
                          if (AppUtils.isImage(file!.path)) {
                            Get.dialog(Stack(
                              children: [
                                Center(child: Image.file(file)),
                                Positioned(
                                    right: 0,
                                    child: TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          'Close',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20),
                                        )))
                              ],
                            ));
                          } else {
                            await OpenFile.open(file.path);
                            //Get.to(PdfView(file.path,"attachment_file.png"));
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 10, bottom: 10),
                            child: Icon(Icons.attachment),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ])

              /*ExpansionTile(
                title: Text(
                  labels?.attachment,
                  style: maintitleStyle(),
                ),
                children:[
                  ListView.builder(
                    shrinkWrap: true,
                       itemCount: insurance.attachmentId.length,
                      itemBuilder: (context,index){
                    return InkWell(
                      onTap: () async{
                        File file = await AppUtils.createPDF(insurance.attachmentId[index].datas, "${insurance.attachmentId[index].name}");
                        if (AppUtils.isImage(file.path)) {
                          Get.dialog(Stack(
                            children: [
                              Center(child: Image.file(file)),
                              Positioned(right : 0,child: FlatButton(onPressed: (){Get.back();}, child: Text('Close',style:TextStyle(color: Colors.white,fontSize: 20) ,)))
                            ],
                          ));
                        } else {
                          Get.to(PdfView(file.path,insurance.attachmentId[index].name));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: AutoSizeText(insurance.attachmentId[index].name),
                      ),
                    );
                  })
                ]
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
