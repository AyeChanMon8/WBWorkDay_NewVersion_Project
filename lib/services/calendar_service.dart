import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../constants/globals.dart';
import '../models/calendar_data.dart';
import '../utils/app_utils.dart';
import 'odoo_service.dart';

class CalendarService extends OdooService{
  Dio dioClient = Dio();
  @override
  Future<CalendarService> init() async {
    print('AttendanceService has been initialize');
    dioClient = await client();
    return this;
  }
  Future<CalendarData> getCalendarInformation(int empId)async{
    var calendarData;
    String start_date = AppUtils.onemonthago().toString().split(' ')[0];
    String end_date = AppUtils.onemonthpre().toString().split(' ')[0];
    var current_date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    String url = Globals.baseURL+"/summary.request/388/get_employee_calendar_date_new";

    // Response response = await dioClient.put(url,data: jsonEncode({"employee_id": empId, "start_date": start_date,"end_date":end_date}));
    Response response = await dioClient.put(url,data: jsonEncode({"employee_id": empId, "start_date": start_date,"end_date":end_date,"current_date":current_date}));

    if(response.statusCode == 200){
       calendarData = CalendarData.fromMap(response.data);
    }

    return calendarData;
  }
}