

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/insurance.dart';
import '../models/insurancetypemodel.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
class CreateInsurancePage extends StatefulWidget {
  @override
  _CreateInsurancePageState createState() => _CreateInsurancePageState();
}

class _CreateInsurancePageState extends State<CreateInsurancePage> {
  InsuranceController controller = Get.find();
  var box = GetStorage();

  @override
  void initState() {
    controller.getInsuranceType();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var premiumAmt = AppUtils.addThousnadSperator(controller.selectedPolicyType.value.premiumAmount);
    var coverageAmt = AppUtils.addThousnadSperator(controller.selectedPolicyType.value.coverageAmount);
    var policyNumber = AppUtils.removeNullString(controller.selectedPolicyType.value.policyNumber.toString());
    var policyCoverage = AppUtils.removeNullString(controller.selectedPolicyType.value.policyCoverage.toString());
    var policyBenefit = AppUtils.removeNullString(controller.selectedPolicyType.value.benefit.toString());
    var policyDate = AppUtils.removeNullString(controller.selectedPolicyType.value.effectiveDate);
    var expireDate = AppUtils.removeNullString(controller.selectedPolicyType.value.expireDate);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, 'Create Insurance', '')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Employee Name : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(box.read('emp_name'),style: maintitleStyle())),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              InsuranceTypeDropDown(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Policy Number : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: controller.selectedPolicyType.value.policyNumber==null?Text(''):Text('${AppUtils.removeNullString(controller.selectedPolicyType.value.policyNumber.toString())}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top:10),
                child: Row(
                  children: [
                    Expanded(child: Text('Policy Benefit : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: controller.selectedPolicyType.value.benefit==null?Text(''):Text('${AppUtils.removeNullString(controller.selectedPolicyType.value.benefit.toString())}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Policy Coverage : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: controller.selectedPolicyType.value.policyCoverage==null?Text(''):Text('${AppUtils.removeNullString(controller.selectedPolicyType.value.policyCoverage.toString())}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Effective Date : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: Text('${AppUtils.changeDateFormat(controller.selectedPolicyType.value.effectiveDate)}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Expire Date : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: Text('${AppUtils.changeDateFormat(controller.selectedPolicyType.value.expireDate)}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Premium Amount : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: Text('${AppUtils.addThousnadSperator(controller.selectedPolicyType.value.premiumAmount)}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Coverage Amount : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: Text('${AppUtils.addThousnadSperator(controller.selectedPolicyType.value.coverageAmount)}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('No Of Installments : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: controller.selectedPolicyType.value.installment==null?Text(''):Text('${controller.selectedPolicyType.value.installment}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Deduction per month : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=>Expanded(
                          child: controller.selectedPolicyType.value.deductionPerMonth==null?Text(''):Text('${AppUtils.addThousnadSperator(controller.selectedPolicyType.value.deductionPerMonth).toString()}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              SizedBox(height:20),
              Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: GFButton(
                    color: textFieldTapColor,
                    onPressed: () {
                      controller.createEmployeensurance();
                    },
                    text: "SAVE",
                    blockButton: true,
                    size: GFSize.LARGE,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget InsuranceTypeDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: AutoSizeText('Policy Type : ',style: detailsStyle())),
          Expanded(
            flex: 2,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton<Insurancetypemodel>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Policy Type",
                              )),
                          value: controller.selectedPolicyType.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Insurancetypemodel? value) {
                            controller.onChangePolicyDropdown(value!);
                          },
                          items: controller.insurancyTypeList.value
                              .map((Insurancetypemodel insurancetypemodel) {
                            return DropdownMenuItem<Insurancetypemodel>(
                              value: insurancetypemodel,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  insurancetypemodel.policyType,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
