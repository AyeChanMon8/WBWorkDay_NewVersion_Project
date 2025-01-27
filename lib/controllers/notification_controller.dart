
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../models/notification_msg.dart';
import '../services/notification_service.dart';
import '../utils/app_utils.dart';

class NotificationController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var formatter = new NumberFormat("#,###");
  static NotificationController to = Get.find();
  TextEditingController searchTxt = new TextEditingController();
  final RxList<NotificationMsg> notificationList = <NotificationMsg>[].obs;
  NotificationService? notificationService;
  final store = GetStorage();
  var countMsg = 0.obs;
  var unReadMsgCount = 0.obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  @override
  void onReady() async {
    super.onReady();
    this.notificationService = await NotificationService().init() as NotificationService;
  }

  void retrieveMsgs() async {
    try {
      if (this.notificationService == null) {
        this.notificationService = await NotificationService().init() as NotificationService;
      }
      String partnerId = store.read('emp_id');

      await this.notificationService?.retrieveAllNotification(partnerId).then((data){
        unReadMsgCount.value = data;
        print("unReadMsgCount");
        print(data);
        this.notificationService?.retrieveNotificationMessages(partnerId,offset.toString()).then((data){
          isLoading.value = false;
          if(offset!=0){
            //this.notificationList.addAll(data);
            // data.forEach((element) {
            //   notificationList.add(element);
            // });
            for(var i=0;i<data.length;i++){
              notificationList.add(data[i]);
            }
          }else{
            this.notificationList.value = data;
          }

        });
      });

      // this.notificationList.value = await this
      //     .notificationService
      //     .retrieveNotificationMessages(partnerId,offset.toString());
      // countMsg.value = notificationList.length;
      // countUnReadMessage();
      //  this.notificationService
      //     .retrieveAllNotification(partnerId).then((data){
      //    print("unreadMessage#");
      //    print(data);
      //  });
      // update();


    } catch (error) {
      // Get.snackbar("Error ", "Error , $error");
      Get.snackbar('Alert', 'Network connection fail \nPlease, try again');
    }
  }

  int countUnReadMessage() {
    int unreadMsg = 0;
    for (NotificationMsg msg in this.notificationList) {

      if (!msg.has_read) {
        unreadMsg++;
      }
    }

    unReadMsgCount.value = unreadMsg;
    return unreadMsg;
  }

  readMsg(NotificationMsg msg, int index) async {
    String partnerId = store.read('emp_id');
    msg = await this.notificationService!.updateNotificationMsg(msg);
    msg.has_read = true;
    msg.selected = false;
    this.notificationList[index] = msg;
    this.notificationService?.retrieveAllNotification(partnerId).then((data){
      unReadMsgCount.value = data;
    });
    //countUnReadMessage();
    update();
  }
   void deleteConfirm(){
     AppUtils.showConfirmCancelDialog('Warning', 'Are you sure?', () async {
       notificationList.forEach((element) {
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
       for(int index = 0 ; index< notificationList.length;index++){
         print(notificationList[index].selected);
         if(notificationList[index].selected)
           deleteMsg(
               notificationList[index],
               index);
       }
       Get.back();

     },() async{
       // notificationList.forEach((element) {
       //   element.selected = false;
       // });
     });

   }
  void deleteMsg(NotificationMsg msg, int index) async {
    String partnerId = store.read('emp_id');
    notificationList.removeAt(index);
    bool status = await this.notificationService!.deleteNotificationMsg(msg);
    if (status) {
      // notificationList.removeAt(index);
      countMsg.value = notificationList.length;
      this.notificationService?.retrieveAllNotification(partnerId).then((data){
        Get.back();
        unReadMsgCount.value = data;
      });
      //countUnReadMessage();
      update();
    }
  }
}
