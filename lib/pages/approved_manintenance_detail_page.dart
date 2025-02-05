

import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/maintenance_controller.dart';
// import '../localization.dart';
import '../models/maintenance_product_category_model.dart';
import '../models/maintenance_request_model.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'leave_detail.dart';

class ApprovedMaintenanceDetailPage extends StatefulWidget {
  @override
  _ApprovedMaintenanceDetailState createState() => _ApprovedMaintenanceDetailState();
}

class _ApprovedMaintenanceDetailState extends State<ApprovedMaintenanceDetailPage> {
  MaintenanceController controller = Get.find();
  Maintenance_request_model maintenanceRequestModel = Get.arguments;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String img64 = '';
  late Uint8List bytes1;
  late Uint8List bytes2;
  late Uint8List bytes3;
  late Uint8List bytes4;
  late Uint8List bytes5;
  late Uint8List bytes6;
  var show_edit_image = true;
  var box = GetStorage();
  var emp_id = 0;
  var isDriver = false;
  var is_branch_manager = false;
  var is_spare = false;
  var requestDate = '';
  @override
  void initState() {

    controller.getMaintenanceProductCategorys();
    controller.getMaintenanceProductList(0);
    emp_id = int.tryParse(box.read("emp_id"))!;
    print(maintenanceRequestModel.state);
    isDriver = box.read("is_driver");
    var employee_id = box.read('emp_id');
    if((maintenanceRequestModel.driverId!.id != int.parse(employee_id) && box.read('real_role_category').toString().contains('branch manager')) || maintenanceRequestModel.driverId!.id != int.parse(employee_id) && box.read('real_role_category').toString().contains('manager')){
      is_branch_manager = true;
    }else if(maintenanceRequestModel.driverId!.id == int.parse(employee_id) && box.read('real_role_category').toString().contains('branch manager')){
      is_branch_manager = true;
    }else{
      is_branch_manager = false;
    }
    if(box.read('real_role_category').toString().contains('spare')){
      is_spare = true;
    }else{
      is_spare = false;
    }
    print(isDriver);
    if(maintenanceRequestModel.image!=null){
      controller.isShowBeforeOne.value = true;
      bytes1 = base64Decode(maintenanceRequestModel.image!);

    }else{
      controller.isShowBeforeOne.value = false;
    }
    if(maintenanceRequestModel.image1!=null){
      controller.isShowBeforeTwo.value = true;
      bytes2 = base64Decode(maintenanceRequestModel.image1!);

    }else{
      controller.isShowBeforeTwo.value = false;
    }
    if(maintenanceRequestModel.image2!=null){
      controller.isShowBeforeThree.value = true;
      bytes3 = base64Decode(maintenanceRequestModel.image2!);

    }else{
      controller.isShowBeforeThree.value = false;
    }
    if(maintenanceRequestModel.image3!=null){
      controller.isShowAfterOne.value = true;
      bytes4 = base64Decode(maintenanceRequestModel.image3!);

    }else{
      controller.isShowAfterOne.value = false;
    }
    if(maintenanceRequestModel.image4!=null){
      controller.isShowAfterTwo.value = true;
      bytes5 = base64Decode(maintenanceRequestModel.image4!);

    }else{
      controller.isShowAfterTwo.value = false;
    }
    if(maintenanceRequestModel.image5!=null){
      controller.isShowAfterThree.value = true;
      bytes6 = base64Decode(maintenanceRequestModel.image5!);
    }else{
      controller.isShowAfterThree.value = false;
    }
    requestDate = AppUtils.changeDateFormat(maintenanceRequestModel.requestDate!);
    controller.selectedFromDate.value = AppUtils.changeDateTimeFormat(maintenanceRequestModel.startDate!);
    controller.selectedToDate.value = AppUtils.changeDateTimeFormat(maintenanceRequestModel.endDate!);
    //controller.selectedFromDate.value = DateFormat('yyyy-MM-dd HH:mm').parse(maintenanceRequestModel.startDate.toString()).add(Duration(hours: 6,minutes: 30)).toString().split('.')[0];
    //controller.selectedToDate.value = DateFormat('yyyy-MM-dd HH:mm').parse(maintenanceRequestModel.endDate.toString()).add(Duration(hours: 6,minutes: 30)).toString().split('.')[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //controller.selectedFromDate.value = maintenanceRequestModel.startDate;
    var labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels!.maintenance, '')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  AutoSizeText(
                    labels.code+' : ',
                    style: datalistStyle(),
                  ),
                  AutoSizeText(
                    maintenanceRequestModel.code.toString(),
                    style: maintitleStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.requestDate+' : ',
                    style: datalistStyle(),
                  ),
                  AutoSizeText(
                    requestDate,
                    style: maintitleStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.maintenanceType+' : ',
                    style: datalistStyle(),
                  ),
                  AutoSizeText(
                    maintenanceRequestModel.maintenanceType!,
                    style: maintitleStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    'Workshop Selection'+' : ',
                    style: datalistStyle(),
                  ),
                  AutoSizeText(
                    maintenanceRequestModel.workshopSelection=='defined_workshop' ? 'Defined Workshop' : maintenanceRequestModel.workshopSelection=='undefined_workshop' ? 'Undefined Workshop': maintenanceRequestModel.workshopSelection!,
                    style: maintitleStyle(),
                  ),
                ],
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.maintenanceTeam+' : ',
                    style: datalistStyle(),
                  ),
                  AutoSizeText(
                    maintenanceRequestModel.maintenanceTeamId!.name??'',
                    style: maintitleStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.startDate+'  : ',
                    style: datalistStyle(),
                  ),

                  Obx(()=>
                      AutoSizeText(
                        controller.selectedFromDate.value?? '',
                        style: maintitleStyle(),
                      ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.endDate+' : ',
                    style: datalistStyle(),
                  ),
                  Obx(()=>
                      AutoSizeText(
                        controller.selectedToDate.value?? '',
                        style: maintitleStyle(),
                      ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.actualDuration+' : ',
                    style: datalistStyle(),
                  ),
                  AutoSizeText(
                    maintenanceRequestModel.duration_days!.toStringAsFixed(2)+" Days "+maintenanceRequestModel.duration_hours!.toStringAsFixed(2)+" Hrs",
                    style: maintitleStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.driver+' : ',
                    style: datalistStyle(),
                  ),
                  AutoSizeText(
                    AppUtils.removeNullString(maintenanceRequestModel.driverId!.name),
                    style: maintitleStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.spare1+' : ',
                    style: datalistStyle(),
                  ),
                  maintenanceRequestModel.spareId!=null && maintenanceRequestModel.spareId!.name!=null ?
                  AutoSizeText(
                    AppUtils.removeNullString(maintenanceRequestModel.spareId!.name),
                    style: maintitleStyle(),
                  ) : Text('-',
                  style: maintitleStyle()
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.spare2+' : ',
                    style: datalistStyle(),
                  ),
                  AutoSizeText(
                    AppUtils.removeNullString(maintenanceRequestModel.spare2Id!.name),
                    style: maintitleStyle(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.priority+' :',
                    style: datalistStyle(),
                  ),
                  RatingBar.builder(
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                    initialRating:
                    double.parse(maintenanceRequestModel.priority ?? '0'),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemSize: 30,
                    itemCount: 3,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AutoSizeText(
                    labels.description+' : ',
                    style: datalistStyle(),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppUtils.removeNullString(maintenanceRequestModel.description!),
                      style: maintitleStyle(),
                    ),
                  ),
                ],
              ),
              controller.maintenanceProductIdList.value.length!=0?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: AutoSizeText(
                            labels.product,
                            style: maintitleStyle(),
                          )),
                      Expanded(
                          flex: 2,
                          child: AutoSizeText(labels.category,
                              style: maintitleStyle())),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: AutoSizeText(labels.type, style: maintitleStyle()),
                          )),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: AutoSizeText(labels.quantity, style: maintitleStyle()),
                      )),
                      is_branch_manager==false? Expanded(child: AutoSizeText('')):SizedBox(),
                    ],
                  ),
                  Divider(
                    height: 2,
                    indent: 10,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Obx(
                        () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.maintenanceProductIdList.value.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: controller
                                        .maintenanceProductIdList[index]
                                        .productId==null?Text(''):AutoSizeText(AppUtils.removeNullString(controller
                                        .maintenanceProductIdList[index]
                                        .productId!
                                        .name))),
                                Expanded(
                                    flex: 2,
                                    child: AutoSizeText(AppUtils.removeNullString(controller
                                        .maintenanceProductIdList[index]
                                        .categoryId!
                                        .name))),
                                Expanded(
                                  child: AutoSizeText(AppUtils.removeNullString(controller
                                      .maintenanceProductIdList[index]
                                      .type)),
                                ),
                                Expanded(
                                    child: AutoSizeText(
                                        '${controller.maintenanceProductIdList[index].qty}')),
                                
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ):SizedBox(),

              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: AutoSizeText(
                          labels.ref,
                          style: maintitleStyle(),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: AutoSizeText(labels.confDate,
                          style: maintitleStyle())),
                  Expanded(
                      flex: 2,
                      child: AutoSizeText(labels.vendor, style: maintitleStyle())),
                  Expanded(flex:1,child: AutoSizeText(labels.total, style: maintitleStyle())),
                  Expanded(flex:1,child: AutoSizeText(labels.status, style: maintitleStyle())),
                  // Expanded(flex:1,child: AutoSizeText('')),
                  // Expanded(child: AutoSizeText('Status', style: maintitleStyle())),

                ],
              ),
              Divider(
                height: 2,
                indent: 10,
                thickness: 1,
                color: Colors.black,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: maintenanceRequestModel.purchaseLine!.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // var utc_date = maintenanceRequestModel.purchaseLine[index].dateApprove.toString();
                    // print('utc_date');
                    // print(utc_date);
                    // var dateTime =
                    // DateFormat("yyyy-MM-dd HH:mm:ss").parse(utc_date, true);
                    // var dateLocal = dateTime.toLocal().toString();
                    // var split_date = dateLocal.split(" ")[0];
                    // print('dateLocal');
                    // print(dateLocal);
                    var conf_date = AppUtils.changeDateFormat(maintenanceRequestModel.purchaseLine![index].dateApprove);
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: AutoSizeText(maintenanceRequestModel.purchaseLine![index].name!)),
                          Expanded(
                              flex: 2,
                              child: AutoSizeText(conf_date)),
                          Expanded(
                              flex: 2,
                              child: AutoSizeText(maintenanceRequestModel.purchaseLine![index].partnerId!.name)),
                          Expanded(
                              flex: 1,
                              child: AutoSizeText(
                                  '${NumberFormat('#,###').format(double.tryParse(maintenanceRequestModel.purchaseLine![index].amountTotal.toString()))}')),
                          Expanded(
                              flex: 1,
                              child: AutoSizeText(maintenanceRequestModel.purchaseLine![index].state!)),
                          // Expanded(
                          //   flex: 1,
                          //     child: IconButton(
                          //       icon: Icon(Icons.delete),
                          //       onPressed: () {
                          //
                          //       },
                          //     )),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 20,
              ),

              maintenanceRequestModel.warehouseIds!.length!=0?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: AutoSizeText(
                            labels.product,
                            style: maintitleStyle(),
                          )),
                      Expanded(
                          flex: 2,
                          child: AutoSizeText(labels.location,
                              style: maintitleStyle())),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: AutoSizeText(labels.cost, style: maintitleStyle()),
                          )),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: AutoSizeText(labels.quantity, style: maintitleStyle()),
                          )),

                    ],
                  ),
                  Divider(
                    height: 2,
                    indent: 10,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: maintenanceRequestModel.warehouseIds!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: AutoSizeText(AppUtils.removeNullString(maintenanceRequestModel.warehouseIds![index]
                                      .productId!
                                      .name))),
                              Expanded(
                                  flex: 2,
                                  child: AutoSizeText(AppUtils.removeNullString(maintenanceRequestModel.warehouseIds![index].locationId!.name))),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: AutoSizeText(AppUtils.addThousnadSperator(maintenanceRequestModel.warehouseIds![index]
                                        .cost!)),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: AutoSizeText(
                                        '${AppUtils.removeNullString(maintenanceRequestModel.warehouseIds![index].qty.toString())}'),
                                  )),

                            ],
                          ),
                        );
                      }),

                ],
              ):SizedBox(),
              SizedBox(
                height: 10,
              ),


              SizedBox(
                height: 10,
              ),
              Text(labels.before),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    Obx(()=> InkWell(
                      onTap: (){

                        // if(controller.isShowBeforeOne.value){
                        //   showImageDialog('before_one',bytes1);
                        // }else{
                        //   maintenanceRequestModel.state=='done'||maintenanceRequestModel.state=='reject'||maintenanceRequestModel.state=='resubmitted'||maintenanceRequestModel.state=='reproposed'||
                        //       maintenanceRequestModel.state=='approved'|| maintenanceRequestModel.state=='submit'|| maintenanceRequestModel.state=='qc'?showToast(labels.cannotadd):
                        //   showOptions(maintenanceRequestModel.id,'before_one');
                        // }
                      },
                      child: Column(
                        children: [
                          controller.isShowBeforeOne.value==false?
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration:
                                BoxDecoration(color: Colors.grey),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ):
                          this.show_edit_image?
                          new Image.memory(
                            bytes1,
                            fit: BoxFit.fitWidth,
                            width: 100,height: 100,
                          ):new Container(),

                          Text(labels.before1),
                        ],
                      ),
                    ),),
                    Obx(()=> InkWell(
                      onTap: (){
                        // if(controller.isShowBeforeTwo.value){
                        //   showImageDialog('before_two',bytes2);

                        // }else{
                        //   maintenanceRequestModel.state=='done'||maintenanceRequestModel.state=='reject'||maintenanceRequestModel.state=='resubmitted'||maintenanceRequestModel.state=='reproposed'||
                        //       maintenanceRequestModel.state=='approved'||maintenanceRequestModel.state=='submit'|| maintenanceRequestModel.state=='qc'?showToast("Can not add at this time!"):
                        //   showOptions(maintenanceRequestModel.id,'before_two');
                        // }

                      },
                      child: Column(
                        children: [
                          controller.isShowBeforeTwo.value==false?
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration:
                                BoxDecoration(color: Colors.grey),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ):
                          this.show_edit_image? new Image.memory(
                            bytes2,
                            fit: BoxFit.fitWidth,
                            width: 100,height: 100,
                          ):new Container(),

                          Text(labels.before2),
                        ],
                      ),
                    ),),
                    Obx(()=> InkWell(
                      onTap: (){
                        // if(controller.isShowBeforeThree.value){
                        //   showImageDialog('before_three',bytes3);

                        // }else{
                        //   maintenanceRequestModel.state=='done'||maintenanceRequestModel.state=='reject'||maintenanceRequestModel.state=='resubmitted'||maintenanceRequestModel.state=='reproposed'||
                        //       maintenanceRequestModel.state=='approved'||maintenanceRequestModel.state=='submit'|| maintenanceRequestModel.state=='qc'?showToast("Can not add at this time!"):
                        //   showOptions(maintenanceRequestModel.id,'before_three');
                        // }

                      },
                      child: Column(
                        children: [
                          controller.isShowBeforeThree.value==false?
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration:
                                BoxDecoration(color: Colors.grey),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ):
                          this.show_edit_image? SizedBox(
                            width :100,
                            height:100,
                            child: Image.memory(
                              bytes3,
                              fit: BoxFit.fitWidth,
                              width: 100,height: 100,
                            )
                          ): Container(),

                          Text(labels.before3),
                        ],
                      ),
                    ),),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('After'),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    Obx(()=> InkWell(
                      onTap: (){
                        // if(controller.isShowAfterOne.value){
                        //   showImageDialog('after_one',bytes4);

                        // }else{
                        //   maintenanceRequestModel.state=='done'||maintenanceRequestModel.state=='reject'||maintenanceRequestModel.state=='resubmitted'||maintenanceRequestModel.state=='reproposed'||
                        //       maintenanceRequestModel.state=='approved'||maintenanceRequestModel.state=='submit'|| maintenanceRequestModel.state=='qc'|| maintenanceRequestModel.state!='start'
                        //       ?showToast("Can not add at this time!"):
                        //   showOptions(maintenanceRequestModel.id,'after_one');
                        // }
                        // print("after_one ${controller.isShowAfterOne.value}");
                      },
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          controller.isShowAfterOne.value==false?
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration:
                                BoxDecoration(color: Colors.grey),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ):
                          this.show_edit_image? SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.memory(
                              bytes4,
                              fit: BoxFit.fitWidth,
                              width: 100,height: 100,

                            ),
                          ):new Container(),

                          SizedBox(width:80,child: Center(child: Text(labels.after1))),
                        ],
                      ),
                    ),),
                      Obx(()=> InkWell(
                        onTap: (){
                          // if(controller.isShowAfterTwo.value){
                          //   showImageDialog('after_two',bytes5);

                          // }else{
                          //   maintenanceRequestModel.state=='done'||maintenanceRequestModel.state=='reject'||maintenanceRequestModel.state=='resubmitted'||maintenanceRequestModel.state=='reproposed'||
                          //       maintenanceRequestModel.state=='approved'||maintenanceRequestModel.state=='submit'|| maintenanceRequestModel.state=='qc'||maintenanceRequestModel.state!='start'?showToast("Can not add at this time!"):
                          //   showOptions(maintenanceRequestModel.id,'after_two');
                          // }
                          // print("after_two ${controller.isShowAfterTwo.value}");
                        },
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            controller.isShowAfterTwo.value==false?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 80,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration:
                                  BoxDecoration(color: Colors.grey),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            ):
                            this.show_edit_image?  SizedBox(
                              width: 100,
                              height: 100,
                              child: new Image.memory(
                                bytes5,
                                fit: BoxFit.fitWidth,
                                width: 100,height: 100,

                              ),):new Container(),

                            SizedBox(width: 80,child: Center(child: Text(labels.after2))),
                          ],
                        ),
                      ),),
                    Obx(()=>InkWell(
                      onTap: (){
                        // if(controller.isShowAfterThree.value){
                        //   showImageDialog('after_three',bytes6);

                        // }else{
                        //   maintenanceRequestModel.state=='done'||maintenanceRequestModel.state=='reject'||maintenanceRequestModel.state=='resubmitted'||maintenanceRequestModel.state=='reproposed'||
                        //       maintenanceRequestModel.state=='approved'||maintenanceRequestModel.state=='submit'|| maintenanceRequestModel.state=='qc'||maintenanceRequestModel.state!='start'?showToast("Can not add at this time!"):
                        //   showOptions(maintenanceRequestModel.id,'after_three');
                        // }
                        // print("after_three${controller.isShowAfterThree.value}");
                      },
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          controller.isShowAfterThree.value==false?
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration:
                                BoxDecoration(color: Colors.grey),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ):
                          this.show_edit_image? SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.memory(
                              bytes6,
                              fit: BoxFit.fitWidth,
                              width: 100,height: 100,
                            ),):new Container(),

                          SizedBox(width: 80,child: Center(child: Text(labels.after3))),
                        ],
                      ),
                    ),),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget productCategoryDropDown() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              // height: 50,
              // margin: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  // Border.all(color: Colors.white, width: 2),
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
                      child: DropdownButton<Maintenance_product_category_model>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "product category",
                              )),
                          value: controller.selectedProductCategory.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Maintenance_product_category_model? value) {
                            print(value!.name);
                            print(value!.id);
                            controller.onChangeProductCategoryDropdown(value!);
                          },
                          items:
                          controller.maintenanceProductCategorys.map((Maintenance_product_category_model model) {
                            return DropdownMenuItem<Maintenance_product_category_model>(
                              value: model,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  model.name,
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
  Widget productDropDown() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              // height: 50,
              // margin: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  // Border.all(color: Colors.white, width: 2),
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
                      child: DropdownButton<Product_id>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Vehicle",
                              )),
                          value: controller.selectedProduct.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Product_id? value) {
                            print(value!.name);
                            print(value!.id);
                            controller.onChangeProductDropdown(value!);
                          },
                          items:
                          controller.maintenanceProductList.map((Product_id product_id) {
                            return DropdownMenuItem<Product_id>(
                              value: product_id,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  product_id.name,
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
  Widget productTypeDropDown() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              // height: 50,
              // margin: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  // Border.all(color: Colors.white, width: 2),
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
                      child: DropdownButton<String>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Vehicle",
                              )),
                          value: controller.selectedProductType.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (String? value) {
                            controller.onChangeProductTypeDropdown(value!);
                          },
                          items:[
                            DropdownMenuItem<String>(
                              value: 'repair',
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Repair',
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'new',
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'New',
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                          ]
                      ),
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
  // showOptions(var id,var from) {
  //   showModalBottomSheet(
  //       context: Get.context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: 100,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //               InkWell(
  //                 onTap: () {
  //                   getCamera(id,from);
  //                   Get.back();
  //                 },
  //                 child: Container(
  //                   child: Column(
  //                     children: [
  //                       Icon(
  //                         FontAwesomeIcons.camera,
  //                         size: 50,
  //                         color: Color.fromRGBO(54, 54, 94, 0.9),
  //                       ),
  //                       Container(child: Text("Camera")),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   getImage(id,from);
  //                   Get.back();
  //                   // if(controller.imageList.length<=6) {
  //                   //   getImage(id,from);
  //                   //   Get.back();
  //                   // }else
  //                   // {
  //                   //   AppUtils.showConfirmDialog('Warning!', "Not allow more than 6 images.",(){
  //                   //     Get.back();
  //                   //     Get.back();
  //                   //   });
  //                   // }
  //                 },
  //                 child: Container(
  //                   child: Column(
  //                     children: [
  //                       Icon(
  //                         Icons.photo,
  //                         size: 50,
  //                         color: Color.fromRGBO(54, 54, 94, 0.9),
  //                       ),
  //                       Container(child: Text("Gallery")),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
  Future getImage(int id,String from) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    File image = File(pickedFile!.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    // setState(() {
    //   controller.imageList.insert(index,bytes);
    //   controller.imageList.removeAt(index+1);
    // });

    setState(() {
      show_edit_image = true;
      if(from=='before_one'){
        controller.isShowBeforeOne.value = true;
        bytes1 = bytes;

      }else if(from=='before_two'){
        controller.isShowBeforeTwo.value= true;
        bytes2 = bytes;
      }else if(from=='before_three'){
        controller.isShowBeforeThree.value= true;
        bytes3 = bytes;
      }
      else if(from=='after_one'){
        controller.isShowAfterOne.value = true;
        bytes4 = bytes;
      }
      else if(from=='after_two'){
        controller.isShowAfterTwo.value=true;
        bytes5 = bytes;
      }  else if(from=='after_three'){
        controller.isShowAfterThree.value= true;
        bytes6 = bytes;
      }
    });
    controller.updateCameraImage(id,from,image, img64);
  }

  nullPhoto() {

  }

  Future getCamera(int id,String from) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    File image = File(pickedFile!.path);
    final bytes = Io.File(pickedFile!.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    // setState(() {
    //   controller.imageList.insert(index,bytes);
    //   controller.imageList.removeAt(index+1);
    // });

    setState(() {
      show_edit_image = true;
      if(from=='before_one'){
        bytes1 = bytes;
      }else if(from=='before_two'){
        bytes2 = bytes;
      }else if(from=='before_three'){
        bytes3 = bytes;
      }
      else if(from=='after_one'){
        bytes4 = bytes;
      }
      else if(from=='after_two'){
        bytes5 = bytes;
      }  else if(from=='after_three'){
        bytes6 = bytes;
      }
    });
    controller.updateCameraImage(id,from,image, img64);
  }

  static void showToast(String msg) {
    Get.snackbar('Warning', msg, snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red);
  }
  
  Widget dateTimeDialog(String state) {
    final format = DateFormat("yyyy-MM-dd hh:mm aa");
    var date_controller;
    var hintText = "";
    if (state == 'start') {
      hintText = 'Choose Start Date Time';
    } else {
      hintText = 'Choose End Date Time';
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(children: <Widget>[
        // Text('Basic date & time field (${format.pattern})'),
        DateTimeField(
          controller: date_controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                //firstDate: DateTime(1988),
                firstDate: DateTime(1988),
                //initialDate: currentValue ?? DateTime.now(),
                initialDate:state == 'start'?DateTime.parse(maintenanceRequestModel.endDate!):DateTime.now(),
                // lastDate: DateTime(2200));
                lastDate: state == 'start'?DateTime.parse(maintenanceRequestModel.endDate!):DateTime(2200));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              var date_time = DateTimeField.combine(date, time).toString().split('.000')[0];

              if (state == 'start') {
                // controller.fromDateTimeTextController.text =
                //     date_time.toString();
                controller.selectedStartDate = date_time;
                print("selectedStartDate");
                print(controller.selectedStartDate);
              } else {
                // controller.toDateTimeTextController.text = date_time.toString();
                controller.selectedEndDate = date_time;
                print("selectedEndDate");
                print(controller.selectedEndDate);

              }
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        ),
      ]),
    );
  }

  // Future<dynamic> showImageDialog(String from, Uint8List bytes) {
  //   var labels = AppLocalizations.of(context);
  //   return Get.defaultDialog(
  //       title: labels.information,
  //       middleText: labels.wantDeletePhoto,
  //       actions: [
  //         RaisedButton(onPressed: (){
  //           Get.back();
  //         },
  //           child: Text(labels.cancel,style: TextStyle(color: backgroundIconColor,fontWeight: FontWeight.bold),),
  //           color: Colors.white,
  //         ),
  //         maintenanceRequestModel.state=='done'||maintenanceRequestModel.state=='approve'||
  //             maintenanceRequestModel.state=='approved'||maintenanceRequestModel.state=='submit'?
  //         SizedBox():
  //         RaisedButton(onPressed: (){
  //           Get.back();
  //           showOptions(maintenanceRequestModel.id,from);

  //         },
  //           child: Text(labels.edit,style: TextStyle(color:Colors.white),),
  //           color: Colors.red,
  //         ),
  //         RaisedButton(onPressed: () async{
  //           Get.back();
  //           await showDialog(
  //               context: context,
  //               builder: (_) => ImageDialog(
  //                 bytes: bytes,
  //               ));
  //         },
  //           child: Text(labels.view,style: TextStyle(color:Colors.white),),
  //           color: backgroundIconColor,
  //         ),
  //       ]
  //   );
  // }
}

