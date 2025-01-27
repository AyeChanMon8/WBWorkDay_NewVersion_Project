import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/calendar_data.dart';
import '../pages/calendar_page.dart';
import '../services/calendar_service.dart';

class CalendarControllers extends GetxController{
  CalendarService? calendarService;
  var calendarData = CalendarData();
  var source = DataSource([]).obs;
  final box = GetStorage();
  @override
  void onInit() async{
    super.onInit();
    this.calendarService =await CalendarService().init();
    getCalendarData();
  }
  getCalendarData(){
    var appointmentsList = <Appointment>[];
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    var employee_id = int.tryParse(box.read('emp_id'));
    calendarService?.getCalendarInformation(employee_id!).then((calendardata){
      calendarData = calendardata as CalendarData;
      for(Travel travel in calendarData.travel!){
        appointmentsList.add(Appointment(
          subject: travel.name,
          startTime: DateTime.parse(travel.startDate),
          endTime: DateTime.parse(travel.endDate),
          color: Colors.orange,
          isAllDay: false,
        ));
      }
      for(Travel travel in calendarData.leave!){
        StringBuffer sb = new StringBuffer();
        if(travel.purpose.isEmpty){
          sb.write(travel.name);
        }else{
          sb.write(travel.name +"/ "+travel.purpose);
        }
        appointmentsList.add(Appointment(
          // subject: travel.name.replaceAll(' ', '_')+" /(Purpose)"+travel.purpose.toString()+"Illness",
          subject: sb.toString(),
          notes: travel.purpose.toString(),
          startTime: DateTime.parse(travel.startDate),
          endTime: DateTime.parse(travel.endDate),
          color: Colors.red,
          isAllDay: true,
        ));
      }
      for(Travel travel in calendarData.training!){
        appointmentsList.add(Appointment(
          subject: travel.name,
          startTime: DateTime.parse(travel.startDate),
          endTime: DateTime.parse(travel.endDate),
          color: Colors.blue,
          isAllDay: false,
        ));
      }
      for(Travel travel in calendarData.tripBill!){
        appointmentsList.add(Appointment(
          subject: travel.name,
          startTime: DateTime.parse(travel.startDate),
          endTime: DateTime.parse(travel.endDate),
          color: Colors.green,
          isAllDay: false,
        ));
      }
      for(Travel travel in calendarData.tripProduct!){
        appointmentsList.add(Appointment(
          subject: travel.name,
          startTime: DateTime.parse(travel.startDate),
          endTime: DateTime.parse(travel.endDate),
          color: Colors.cyan,
          isAllDay: false,
        ));
      }
      for(Travel pms in calendarData.pms!){
        appointmentsList.add(Appointment(
          subject: pms.name,
          startTime: DateTime.parse(pms.startDate),
          endTime: DateTime.parse(pms.endDate),
          color: Colors.blueGrey,
          isAllDay: false,
        ));
      }
      for(Travel attendance in calendarData.attendance!){
        appointmentsList.add(Appointment(
          subject: attendance.name,
          startTime: DateTime.parse(attendance.startDate),
          endTime: DateTime.parse(attendance.endDate),
          color: Colors.purple,
          isAllDay: false,
        ));
      }
      for(Travel dayTrip in calendarData.dayTrip!){
        appointmentsList.add(Appointment(
          subject: dayTrip.name,
          startTime: DateTime.parse(dayTrip.startDate),
          endTime: DateTime.parse(dayTrip.endDate),
          color: Colors.indigo,
          isAllDay: false,
        ));
      }
      // for(Travel travel in calendarData.calendar){
      //   appointmentsList.add(Appointment(
      //     subject: travel.name,
      //     startTime: DateTime.parse(travel.startDate),
      //     endTime: DateTime.parse(travel.endDate),
      //     color: Colors.cyan,
      //     isAllDay: false,
      //   ));
      // }
      source.value = DataSource(appointmentsList);
      Get.back();
    });
  }
}