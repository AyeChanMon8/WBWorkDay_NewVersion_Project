import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../models/reminder.dart';
import '../utils/app_utils.dart';

import 'odoo_service.dart';

class ReminderNotiService extends OdooService {
  Dio dioClient = Dio();
  String url = Globals.baseURL + "/one.signal.notification.message";
  @override
  Future<ReminderNotiService> init() async {
    print('ReminderNotiService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<List<Reminder>> reminder(String id, String offset) async {
    String url = Globals.baseURL + "/hr.employee/1/get_reminder_ids";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(id)}));
    List<Reminder> reminderList = <Reminder>[];
    if (response.statusCode == 200) {
      var data = response.data;
      if (response.data.length != 0) {
        data.forEach((v) {
          reminderList.add(Reminder.fromMap(v));
        });
      }
    }
    if (reminderList.length > 2) {
      reminderList.sort((a, b) {
        DateTime? bDateTime = AppUtils.convertStringToDate(b.create_date);
        DateTime? aDateTime = AppUtils.convertStringToDate(a.create_date);
        return bDateTime!.compareTo(aDateTime!);
      });
    }
    return reminderList;
  }

  Future<Reminder> updateNotificationMsg(Reminder msg) async {
    int id = msg.noti_id;
    String updateUrl = url + "/$id";
    Response response = await dioClient.put(updateUrl,
        data: jsonEncode({
          'has_read': 't',
        }));
    if (response.statusCode == 200) {
      msg.has_read = true;
    }
    return msg;
  }

  Future<int> retrieveAllReminders(String partnerId) async {
    List<Reminder> msgs = <Reminder>[];
    int unreadCount = 0;
    try {
      String datebefore = AppUtils.onemonthago();
      // String filter = "[['employee_id', '=',$partnerId],['create_date','>=','$datebefore'],['message_type','!=','announcement']]";
      String urlData = url +
          "?filters=[['employee_id', '=',$partnerId],['create_date','>=','$datebefore'],['has_read','!=','t'],['message_type','=','reminder']]&order=write_date desc";
      Response response = await dioClient.get(urlData);

      if (response.statusCode == 200) {
        unreadCount = response.data['count'];
      }
    } catch (error) {
      print(error);
    }

    return unreadCount;
  }

  deleteNotificationMsg(Reminder msg) async {
    int id = msg.noti_id;
    bool status = false;
    String updateUrl = url + "/$id";
    Response response = await dioClient.delete(updateUrl);
    if (response.statusCode == 200) {
      status = true;
    }
    return status;
  }

  deleteReminderNotificationMsg(List<int> deleteData) async {
    bool status = false;
    String url = Globals.baseURL + "/hr.employee/1/delete_reminder_noti_ids";

    Response response =
        await dioClient.put(url, data: jsonEncode({'notiIds': deleteData}));
    if (response.statusCode == 200) {
      status = true;
    }
    return status;
  }
}
