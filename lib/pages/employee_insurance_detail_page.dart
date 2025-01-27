

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import '../localization.dart';
import '../models/insurancemodel.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeInsuranceDetailPage extends StatelessWidget {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    Insurancemodel insurance = Get.arguments;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, 'Insurance Detail', '')),
      body: Scrollbar(
        controller: scrollController,
        // isAlwaysShown: true,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(10),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Row(children: [
            //       AutoSizeText('Code',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.removeNullString(insurance.name)}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Expire Date',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.changeDateFormat(insurance.expireDate)}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText(labels?.insuranceType,style: detailsStyle()),
            //       AutoSizeText(' : ${insurance.insuranceTypeId.policy_type}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText(labels?.employeeName,style: detailsStyle()),
            //       AutoSizeText(' : ${insurance.employeeId.name}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Benefits',style: detailsStyle()),
            //       AutoSizeText(' : ${insurance.benefit}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Policy Coverage',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.removeNullString(insurance.poilcy_coverage)}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Efective Date',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.changeDateFormat(insurance.effectiveDate)}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Premium Amount',style: detailsStyle()),
            //       AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.premiumAmount.toString()))}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Coverage Amount',style: detailsStyle()),
            //       AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.coverageAmount.toString()))}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Premium Fees(Employee)',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.removeNullString(insurance.feesEmployee.toString())}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Premium Fees(Employer)',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.removeNullString(insurance.feesEmployer.toString())}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Balance Amount',style: detailsStyle()),
            //       AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.balanceAmount.toString()))}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('No of Installments',style: detailsStyle()),
            //       AutoSizeText(' : ${insurance.installment}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Total Amount',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.addThousnadSperator(insurance.totalAmount)}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Total Paid Amount',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.addThousnadSperator(insurance.totalPaidAmount)}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     Row(children: [
            //       AutoSizeText('Balance Amount',style: detailsStyle()),
            //       AutoSizeText(' : ${AppUtils.addThousnadSperator(insurance.balanceAmount)}',style: maintitleStyle()),
            //     ],),
            //     SizedBox(height: 10,),
            //     AutoSizeText('Installments',style: detailsStyle(),),
            //     SizedBox(height: 20,),
            //     Divider(height: 2,color: Colors.black,),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //     AutoSizeText('Payment Date',style: maintitleStyle(),),
            //     AutoSizeText('Status',style: maintitleStyle()),
            //     AutoSizeText('Amount',style: maintitleStyle()),
            //     ],),
            //     Divider(height: 2,color: Colors.black,),
            //     ListView.builder(
            //         shrinkWrap: true,
            //         physics: NeverScrollableScrollPhysics(),
            //         itemCount: insurance.insuranceLines.length,
            //         itemBuilder: (context,index){
            //       return Column(
            //         children: [
            //           SizedBox(height: 10,),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               AutoSizeText(insurance.insuranceLines[index].date),
            //               AutoSizeText(insurance.insuranceLines[index].state),
            //               AutoSizeText('${NumberFormat('#,###').format(insurance.insuranceLines[index].amount)}'),
            //             ],),
            //           Divider(height: 2,color: Colors.black,),
            //         ],
            //       );
            //     })
            //   ],
            // ),
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
                          '${AppUtils.removeNullString(insurance.employeeId!.name)}',
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
                          '${AppUtils.removeNullString(insurance.employeeId!.jobId!.name)}',
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
                          '${AppUtils.removeNullString(insurance.employeeId!.companyId!.name)}',
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
                          '${AppUtils.removeNullString(insurance.employeeId!.branchId!.name)}',
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
                          '${AppUtils.removeNullString(insurance.insuranceTypeId!.policy_type)}',
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
                          '${AppUtils.removeNullString(insurance.benefit)}',
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
                          '${AppUtils.removeNullString(insurance.poilcy_coverage)}',
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
                            '${NumberFormat('#,###').format(double.tryParse(insurance.premiumAmount.toString()))}',
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
                            '${NumberFormat('#,###').format(double.tryParse(insurance.coverageAmount.toString()))}',
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
                            '${AppUtils.changeDateFormat(insurance.effectiveDate)}',
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
                            '${AppUtils.changeDateFormat(insurance.expireDate)}',
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
        ),
      ),
    );
  }
}
