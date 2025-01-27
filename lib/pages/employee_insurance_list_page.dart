
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../controllers/insurance.dart';
// import '../localization.dart';
import '../models/insurancemodel.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeInsuranceListPage extends StatelessWidget {
  InsuranceController controller = Get.put(InsuranceController());
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(Routes.CREATE_INSURANCE);
        },
        child: Icon(Icons.add),
      ),
      body: Obx(
            () => Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.insuranceList.value.length,
                  itemBuilder: (context,index){
                    Insurancemodel insurance = controller.insuranceList.value[index];
                    return Card(
                      child: InkWell(
                        onTap: (){
                          Get.toNamed(Routes.INSURANCEDETAIL,arguments: insurance);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(children: [
                                AutoSizeText('Code',style: detailsStyle()),
                                AutoSizeText(' : ${AppUtils.removeNullString(insurance.name)}',style: maintitleStyle()),
                              ],),
                              SizedBox(height: 10,),
                              Row(children: [
                                AutoSizeText(labels!.insuranceType,style: detailsStyle()),
                                AutoSizeText(' : ${insurance.insuranceTypeId!.policy_type}',style: maintitleStyle()),
                              ],),
                              SizedBox(height: 10,),
                              Row(children: [
                                AutoSizeText(labels.employeeName,style: detailsStyle()),
                                AutoSizeText(' : ${insurance.employeeId!.name}',style: maintitleStyle()),
                              ],),
                              SizedBox(height: 10,),
                              Row(children: [
                                AutoSizeText('Premium Amount',style: detailsStyle()),
                                AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.premiumAmount.toString()))}',style: maintitleStyle()),
                              ],),
                              SizedBox(height: 10,),
                              Row(children: [
                                AutoSizeText('Coverage Amount',style: detailsStyle()),
                                AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.coverageAmount.toString()))}',style: maintitleStyle()),
                              ],),
                              SizedBox(height: 10,),
                              Row(children: [
                                AutoSizeText('Balance Amount',style: detailsStyle()),
                                AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.balanceAmount.toString()))}',style: maintitleStyle()),
                              ],),
                              SizedBox(height: 10,),
                              Row(children: [
                                AutoSizeText('No of Installments',style: detailsStyle()),
                                AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.installment.toString()))}',style: maintitleStyle()),
                              ],),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              ),
        ),
    );
  }
}
