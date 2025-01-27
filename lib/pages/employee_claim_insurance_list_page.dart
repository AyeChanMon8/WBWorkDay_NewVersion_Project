
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../controllers/insurance.dart';
import '../models/claiminsurancemodel.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeClaimInsuranceListPage extends StatefulWidget {
  @override
  _EmployeeClaimInsuranceListPageState createState() => _EmployeeClaimInsuranceListPageState();
}

class _EmployeeClaimInsuranceListPageState extends State<EmployeeClaimInsuranceListPage> {
  InsuranceController controller = Get.find();
@override
  void initState() {
    super.initState();
    controller.getClaimInsurance();
  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(Routes.CLAIM_INSURANCE);
        },
        child: Icon(Icons.add),
      ),
      body: Obx(
            () => Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.claimInsuranceList.value.length,
              itemBuilder: (context,index){
                Claiminsurancemodel insurance = controller.claimInsuranceList.value[index];
                return Card(
                  child: InkWell(
                    onTap: (){
                      Get.toNamed(Routes.CLAIMINSURANCEDETAIL,arguments: insurance);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          // Row(children: [
                          //   AutoSizeText('Code',style: detailsStyle()),
                          //   AutoSizeText(' : ${AppUtils.removeNullString(insurance.name)}',style: maintitleStyle()),
                          // ],),
                          // SizedBox(height: 10,),
                          Row(children: [
                            AutoSizeText(labels!.insuranceType,style: detailsStyle()),
                            AutoSizeText(' : ${insurance.insuranceTypeId.policyType}',style: maintitleStyle()),
                          ],),
                          SizedBox(height: 10,),
                          insurance.insurance_ids.length > 0 ? Row(children: [
                            AutoSizeText('Insurance Reference',style: detailsStyle()),
                            AutoSizeText(' : ${insurance.insurance_ids[0].name}',style: maintitleStyle()),
                          ],):SizedBox(),
                          SizedBox(height: 10,),
                          Row(children: [
                            AutoSizeText(labels.employeeName,style: detailsStyle()),
                            AutoSizeText(' : ${insurance.employeeId.name}',style: maintitleStyle()),
                          ],),
                          SizedBox(height: 10,),
                          Row(children: [
                            AutoSizeText('Coverage Amount',style: detailsStyle()),
                            AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.coverageAmount.toString()))}',style: maintitleStyle()),
                          ],),
                          SizedBox(height: 10,),
                          Row(children: [
                            AutoSizeText('Claim Amount',style: detailsStyle()),
                            AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.claimAmount.toString()))}',style: maintitleStyle()),
                          ],),
                          SizedBox(height: 10,),
                          Row(children: [
                            AutoSizeText('Balance Amount',style: detailsStyle()),
                            AutoSizeText(' : ${NumberFormat('#,###').format(double.tryParse(insurance.balance.toString()))}',style: maintitleStyle()),
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
