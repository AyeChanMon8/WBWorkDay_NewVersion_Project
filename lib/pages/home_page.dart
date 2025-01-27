
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:rxdart/rxdart.dart';
import '../controllers/announcements_controller.dart';
import '../controllers/notification_controller.dart';
import '../controllers/reminder_controller.dart';
import '../controllers/reminder_noti_controller.dart';
import '../controllers/user_profile_controller.dart';
// import '../localization.dart';
import '../models/home_function.dart';
import '../routes/app_pages.dart';
import '../tools/internet_provider.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/drawer.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<HomePage> {
  final box = GetStorage();
  String image = '';
  String _debugLabelString = "";
  bool _enableConsentButton = false;
  UserProfileController controller = Get.put(UserProfileController());
  final NotificationController notiController = Get.put(
    NotificationController(),
  );
  final AnnouncementsController announcementsController = Get.put(
    AnnouncementsController(),
  );
  final ReindersNotiController remindersNotiController = Get.put(
    ReindersNotiController(),
  );
  @override
  void initState(){
    //TODO one signal need to test.
    super.initState();
    initPlatformState();
    notiController.retrieveMsgs();
    announcementsController.onReady();
    remindersNotiController.onReady();
    //_handleSetExternalUserId();
  }

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // ignore: close_sinks
  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  // void _handleSendNotification() async {
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();

  //   var imgUrlString =
  //       "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

  //   var notification = OSCreateNotification(
  //       content: "this is a test from OneSignal's Flutter SDK",
  //       heading: "Test Notification",
  //       iosAttachments: {"id1": imgUrlString},
  //       bigPicture: imgUrlString,
  //       buttons: [
  //         OSActionButton(text: "test1", id: "id1"),
  //         OSActionButton(text: "test2", id: "id2")
  //       ]);

  //   var response = await OneSignal.shared.postNotification(notification);

  //   this.setState(() {
  //     _debugLabelString = "Sent notification with response: $response";
  //   });

  //   final NotificationAppLaunchDetails notificationAppLaunchDetails =
  //       await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('ic_stat_onesignal_default');

  //   /// Note: permissions aren't requested here just to demonstrate that can be
  //   /// done later
  //   final IOSInitializationSettings initializationSettingsIOS =
  //       IOSInitializationSettings(
  //           requestAlertPermission: false,
  //           requestBadgePermission: false,
  //           requestSoundPermission: false,
  //           onDidReceiveLocalNotification:
  //               (int id, String title, String body, String payload) async {});
  //   const MacOSInitializationSettings initializationSettingsMacOS =
  //       MacOSInitializationSettings(
  //           requestAlertPermission: false,
  //           requestBadgePermission: false,
  //           requestSoundPermission: false);
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //           android: initializationSettingsAndroid,
  //           iOS: initializationSettingsIOS,
  //           macOS: initializationSettingsMacOS);
  // }

  // showNotification(var msg) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //           'your channel id', 'your channel name', 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   // const NotificationDetails platformChannelSpecifics =
  //   // NotificationDetails(android: androidPlatformChannelSpecifics);
  //   // await flutterLocalNotificationsPlugin.show(
  //   //     0, 'plain title', 'plain body', platformChannelSpecifics,
  //   //     payload: 'item x');
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    // OneSignal.shared.init("4c80054e-15be-477a-a792-3a3e16072ac5", iOSSettings: {
    //   OSiOSSettings.autoPrompt: true,
    //   OSiOSSettings.inAppLaunchUrl: false
    // });
    OneSignal.shared.setAppId("958cdaa9-2850-48d9-9d97-51bf14f69a78");
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    String empId = box.read('emp_id');

    OneSignal.shared.setExternalUserId(empId);

    //OneSignal.shared.init(Globals.APP_ID, iOSSettings: settings);

    // OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
    await OneSignal.shared.setLocationShared(true);

    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //   this.setState(() {
    //     //TODO put data to one of controller for notification messages.
    //     _debugLabelString =
    //         "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    //     var data = notification.payload.additionalData;
    //     String message =
    //     notification.jsonRepresentation().replaceAll("\\n", "\n");

    //     print("message:$message");
    //     String message_type = null;
    //     Map<String, dynamic> dataMap = notification.payload.additionalData;
    //     if (dataMap != null && dataMap.length > 0) {
    //       message_type = dataMap["type"];
    //       print("message_type : $message_type");
    //     }

    //     if (message_type != null && message_type == "noti") {
    //       notiController.retrieveMsgs();
    //       String title = notification.payload.title;
    //       String body = notification.payload.body;
    //       Get.snackbar("Notification $title", body);
    //     }
    //     print("setNotificationReceivedHandler");
    //     print("message:$message");
    //   });
    // });

    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
      this.setState(() {
        _debugLabelString =
            "Received notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
        var data = event.notification.additionalData;
        String message =
        event.notification.jsonRepresentation().replaceAll("\\n", "\n");

        String message_type = '';
        Map<String, dynamic>? dataMap = event.notification.additionalData;
        if (dataMap != null && dataMap.length > 0) {
          message_type = dataMap["type"];
        }

        if (message_type != null && message_type == "noti") {
          notiController.retrieveMsgs();
          String title = event.notification.title!;
          String body = event.notification.body!;
          Get.snackbar("Notification $title", body);
        }
      });
        event.complete(event.notification);                                 
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        announcementsController.getAnnouncementsList();
        _debugLabelString =
            "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      this.setState(() {
        _debugLabelString =
            "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    // String partnerId = store.read(Globals.PARTNER_ID);

    // OneSignal.shared.setExternalUserId(partnerId).then((results) {
    //   if (results == null) {
    //     print(results);
    //     return;
    //   }
    //   this.setState(() {
    //     _debugLabelString = "External user id set: $results";
    //   });
    // });

    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });
  }

  void _handleSetExternalUserId() {
    String partnerId = box.read("emp_id");
    OneSignal.shared.setExternalUserId(partnerId).then((results) {
      if (results == null) return;
      this.setState(() {
        _debugLabelString = "External user id set: $results";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    image = box.read('emp_image');
    final labels = AppLocalizations.of(context);
    // if (context != null) {
    //   InternetProvider.of(context);
    // }
    bool isInternet = true;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: backgroundIconColor,
        title: Text(
          labels!.home,
          style: appbarTextStyle(),
        ),
        iconTheme: drawerIconColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8.0),
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  const Color.fromRGBO(216, 181, 0, 1),
                  const Color.fromRGBO(231, 235, 235, 1)
                ],
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.PROFILE_PAGE);
            },
            child: Container(
              padding: EdgeInsets.only(right: 5),
              child: Obx(()=>CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: controller.emp_base64.value != null&&controller.emp_base64.value.isNotEmpty
                      ? Image.memory(
                    base64Decode(controller.emp_base64.value),
                    fit: BoxFit.cover,
                    scale: 0.1,
                    height: 40,
                    width: 40,
                  )
                      : new Container(),
                ),
              )),
            ),
          ),
        ],
      ),
      // appBar: appbar(context, (labels?.home), image),
      /*  appBar: AppBar(
        flexibleSpace:  Container(
          color: Color(0xFF3F455F),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Color(0xFFD8B707),
                ),
              ),
            ],
          ),
        ),
      ),*/
      drawer: DrawerPage(),
      body: isInternet
          ? buildDashboard(context)
          : Container(
              color: Colors.white,
              child: Center(child: Text(("no_internet"))),
            ),
    );
  }

  Widget buildDashboard(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    color: Color(0xFF3F455F),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Color(0xFFD8B707),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: 30, left: 10, bottom: 20, right: 80),
                          child: controller.empData.value.name != null
                              ? AutoSizeText(
                                  labels!.welcome + " ${controller.empData.value.name}",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25))
                              : AutoSizeText(labels!.welcome,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                  // Positioned(
                  //   top: 0,
                  //   right: 0,
                  //   bottom: 0,
                  //   child: Container(
                  //     margin: EdgeInsets.only(right: 40),
                  //     padding: EdgeInsets.only(right: 5),
                  //     child: Obx(
                  //       () => CircleAvatar(
                  //         backgroundColor: Colors.transparent,
                  //         child: ClipRRect(
                  //           borderRadius: new BorderRadius.circular(50.0),
                  //           child: controller.empData.value.image_128 != null
                  //               ? new Image.memory(
                  //                   base64Decode(
                  //                       controller.empData.value.image_128),
                  //                   fit: BoxFit.cover,
                  //                   scale: 0.1,
                  //                   height: 40,
                  //                   width: 40,
                  //                 )
                  //               : new Container(),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              recentUsedWidget(context),
              SizedBox(
                height: 10,
              ),
              notificationsWidget(context),
              SizedBox(
                height: 20,
              ),
              announcementsWidget(context),
              SizedBox(
                height: 20,
              ),
              remindersWidget(context),
              // SizedBox(
              //   height: 20,
              // ),
              // notificationWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  bool initialized = false;
  var home = [];
  HomeFunctionList functionList = HomeFunctionList();

  Widget recentUsedWidget(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final _screenWidth = _mediaQueryData.size.width;
    final _screenHeight = _mediaQueryData.size.height;
    final labels = AppLocalizations.of(context);
    var storage = LocalStorage('storefunction');

    return StreamBuilder(
        stream: Stream.fromFuture(storage.ready),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!initialized) {
            home = storage.getItem('home_function');
          }

          if (home == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            /*functionList.items = List<HomeFunction>.from(
              home.map(
                    (item) => HomeFunction(
                   item['iconData'],
                      item['label'],
                      item['routeName'],
                      item['check'],
                ),
              ),
            );*/
            return Container(
              margin: EdgeInsets.only(left: 0, right: 0),
              child: Card(
                elevation: 1,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2,
                      crossAxisSpacing: 0.9,
                      mainAxisSpacing: 0.5,
                      crossAxisCount: 2,
                    ),
                    itemCount: home.length,
                    itemBuilder: (context,index) =>
                        Card(
                          elevation: 0,
                          child: Container(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                  Color.fromRGBO(58, 47, 112, 1),
                                  radius: 20,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                       IconDataSolid(home[index][0]),
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      Get.toNamed(home[index][2]);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: AutoSizeText(
                                    (home[index][1]),
                                    style: labelStyle(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                  )
                  ),
                ),
            );
          }
        });
  }
  
  Widget remindersWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    final ReindersNotiController controller =
        Get.put(ReindersNotiController());
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 2,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text((labels!.reminders), style: maintitleStyle()),
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 30,
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.REMINDERS_LIST);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(labels.allReminders, style: subtitleStyle()),
                      Row(
                        children: [
                          Container(
                            child: Text(controller.unReadMsgCount.toString()
                                .toString(),style: TextStyle(color: Colors.white),),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                          ),
                          arrowforwardIcon
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget announcementsWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    int announcementNo;
    final AnnouncementsController controller =
        Get.put(AnnouncementsController());
    if (controller.announcementList.value.length < 3) {
      announcementNo = controller.announcementList.value.length;
    } else {
      announcementNo = 3;
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 2,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text((labels!.announcements), style: maintitleStyle()),
              ),
              Divider(
                thickness: 1,
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 20),
              //   child: ListView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: announcementNo,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Column(
              //         children: [
              //           Obx(
              //             () => Container(
              //               child: InkWell(
              //                 onTap: () {
              //                   // Navigator.push(
              //                   //     context,
              //                   //     MaterialPageRoute(
              //                   //         builder: (context) =>
              //                   //             AnnouncementsDetails()));
              //                   Get.toNamed(Routes.ANNOUNCEMENTS_DETAILS,
              //                       arguments: index);
              //                 },
              //                 child: ListTile(
              //                     // leading: CircleAvatar(
              //                     //   backgroundColor:
              //                     //       Color.fromRGBO(216, 181, 0, 1),
              //                     //   child: ClipRRect(
              //                     //     borderRadius:
              //                     //         new BorderRadius.circular(50.0),
              //                     //     child: Image.network(
              //                     //       "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
              //                     //       fit: BoxFit.contain,
              //                     //     ),
              //                     //   ),
              //                     // ),
              //                     // leading:
              //                     title: Text(
              //                       controller.announcementList.value[index]
              //                           .announcement_reason,
              //                     ),
              //                     subtitle: Text(controller.announcementList
              //                         .value[index].company_id.name),
              //                     trailing: arrowforwardIcon),
              //               ),
              //             ),
              //           ),
              //           Divider(
              //             thickness: 1,
              //           ),
              //         ],
              //       );
              //     },
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(
                  left: 30,
                ),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             AnnouncementsDetails()));
                    Get.toNamed(Routes.ANNOUNCEMENTS_LIST);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(labels.allAnnouncements, style: subtitleStyle()),
                      Row(
                        children: [
                          Container(
                            child: Text(controller.announcementList.value.length
                                .toString(),style: TextStyle(color: Colors.white),),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                          ),
                          arrowforwardIcon
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget notificationsWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 2,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  labels!.notifications,
                  style: maintitleStyle(),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.NOTIFICATION_LIST);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(labels!.allNotifications, style: subtitleStyle()),
                      Row(
                        children: [
                          Obx(()=>
                          Container(child: Text(notiController.unReadMsgCount.toString(),style: TextStyle(color: Colors.white),),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                              shape: BoxShape.circle,
                              border:Border.all(
                                color: Colors.white,
                                width: 2,
                              )
                          ),
                          )
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.moveTo(size.width - 30, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
