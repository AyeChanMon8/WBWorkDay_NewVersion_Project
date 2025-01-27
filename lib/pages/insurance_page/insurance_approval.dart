
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../../controllers/approval_controller.dart';
import '../../my_class/my_style.dart';
import '../../utils/app_utils.dart';

import '../../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InsuranceApproval extends StatefulWidget {
  @override
  State<InsuranceApproval> createState() => _InsuranceApprovalState();
}

class _InsuranceApprovalState extends State<InsuranceApproval> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    index = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.insuranceApproval,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        // child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Table(
        //         border: TableBorder.all(color: Colors.black26),
        //         children: [
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Code', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].name)}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Expire Date', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.changeDateFormat(controller.insuranceApprovalList.value[index].expireDate)}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text(labels?.insuranceType, style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${controller.insuranceApprovalList.value[index].insuranceTypeId.policy_type}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text(labels?.employeeName, style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${controller.insuranceApprovalList.value[index].employeeId.name}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Benefits', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${controller.insuranceApprovalList.value[index].benefit}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Policy Coverage', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].poilcy_coverage)}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Efective Date', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.changeDateFormat(controller.insuranceApprovalList.value[index].effectiveDate)}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Premium Amount', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovalList.value[index].premiumAmount.toString()))}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Coverage Amount', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovalList.value[index].coverageAmount.toString()))}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Premium Fees(Employee)', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].feesEmployee.toString())}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Premium Fees(Employer)', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].feesEmployer.toString())}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Balance Amount', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovalList.value[index].balanceAmount.toString()))}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('No of Installments', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${controller.insuranceApprovalList.value[index].installment}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Total Amount', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.addThousnadSperator(controller.insuranceApprovalList.value[index].totalAmount)}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Total Paid Amount', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.addThousnadSperator(controller.insuranceApprovalList.value[index].totalPaidAmount)}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ]),
        //           TableRow(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('Balance Amount', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Text('${AppUtils.addThousnadSperator(controller.insuranceApprovalList.value[index].balanceAmount)}', style: TextStyle(
        //               color: Color.fromRGBO(58, 47, 112, 1))),
        //             ),
        //           ])
        //         ],
        //       ),

        //       SizedBox(height: 10,),
        //       AutoSizeText('Installments',style: detailsStyle(),),
        //       SizedBox(height: 20,),
        //       Divider(height: 2,color: Colors.black,),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //       AutoSizeText('Payment Date',style: maintitleStyle(),),
        //       AutoSizeText('Status',style: maintitleStyle()),
        //       AutoSizeText('Amount',style: maintitleStyle()),
        //       ],),
        //       Divider(height: 2,color: Colors.black,),
        //       ListView.builder(
        //           shrinkWrap: true,
        //           physics: NeverScrollableScrollPhysics(),
        //           itemCount: controller.insuranceApprovalList.value[index].insuranceLines.length,
        //           itemBuilder: (context,index1){
        //         return Column(
        //           children: [
        //             SizedBox(height: 10,),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 AutoSizeText(controller.insuranceApprovalList.value[index].insuranceLines[index1].date),
        //                 AutoSizeText(controller.insuranceApprovalList.value[index].insuranceLines[index1].state),
        //                 AutoSizeText('${NumberFormat('#,###').format(controller.insuranceApprovalList.value[index].insuranceLines[index1].amount)}'),
        //               ],),
        //             Divider(height: 2,color: Colors.black,),
        //           ],
        //         );
        //       }),
        //       SizedBox(height: 10,),
        //       controller.insuranceApprovalList.value[index].state == 'waiting_approval_1'
        //         ? Row(
        //           children: [
        //             Expanded(
        //               flex:1,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: GFButton(
        //                     onPressed: () {
        //                       controller.approveInsurance(controller.insuranceApprovalList.value[index].id);
        //                     },
        //                     text: labels?.approve,
        //                     blockButton: true,
        //                     size: GFSize.LARGE,
        //                     color: textFieldTapColor,
        //                   ),
        //               ),
        //             ),
        //             Expanded(
        //               flex:1,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: GFButton(
        //                   onPressed: () {
        //                     controller.rejectInsurance(
        //                         controller.insuranceApprovalList.value[index].id);
        //                   },
        //                   type: GFButtonType.outline,
        //                   text: 'Reject',
        //                   textColor: textFieldTapColor,
        //                   blockButton: true,
        //                   size: GFSize.LARGE,
        //                   color: textFieldTapColor,
        //                 ),
        //               ),
        //             )
        //           ],
        //         )
        //         : SizedBox(),
        //     ],
        //   ),
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Table(
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Employee Name',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                          '${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].employeeId!.name)}',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Job Position',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                          '${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].employeeId!.jobId!.name)}',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Company',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                          '${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].employeeId!.companyId!.name)}',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Branch',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                          '${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].employeeId!.branchId!.name)}',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Policy Type',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                          '${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].insuranceTypeId!.policy_type)}',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Benefits',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                          '${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].benefit)}',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Policy Coverage',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                          '${AppUtils.removeNullString(controller.insuranceApprovalList.value[index].poilcy_coverage)}',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                ],
              ),
            ]),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text('Premium Amount',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                            '${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovalList.value[index].premiumAmount.toString()))}',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text('Coverage Amount',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                            '${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovalList.value[index].coverageAmount.toString()))}',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text('Effective Date',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                            '${AppUtils.changeDateFormat(controller.insuranceApprovalList.value[index].effectiveDate)}',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text('Expire Date',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                            '${AppUtils.changeDateFormat(controller.insuranceApprovalList.value[index].expireDate)}',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            controller.insuranceApprovalList.value[index].state ==
                    'waiting_approval_1'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFButton(
                            onPressed: () {
                              controller.approveInsurance(controller
                                  .insuranceApprovalList.value[index].id);
                            },
                            text: labels?.approve,
                            blockButton: true,
                            size: GFSize.LARGE,
                            color: textFieldTapColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFButton(
                            onPressed: () {
                              controller.rejectInsurance(controller
                                  .insuranceApprovalList.value[index].id);
                            },
                            type: GFButtonType.outline,
                            text: 'Reject',
                            textColor: textFieldTapColor,
                            blockButton: true,
                            size: GFSize.LARGE,
                            color: textFieldTapColor,
                          ),
                        ),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
