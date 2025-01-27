

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../controllers/approval_controller.dart';
import '../../my_class/my_style.dart';
import '../../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../localization.dart';

class ApprovedInsuranceDetailsPage extends StatefulWidget {
  @override
  State<ApprovedInsuranceDetailsPage> createState() =>
      _ApprovedInsuranceDetailsPageState();
}

class _ApprovedInsuranceDetailsPageState
    extends State<ApprovedInsuranceDetailsPage> {
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
          labels!.insurance,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Table(
            //   border: TableBorder.all(color: Colors.black26),
            //   // border: TableBorder(horizontalInside: BorderSide()),
            //   children: [
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Code', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].name)}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Expire Date', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.changeDateFormat(controller.insuranceApprovedList.value[index].expireDate)}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text(labels?.insuranceType, style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${controller.insuranceApprovedList.value[index].insuranceTypeId.policy_type}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text(labels?.employeeName, style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${controller.insuranceApprovedList.value[index].employeeId.name}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Benefits', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${controller.insuranceApprovedList.value[index].benefit}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Policy Coverage', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].poilcy_coverage)}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Efective Date', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.changeDateFormat(controller.insuranceApprovedList.value[index].effectiveDate)}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Premium Amount', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovedList.value[index].premiumAmount.toString()))}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Coverage Amount', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovedList.value[index].coverageAmount.toString()))}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Premium Fees(Employee)', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].feesEmployee.toString())}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Premium Fees(Employer)', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].feesEmployer.toString())}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Balance Amount', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovedList.value[index].balanceAmount.toString()))}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('No of Installments', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${controller.insuranceApprovedList.value[index].installment}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Total Amount', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.addThousnadSperator(controller.insuranceApprovedList.value[index].totalAmount)}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Total Paid Amount', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.addThousnadSperator(controller.insuranceApprovedList.value[index].totalPaidAmount)}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ]),
            //     TableRow(children: [
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('Balance Amount', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(7.0),
            //         child: Text('${AppUtils.addThousnadSperator(controller.insuranceApprovedList.value[index].balanceAmount)}', style: TextStyle(
            //         color: Color.fromRGBO(58, 47, 112, 1))),
            //       ),
            //     ])
            //   ],
            // ),
            // SizedBox(height: 10,),
            // AutoSizeText('Installments',style: detailsStyle(),),
            // SizedBox(height: 20,),
            // Divider(height: 2,color: Colors.black,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            // AutoSizeText('Payment Date',style: maintitleStyle(),),
            // AutoSizeText('Status',style: maintitleStyle()),
            // AutoSizeText('Amount',style: maintitleStyle()),
            // ],),
            // Divider(height: 2,color: Colors.black,),
            // ListView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemCount: controller.insuranceApprovedList.value[index].insuranceLines.length,
            //     itemBuilder: (context,index1){
            //   return Column(
            //     children: [
            //       SizedBox(height: 10,),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           AutoSizeText(controller.insuranceApprovedList.value[index].insuranceLines[index1].date),
            //           AutoSizeText(controller.insuranceApprovedList.value[index].insuranceLines[index1].state),
            //           AutoSizeText('${NumberFormat('#,###').format(controller.insuranceApprovedList.value[index].insuranceLines[index1].amount)}'),
            //         ],),
            //       Divider(height: 2,color: Colors.black,),
            //     ],
            //   );
            // }),
            // SizedBox(height: 10,),
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
                          '${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].employeeId!.name)}',
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
                          '${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].employeeId!.jobId!.name)}',
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
                          '${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].employeeId!.companyId!.name)}',
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
                          '${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].employeeId!.branchId!.name)}',
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
                          '${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].insuranceTypeId!.policy_type)}',
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
                          '${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].benefit)}',
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
                          '${AppUtils.removeNullString(controller.insuranceApprovedList.value[index].poilcy_coverage)}',
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
                            '${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovedList.value[index].premiumAmount.toString()))}',
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
                            '${NumberFormat('#,###').format(double.tryParse(controller.insuranceApprovedList.value[index].coverageAmount.toString()))}',
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
                            '${AppUtils.changeDateFormat(controller.insuranceApprovedList.value[index].effectiveDate)}',
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
                            '${AppUtils.changeDateFormat(controller.insuranceApprovedList.value[index].expireDate)}',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
