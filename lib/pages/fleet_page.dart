

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../controllers/FleetController.dart';
// import '../localization.dart';
import '../models/fleet_insurance.dart';
import '../models/fleet_model.dart';
import '../models/fuel_log_model.dart';
import '../models/fuel_tank.dart';
import '../models/maintenance_request_model.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../ui/components/web_container.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FleetPage extends StatefulWidget {
  @override
  _FleetPageState createState() => _FleetPageState();
}

class _FleetPageState extends State<FleetPage> {
  final FleetController controller = Get.find();
  var box = GetStorage();
    var formatter = new NumberFormat("###,###", "en_US");
  String image = '';
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: appbar(context, labels!.fleet,image)),
      body: SingleChildScrollView(
        child:Obx(()=> controller.fleetModel.value.name !=null ? Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.only(top:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: controller.fleetModel.value.image128 == "" ? Container(): Image.memory(base64Decode(controller.fleetModel.value.image128??"")))
                ),
                SizedBox(height: 10,),
                Center(
                  child: Container(
                    child: Text(
                      controller.fleetModel.value.name,
                      style: maintitleStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    child: Text(
                      controller.fleetModel.value.licensePlate,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text(labels.currentOdometer,style: subtitleStyle(),),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(controller.fleetModel.value.odometer.toString() +" "+ controller.fleetModel.value.odometerUnit),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right:20.0),
                      child: Column(
                        children: [
                          Container(
                              child: CircleAvatar(
                                  backgroundColor: Colors.blueGrey,
                                  radius: circleAvatorRadius,
                                  child: IconButton(
                                    icon: Icon(Icons.map),
                                    onPressed: () {
                                      controller.getVehicleTraceUrl(controller.fleetModel.value.id).then((url){
                                        _handleURLButtonPress(context,url);
                                      });

                                    },
                                  ))),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(labels.trace),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:25.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text(labels.fuelConsumption,style: subtitleStyle(),),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Obx(()=>Text(controller.totalFuelConsumptionLiter.value.toStringAsFixed(2) +labels.liter),),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:25.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text(labels.fuelConsumptionRate,style: subtitleStyle(),),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Obx(()=>Text(
                              controller.consumptionRate.toStringAsFixed(2))),

                          )
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          labels.detailInformations,
                          // "Details Information",
                          style: maintitleStyle(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        title: Text(
                          labels.vehicle,
                          // "Vehicle",
                          style: subtitleStyle(),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: vehicleList(context),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Divider(
                        thickness: 1,
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      ExpansionTile(
                        title: Text(
                          labels.fuel,
                          style: subtitleStyle(),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: fuelLogList(context),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Divider(
                        thickness: 1,
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      ExpansionTile(
                        title: Text(
                          labels.fuelConsumption,
                          style: subtitleStyle(),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: fuelConsumptionList(context),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Divider(
                        thickness: 1,
                      ),

                      ExpansionTile(
                        title: Text(
                          labels.maintenanceLogs,
                          // "Maintenace Logs",
                          style: subtitleStyle(),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: maintenanceList(context),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Divider(
                        thickness: 1,
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      ExpansionTile(
                        title: Text(
                          labels.insuranceInformation,
                          // "Insurance Information",
                          style: subtitleStyle(),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: InsuranceList(context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ExpansionTile(
                        title: Text(
                          labels.fuelTank,
                          // "Vehicle",
                          style: subtitleStyle(),
                        ),
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child:Obx(()=>  Text(
                                    labels.totalAmount+' : '+NumberFormat('#,###').format(controller.totalFuelAmount.value).toString(),
                                    style: TextStyle(fontSize: 15),
                                    // "Vehicle",

                                  ),)


                                ),
                              ),


                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: const EdgeInsets.only(left:20.0),
                                    child:  Obx(()=>  Text(
                                      labels.totalLiter+' : '+NumberFormat('#,###').format(controller.totalLiter.value).toString(),
                                      style: TextStyle(fontSize: 15),
                                      // "Vehicle",

                                    ),)


                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child:Obx(()=>  Text(
                                    labels.avgPrice+' : '+NumberFormat('#,###').format(controller.totalUnitPrice.value).toString(),
                                    style: TextStyle(fontSize: 15),
                                    // "Vehicle",

                                  ),)


                              ),
                            ),
                          ),
                          ListTile(
                            title: fuelTankList(context),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ExpansionTile(
                        title: Text(
                          labels.tyredHistory,
                          style: subtitleStyle(),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: tyredList(context),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ) : Container(),
        ),
      ),
    );
  }
  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
  Widget InsuranceList(BuildContext context) {
    return Container(
        child:Obx(()=> ListView.builder(
            shrinkWrap: true,
            itemCount: controller.fleetInsuranceList.value.length,
            itemBuilder: (context,index){
              Fleet_insurance  insurance = controller.fleetInsuranceList.value[index];
              return InkWell(
                onTap: (){
                  Get.toNamed(Routes.FLEET_INSURANCE_DETAIL,arguments:controller.fleetInsuranceList.value[index] );
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(insurance.insuranceCompany,style: datalistStyle(),),
                        AutoSizeText(insurance.insuranceTypeId.name,style: datalistStyle(),),
                        AutoSizeText('${AppUtils.changeDateFormat(insurance.startDate)})} - ${AppUtils.changeDateFormat(insurance.endDate)}',style: datalistStyle(),),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ));
  }

  Widget maintenanceList(BuildContext context) {
    var labels = AppLocalizations.of(context);
    return Container(
        child:Obx(()=> ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.maintenanceList.value.length,
            itemBuilder: (context,index){
              Maintenance_request_model  maintenance_request_model = controller.maintenanceList.value[index];
              return InkWell(
                onTap: (){
                  //Get.toNamed(Routes.FLEET_INSURANCE_DETAIL,arguments:controller.fleetInsuranceList.value[index] );
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(labels!.name+' : ${maintenance_request_model.name}',style: datalistStyle(),),
                        AutoSizeText(labels.maintenanceType+' : ${maintenance_request_model.maintenanceType??''}',style: datalistStyle(),),
                        AutoSizeText(labels.maintenanceTeam+' : ${maintenance_request_model.maintenanceTeamId!.name??''}',style: datalistStyle(),),
                       maintenance_request_model.startDate != null && maintenance_request_model.endDate != null ? AutoSizeText('${AppUtils.changeDateFormat(maintenance_request_model.startDate!)} - ${AppUtils.changeDateFormat(maintenance_request_model.endDate!)}',style: datalistStyle(),) : AutoSizeText('${AppUtils.formatter.format(DateTime.parse(maintenance_request_model.requestDate!))}',style: datalistStyle(),),
                        RatingBar.builder(
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                          initialRating:
                          double.parse(maintenance_request_model.priority ?? '0'),
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
                  ),
                ),
              );
            }),
        ));
  }
  Widget fuelConsumptionList(BuildContext context) {
    var labels = AppLocalizations.of(context);
    return Container(
        child:Obx(()=> ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.fueComsumptionList.value.length,
            itemBuilder: (context,index){
              ConsumptionAverageHistory  fuelComsumptionModel = controller.fueComsumptionList.value[index];
              return InkWell(
                onTap: (){
                  //Get.toNamed(Routes.FLEET_INSURANCE_DETAIL,arguments:controller.fleetInsuranceList.value[index] );
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    margin: EdgeInsets.only(left:10,top:10,bottom:10,right:100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText(labels!.sourceDoc,style: datalistStylenotBold(),),
                              AutoSizeText('${fuelComsumptionModel.source_doc??''}',style: datalistStyle(),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText(labels!.consumptionLiter,style: datalistStylenotBold(),),
                            AutoSizeText('${fuelComsumptionModel.consumption_liter??''}',style: datalistStyle(),),
                          ],
                        ),
                        SizedBox(height: 10,),
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText(labels.consumptionAvg,style: datalistStylenotBold(),),
                              AutoSizeText('${fuelComsumptionModel.great_average==null?'':NumberFormat('#,###').format(double.tryParse(fuelComsumptionModel.great_average.toString()))}',style: datalistStyle(),),
                          ],
                        ),
                        SizedBox(height: 10,),
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(labels.odometer,style: datalistStylenotBold(),),
                            AutoSizeText('${AppUtils.addThousnadSperator(fuelComsumptionModel.odometer)??''}',style: datalistStyle(),),
                          ],
                        ),
                        SizedBox(height: 10,),
                       
                        
                        
                        
                      ],
                    ),
                  ),
                ),
              );
            }),
        ));
  }
  Widget tyredList(BuildContext context) {
    var labels = AppLocalizations.of(context);
    return Container(
        child:Obx(()=> ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.tiredList.value.length,
            itemBuilder: (context,index){
              TypredHistory  tyredModel = controller.tiredList.value[index];
              return InkWell(
                onTap: (){
                  //Get.toNamed(Routes.FLEET_INSURANCE_DETAIL,arguments:controller.fleetInsuranceList.value[index] );
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    margin: EdgeInsets.only(left:10,right:100,top:10,bottom:10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText(labels!.sourceDoc,style: datalistStyle(),),
                              AutoSizeText('${tyredModel.source_doc??''}',style: datalistStylenotBold(),),
                          ],
                        ), 
                        SizedBox(height:10),   
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText(labels.date,style: datalistStylenotBold(),),
                              AutoSizeText('${AppUtils.changeDateFormat(tyredModel.date)
                           ??''}',style: datalistStyle(),),
                          ],
                        ), 
                        SizedBox(height:10), 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText(labels!.usedPoint,style: datalistStylenotBold(),),
                              AutoSizeText('${
                           tyredModel.used_points==null?'':NumberFormat('#,###').format(double.tryParse(tyredModel.used_points.toString()))}',style: datalistStyle(),),
                          ],
                        ), 
                        SizedBox(height:10),  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText(labels.note,style: datalistStylenotBold(),),
                              AutoSizeText('${tyredModel.note??''}',style: datalistStyle(),),
                          ],
                        ), 
                        SizedBox(height:10),

                      ],
                    ),
                  ),
                ),
              );
            }),
        ));
  }
  Widget fuelLogList(BuildContext context) {
    return Container(
        child:Obx(()=> ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.fuelLogList.value.length,
            itemBuilder: (context,index){
              Fuel_log_model  fuelLogModel = controller.fuelLogList.value[index];
              return InkWell(
                onTap: (){
                  //Get.toNamed(Routes.FLEET_INSURANCE_DETAIL,arguments:controller.fleetInsuranceList.value[index] );
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    margin: EdgeInsets.only(left:10,right:100,top:10,bottom:10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText('Name ',style: datalistStylenotBold(),),
                              AutoSizeText('${fuelLogModel.shop??''}',style: datalistStyle(),),
                          ],
                        ),
                        SizedBox(height:10),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText('Liter',style: datalistStylenotBold(),),
                              AutoSizeText('${fuelLogModel.liter??''}',style: datalistStyle(),),
                          ],
                        ),
                       
                        SizedBox(height:10),
                         Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             AutoSizeText('Amount ',style: datalistStylenotBold(),),
                             AutoSizeText('${fuelLogModel.amount==null?'':NumberFormat('#,###').format(double.tryParse(fuelLogModel.amount.toString()))}',style: datalistStyle(),),
                          ],
                        ),
                       
                        
                       
                      ],
                    ),
                  ),
                ),
              );
            }),
        ));
  }

  Widget vehicleList(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(labels!.fuelType),
              ),
              Container(
                child: Text(controller.fleetModel.value.fuelType??''),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(labels.carNo),
              ),
              Container(
                child: Text(controller.fleetModel.value.licensePlate),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels!.immatriculationDate,
                ),
              ),
              Container(
                child: Text(
                  AppUtils.changeDateFormat(controller.fleetModel.value.acquisitionDate)
                ),
              )
            ],
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       child: Text(labels?.horsePower),
          //     ),
          //     Container(
          //       child: Text(controller.fleetModel.value.horsepower.toString()),
          //     )
          //   ],
          // ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(labels.chassisNo),
              ),
              Container(
                child: Text(controller.fleetModel.value.traccarUniqueID??''),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       child: Text(labels?.lastEngineOffTime),
          //     ),
          //     Container(
          //       child: Text(controller.fleetModel.value.lastEngineOff??''),
          //     )
          //   ],
          // ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(labels.model),
              ),
              Container(
                child: Text(controller.fleetModel.value.modelId!.name),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(labels.deviceID),
              ),
              Container(
                child: Text(controller.fleetModel.value.traccarUniqueID.toString()),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(labels.color),
              ),
              Container(
                child: Text(controller.fleetModel.value.color.toString()),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
  Widget fuelTankList(BuildContext context) {
    return Container(
        child:Obx(()=> ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.fuelTankList.value.length,
            itemBuilder: (context,index){
              Fuel_History  fuelLogModel = controller.fuelTankList.value[index];
              return InkWell(
                onTap: (){
                  //Get.toNamed(Routes.FLEET_INSURANCE_DETAIL,arguments:controller.fleetInsuranceList.value[index] );
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText('Date : ${fuelLogModel.filling_date==null?'':fuelLogModel.filling_date}',style: datalistStyle(),),
                        AutoSizeText('Source Doc : ${fuelLogModel.source_doc??''}',style: datalistStyle(),),
                        AutoSizeText('Fuel Liter : ${fuelLogModel.fuel_liter??''}',style: datalistStyle(),),
                        AutoSizeText('Price  : ${fuelLogModel.price_per_liter==null?'':NumberFormat('#,###').format(double.tryParse(fuelLogModel.price_per_liter.toString()))}',style: datalistStyle(),),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ));
  }

}
