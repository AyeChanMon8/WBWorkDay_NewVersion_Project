import 'dart:convert';
import 'package:dio/dio.dart';
import '../constants/globals.dart';
import '../models/notification_msg.dart';
import '../utils/app_utils.dart';

import 'odoo_service.dart';

class NotificationService extends OdooService {
  String url = Globals.baseURL + "/one.signal.notification.message";
  Dio dioClient = Dio();
  Future<OdooService> init() async {
    dioClient = await client();
    return this;
  }

  Future<NotificationMsg> updateNotificationMsg(NotificationMsg msg) async {
    int id = msg.id;
    String updateUrl = url + "/$id";
    Response response = await dioClient!.put(updateUrl,
        data: jsonEncode({
          'has_read': 't',
        }));
    if (response.statusCode == 200) {
      msg.has_read = true;
    }
    return msg;
  }

  deleteNotificationMsg(NotificationMsg msg) async {
    int id = msg.id;
    bool status = false;
    String updateUrl = url + "/$id";
    Response response = await dioClient!.delete(updateUrl);
    if (response.statusCode == 200) {
      status = true;
    }
    return status;
  }
  Future<List<NotificationMsg>> retrieveNotificationMessages(
      String partnerId,String offset) async {
    List<NotificationMsg> msgs = <NotificationMsg>[];
    try {

      String datebefore = AppUtils.onemonthago();
      // String filter = "[['employee_id', '=',$partnerId],['create_date','>=','$datebefore'],['message_type','!=','announcement']]";
      String urlData = url +
          "?filters=[['employee_id', '=',$partnerId],['create_date','>=','$datebefore'],['message_type','!=','reminder']]&order=write_date desc";

      Response response =
      await dioClient!.get(urlData);
      if (response.statusCode == 200) {
        var list = response.data['results'];
        if (list.length > 0) {
          list.forEach((v) {
            msgs.add(NotificationMsg.fromMap(v));
          });
        }
      }
      if (msgs.length > 2) {
        msgs.sort((a, b) {
          DateTime? bDateTime = AppUtils.convertStringToDate(b.create_date);
          DateTime? aDateTime = AppUtils.convertStringToDate(a.create_date);
          return bDateTime!.compareTo(aDateTime!);
        });
      }
    } catch (error) {
      print(error);
    }
    return msgs;
  }
  Future<int> retrieveAllNotification(
      String partnerId) async {
    List<NotificationMsg> msgs = <NotificationMsg>[];
    int unreadCount = 0;
    try {

      String datebefore = AppUtils.onemonthago();
     // String filter = "[['employee_id', '=',$partnerId],['create_date','>=','$datebefore'],['message_type','!=','announcement']]";
      String urlData = url +
          "?filters=[['employee_id', '=',$partnerId],['create_date','>=','$datebefore'],['has_read','!=','t'],['message_type','!=','reminder']]&order=write_date desc";
      Response response =
          await dioClient!.get(urlData);

      if (response.statusCode == 200) {
        unreadCount = response.data['count'];
      }

    } catch (error) {
      print(error);
    }

    return unreadCount;
  }
  int countUnReadMessage(List<NotificationMsg> notificationList) {
    int unreadMsg = 0;
    for (NotificationMsg msg in notificationList) {
      print("state");
      print(msg.has_read);
      if (!msg.has_read) {
        unreadMsg++;
      }
    }
    return unreadMsg;
  }
}
