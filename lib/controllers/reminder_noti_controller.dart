import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/models/notification_msg.dart';
import 'package:winbrother_hr_app/models/reminder.dart';
import 'package:winbrother_hr_app/services/employee_service.dart';
import 'package:winbrother_hr_app/services/reminder_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class ReindersNotiController extends GetxController {
  final ScrollController scrollController = ScrollController();
  ReminderNotiService? reminderNotiService;
  var reminderList = <Reminder>[].obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var offset = 0.obs;
  final store = GetStorage();
  var countMsg = 0.obs;
  var unReadMsgCount = 0.obs;

  @override
  void onReady() async {
    super.onReady();
    this.reminderNotiService = await ReminderNotiService().init();
    getRemindersList();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void getRemindersList() async {
    try {
      if (this.reminderNotiService == null) {
        this.reminderNotiService = await ReminderNotiService().init();
      }
      String partnerId = store.read('emp_id');

      await this
          .reminderNotiService
          ?.retrieveAllReminders(partnerId)
          .then((data) {
        unReadMsgCount.value = data;
        print("unReadMsgCount");
        print(data);
        this
            .reminderNotiService!
            .reminder(partnerId, offset.toString())
            .then((data) {
          isLoading.value = false;
          if (offset != 0) {
            data.forEach((element) {
              reminderList.add(element);
            });
          } else {
            reminderList.value = data;
          }
          update();
          print("reminder List >>>" + this.reminderList.length.toString());
        });
      });
    } catch (error) {
      Get.snackbar('Alert', 'Network connection fail !\nPlease, try again');
    }
  }

  // void getRemindersList() async {
  //   try {
  //     if (this.reminderNotiService == null) {
  //       this.reminderNotiService = await ReminderNotiService().init();
  //     }
  //     var employee_id = box.read('emp_id');
  //     Future.delayed(
  //         Duration.zero,
  //             () => Get.dialog(
  //             Center(
  //                 child: SpinKitWave(
  //                   color: Color.fromRGBO(63, 51, 128, 1),
  //                   size: 30.0,
  //                 )),
  //             barrierDismissible: false));
  //     // fetch emp_id from GetX Storage
  //     await reminderNotiService
  //         .reminder(employee_id,offset.toString())
  //         .then((data) {
  //           if(offset!=0){
  //             isLoading.value = false;
  //             data.forEach((element) {
  //               reminderList.add(element);
  //             });
  //           }else{
  //             reminderList.value = data.toList();
  //           }
  //           update();
  //           Get.back();
  //     });
  //   } catch (error) {
  //     print(error);
  //     Get.snackbar("Error ", "Error , $error");
  //   }
  // }

  readMsg(Reminder msg, int index) async {
    String partnerId = store.read('emp_id');
    msg = await reminderNotiService!.updateNotificationMsg(msg);
    msg.has_read = true;
    msg.selected = false;
    reminderList[index] = msg;
    reminderNotiService?.retrieveAllReminders(partnerId).then((data) {
      unReadMsgCount.value = data;
    });
    update();
  }

  void deleteConfirm() async {
    AppUtils.showConfirmCancelDialog('Warning', 'Are you sure?', () async {
      reminderList.forEach((element) {
        element.selected = true;
      });
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      String partnerId = store.read('emp_id');
      //  for(int index = 0 ; index< reminderList.length;index++){
      //    print(reminderList[index].selected);
      //    if(reminderList[index].selected)
      //      deleteMsg(
      //          reminderList[index],
      //          index);
      //  }
      List<dynamic> deleteData = [];
      for (int index = 0; index < reminderList.length; index++) {
        if (reminderList[index].selected)
          deleteData.add(reminderList[index].noti_id);
      }
      List<int> notiList = deleteData.cast<int>();
      if (notiList.length > 0) {
        deleteReminderListMsg(notiList);
      }

      Get.back();
    }, () async {
      // notificationList.forEach((element) {
      //   element.selected = false;
      // });
    });
  }

  //  void deleteMsg(Reminder msg, int index) async {
  //   String partnerId = store.read('emp_id');

  //   bool status = await this.reminderNotiService.deleteNotificationMsg(msg);
  //   if (status) {
  //     reminderList.removeAt(index);
  //     countMsg.value = reminderList.length;
  //     this.reminderNotiService.retrieveAllReminders(partnerId).then((data){
  //       Get.back();
  //       unReadMsgCount.value = data;
  //     });
  //     //countUnReadMessage();
  //     update();
  //   }
  // }

  void deleteReminderListMsg(List<int> deleteData) async {
    String partnerId = store.read('emp_id');
    bool status =
        await reminderNotiService?.deleteReminderNotificationMsg(deleteData);
    if (status) {
      // reminderList.removeAt(index);
      for (var i = 0; i < deleteData.length; i++) {
        reminderList.removeWhere((item) => item.noti_id == deleteData[i]);
      }
      countMsg.value = reminderList.length;
      reminderNotiService?.retrieveAllReminders(partnerId).then((data) {
        Get.back();
        unReadMsgCount.value = data;
      });
      update();
    }
  }

  void deleteMsg(Reminder msg, int index) async {
    String partnerId = store.read('emp_id');
    bool status = await reminderNotiService?.deleteNotificationMsg(msg);
    if (status) {
      // reminderList.removeAt(index);
      reminderList.removeWhere((item) => item.noti_id == msg.noti_id);
      countMsg.value = reminderList.length;
      reminderNotiService?.retrieveAllReminders(partnerId).then((data) {
        Get.back();
        unReadMsgCount.value = data;
      });
      update();
    }
  }
}
