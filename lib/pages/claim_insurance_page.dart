

import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../controllers/insurance.dart';
import '../models/insurancemodel.dart';
import '../models/insurancetypemodel.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../ui/components/textbox.dart';

class ClaimInsurancePage extends StatefulWidget {
  @override
  _ClaimInsurancePageState createState() => _ClaimInsurancePageState();
}

class _ClaimInsurancePageState extends State<ClaimInsurancePage> {
  InsuranceController controller = Get.find();
  final box = GetStorage();
  final picker = ImagePicker();
  String img64 = '';
  @override
  void initState() {
    controller.getInsurance();
    controller.txtDescription.text = '';
    controller.txtCalimAmont.text = '';
    controller.txtSelectedDate.text='';
    super.initState();
  }
  nullPhoto() {
    controller.isShowImage.value = false;
    controller.selectedImage.value = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, 'Claim Insurance', '')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20,bottom: 10),
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
              InsuranceReferenceDropDown(),
              SizedBox(
                width: 10,
              ),
              InsuranceTypeDropDown(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20,bottom: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Coverage Amount : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                          ()=> Expanded(
                          child: controller.selectedInsuranceType.value.coverageAmount!=null?
                          Text('${NumberFormat('#,###').format(double.tryParse(controller.selectedInsuranceType.value.coverageAmount.toString()))}'
                              ,style: maintitleStyle()):Text('')),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20,bottom: 10),
                child: Row(
                  children: [
                    Expanded(child: Text('Balance Amount : ',style: detailsStyle(),),),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                        ()=>Expanded(
                          child: Text('${NumberFormat('#,###').format(double.tryParse(controller.balanceAmount.value.toString()))}',style: maintitleStyle())),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: textFieldTapColor,
                      ),
                      child: TextField(
                        enabled: false,
                        controller: controller.txtSelectedDate,
                        style: maintitleStyle(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: ("Choose Date"),
                          hintStyle: detailsStyle()
                        ),
                      ),
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      enabled: true,
                      controller: controller.txtCalimAmont,
                      style:maintitleStyle(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (("Enter Claim Amount")),
                          hintStyle: detailsStyle()
                      ),
                      onChanged: (text) {
                        controller.calculateBalanceAmount();
                      },
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      maxLines: 5,
                      controller: controller.txtDescription,
                      style: maintitleStyle(),
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.all(15.0),
                        hintText: "Description",
                          hintStyle: detailsStyle(),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: const Color.fromRGBO(250, 250, 250, 1))),
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showOptions(context);
                        },
                        child: Obx(
                              () => Container(
                            decoration: BoxDecoration(),
                            child: controller.isShowImage.value == false
                                ? Container(
                                decoration:
                                BoxDecoration(color: textFieldTapColor),
                                height: 45,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                ))
                                : Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.file(
                                        controller.selectedImage.value!)),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      onTap: () {
                                        nullPhoto();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //_decideImageView(),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.all(10),
                  child: GFButton(
                    color: textFieldTapColor,
                    onPressed: () {
                      controller.createClaimInsurance();
                    },
                    text: "Claim",
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:  DateTime.now(),
      firstDate:DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: const Color.fromRGBO(60, 47, 126, 1),
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            highlightColor: Colors.grey[400],
            // textSelectionColor: Colors.grey,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
        var formatter = new DateFormat('yyyy-MM-dd');
        String date =  formatter.format(picked);
        controller.txtSelectedDate.text = date;
      }
    }
  Widget InsuranceTypeDropDown() {
    return Container(
      margin: EdgeInsets.only(top:10,left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: AutoSizeText('Policy Type : ',style: detailsStyle(),)),
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
                      child: DropdownButton<Insurancemodel>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Policy Type",
                              )),
                          value: controller.selectedInsuranceType.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Insurancemodel? value) {
                            controller.onChangeInsuranceDropdown(value!);
                          },
                          items: controller.insuranceList.value
                              .map((Insurancemodel insurancetypemodel) {
                            return DropdownMenuItem<Insurancemodel>(
                              value: insurancetypemodel,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: insurancetypemodel.insuranceTypeId!.policy_type!=null ? Text(
                                  insurancetypemodel.insuranceTypeId!.policy_type,
                                  style: maintitleStyle(),
                                ):Text('-'),
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
  Widget InsuranceReferenceDropDown() {
    return Container(
      margin: EdgeInsets.only(top:10,left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: AutoSizeText('Insurance Reference : ',style: detailsStyle(),)),
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
                      child: DropdownButton<Insurancemodel>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Insurance Ref",
                              )),
                          value: controller.selectedInsuranceRef.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Insurancemodel? value) {
                            controller.onChangeInsuranceRefDropdown(value!);
                          },
                          items: controller.insuranceList.value
                              .map((Insurancemodel insurancetypemodel) {
                            return DropdownMenuItem<Insurancemodel>(
                              value: insurancetypemodel,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  insurancetypemodel.name,
                                  style: maintitleStyle(),
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
  Future getCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    File image = File(pickedFile!.path);
    final bytes = Io.File(pickedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(image, img64);
  }
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    File image = File(pickedFile?.path?? "");
    final bytes = Io.File(pickedFile?.path?? "").readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(image, img64);
  }
  showOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    getCamera();
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.camera,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: Text("Camera")),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: Text("Gallery")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
  }

