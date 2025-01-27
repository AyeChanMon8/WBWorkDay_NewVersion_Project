import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:io' as Io;
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import '../controllers/documentation_controller.dart';
import '../controllers/user_profile_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/pdf_view.dart';
import '../routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  //UserProfileController controller = Get.put(UserProfileController());
  // TextEditingController idController = TextEditingController();
  final UserProfileController controller = Get.find();
  final DoucmentController dcontroller = Get.put(DoucmentController());
  int _value = 1;
  late File imageFile;
  bool keyboardOpen = false;
  final picker = ImagePicker();
  late String img64;
  late Uint8List bytes;
  final box = GetStorage();
  late File image;

  late String user_image;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    File image = File(pickedFile?.path ?? '');
    final bytes = Io.File(pickedFile?.path ?? "").readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(image, img64);
  }

  nullPhoto() {
    controller.isShowImage.value = false;
    controller.selectedImage.value = null;
  }

  Future getCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    File image = File(pickedFile!.path);
    final bytes = Io.File(pickedFile!.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(image, img64);
  }

  Widget _decideImageView() {
    if (!controller.isShowImage.value) {
      return Expanded(flex: 1, child: Text('No Image Selected!'));
    } else {
      return Image.file(imageFile, width: 50, height: 50);
    }
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

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    late Uint8List bytes;
    if (controller.empData.value.image_128 != null) {
      bytes = base64Decode(controller.empData.value.image_128);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundIconColor,
        title: Text(
          (labels!.profile),
          style: appbarTextStyle(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8.0),
          child: Container(
            padding: const EdgeInsets.all(2.5),
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
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 370,
                  width: double.infinity,
                  color: Color.fromRGBO(241, 249, 255, 1),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showOptions(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            right: 5,
                            top: 70,
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showOptions(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 100),
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Color.fromRGBO(60, 47, 126, 0.5),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                minRadius: 30,
                                maxRadius: 50,
                                child: ClipRRect(
                                  borderRadius: new BorderRadius.circular(50.0),
                                  child: bytes != null
                                      ? new Image.memory(
                                          // controller.selectedImage.value;
                                          bytes,
                                          fit: BoxFit.cover,
                                          scale: 0.5,
                                          height: 300,
                                          width: 300,
                                        )
                                      : new Container(),
                                ),
                                backgroundColor: Colors.blue[100],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          controller.empData.value == null
                              ? '-'
                              : controller.empData.value.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(60, 47, 126, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          controller.empData.value == null ||
                                  controller.empData.value.job_title == null
                              ? "-"
                              : controller.empData.value.job_title,
                          style: datalistStyle(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: controller.empData.value == null
                            ? Text("-")
                            : Text(controller.empData.value.department_id!.name,
                                style: datalistStyle()),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    child: CircleAvatar(
                                      maxRadius: 30,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
                                          child: Icon(
                                            Icons.contacts,
                                            size: 30,
                                            color:
                                                Color.fromRGBO(60, 47, 126, 1),
                                          )),
                                    ),
                                    // onTap: () => setState(() {
                                    //   _launched = _makePhoneCall('tel:$_phone');
                                    // }),
                                  ),
                                  padding: EdgeInsets.only(
                                    right: 5,
                                    top: 50,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(labels.contact,
                                      style: textfieldStyle()),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 5,
                                    top: 50,
                                  ),
                                  child: CircleAvatar(
                                    maxRadius: 30,
                                    backgroundColor: Colors.white,
                                    child: ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(50.0),
                                        child: Icon(
                                          Icons.people,
                                          size: 30,
                                          color: Color.fromRGBO(60, 47, 126, 1),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(labels.team,
                                      style: textfieldStyle()),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    child: CircleAvatar(
                                      maxRadius: 30,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
                                          child: Icon(
                                            Icons.timer,
                                            size: 30,
                                            color:
                                                Color.fromRGBO(60, 47, 126, 1),
                                          )),
                                    ),
                                    onTap: () {
                                      Get.toNamed(Routes.CALENDAR);
                                    },
                                  ),
                                  padding: EdgeInsets.only(
                                    right: 5,
                                    top: 50,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(labels.calendar,
                                      style: textfieldStyle()),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    child: CircleAvatar(
                                      maxRadius: 30,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
                                          child: Icon(
                                            FontAwesomeIcons.signOutAlt,
                                            size: 30,
                                            color:
                                                Color.fromRGBO(60, 47, 126, 1),
                                          )),
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => LoginPage()),
                                      // );

                                      // Get.toNamed(Routes.LOGIN);
                                      box.erase();
                                      Get.offAll(LoginPage());
                                    },
                                  ),
                                  padding: EdgeInsets.only(
                                    right: 5,
                                    top: 50,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(labels.logout,
                                      style: textfieldStyle()),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 100,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 30, top: 20),
                            child: Text(
                              (labels.location),
                              style: datalistStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            controller.empData.value.work_location == null
                                ? '-'
                                : controller.empData.value.work_location,
                            style: subtitleStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 100,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 30, top: 20),
                          child: Text(
                            controller.empData.value.name == null
                                ? 'More about '
                                : 'More about ' + controller.empData.value.name,
                            style: datalistStyle(),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(
                              (labels.workMobile),
                              style: datalistStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 70),
                              child: Text(
                                controller.empData.value.mobile_phone == null
                                    ? '-'
                                    : controller.empData.value.mobile_phone,
                                style: subtitleStyle(),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            child: Column(
                                              children: <Widget>[
                                                TextFormField(
                                                  controller: controller
                                                      .phoneNoEditController,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Edit phone number',
                                                    hintText: controller
                                                                .empData
                                                                .value
                                                                .mobile_phone ==
                                                            null
                                                        ? ''
                                                        : controller.empData
                                                            .value.mobile_phone,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                                child: Text("Change"),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          60, 47, 126, 1),
                                                ),
                                                // color: Color.fromRGBO(
                                                //     60, 47, 126, 1),
                                                onPressed: () {
                                                  controller.editPhoneNo();
                                                }),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Color.fromRGBO(60, 47, 126, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(
                              (labels.workEmail),
                              style: datalistStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 70),
                              child: Text(
                                controller.empData.value.work_email == null
                                    ? '-'
                                    : controller.empData.value.work_email,
                                style: subtitleStyle(),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            child: Column(
                                              children: <Widget>[
                                                TextFormField(
                                                  controller: controller
                                                      .emailEditController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Edit email',
                                                    hintText: controller
                                                                .empData
                                                                .value
                                                                .work_email ==
                                                            null
                                                        ? ''
                                                        : controller.empData
                                                            .value.work_email,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                                child: Text("Change"),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          60, 47, 126, 1),
                                                ),
                                                // color: Color.fromRGBO(
                                                //     60, 47, 126, 1),
                                                onPressed: () {
                                                  controller.editEmail();
                                                }),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Color.fromRGBO(60, 47, 126, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(
                              (labels.workLocation),
                              style: datalistStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 70),
                          child: Text(
                            controller.empData.value.work_location == null
                                ? '-'
                                : controller.empData.value.work_location,
                            style: subtitleStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(
                              (labels.company),
                              style: datalistStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 70),
                          child: Text(
                            controller.empData.value.company_id == null
                                ? '-'
                                : controller.empData.value.company_id!.name,
                            style: subtitleStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(
                              (labels.department),
                              style: datalistStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 70),
                          child: Text(
                            controller.empData.value.department_id!.name == null
                                ? '-'
                                : controller.empData.value.department_id!.name,
                            style: subtitleStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(
                              (labels.position),
                              style: datalistStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 70),
                          child: Text(
                            controller.empData.value.job_title == null
                                ? '-'
                                : controller.empData.value.job_title,
                            style: subtitleStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(
                              (labels.manager),
                              style: datalistStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 70),
                          child: Text(
                            controller.empData.value.parent_id!.name == null
                                ? '-'
                                : controller.empData.value.parent_id!.name,
                            style: subtitleStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        ExpansionTile(
                          title: Text(
                            labels.privateInformation,
                            style: subtitleStyle(),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: informationList(context),
                            ),
                          ],
                        ),
                        // Divider(
                        //   thickness: 1,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        /*ExpansionTile(
                          title: Text(
                            labels?.documents,
                            style: subtitleStyle(),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: documentaionList(context),
                            ),
                          ],
                        ),*/
                        // Divider(
                        //   thickness: 1,
                        // ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  // ignore: missing_return
  Widget informationList(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels!.ssbNo,
                  style: subtitleStyle(),
                ),
              ),
              Container(
                child: Text(
                  controller.empData.value.ssb_no == null
                      ? '-'
                      : controller.empData.value.ssb_no,
                ),
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
                  labels.ssbCardIssueDate,
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  controller.empData.value.smart_card_issue_date == null
                      ? '-'
                      : controller.empData.value.smart_card_issue_date,
                ),
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
                  labels.temporaryCardYesNo,
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  controller.empData.value.ssb_temporary_card == null
                      ? 'No'
                      : "Yes",
                  style: datalistStyle(),
                ),
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
                  labels.temporaryCardNumber,
                  style: datalistStyle(),
                ),
              ),
              Container(
                  child: Text(
                controller.empData.value.ssb_temporary_card_no == null
                    ? '-'
                    : controller.empData.value.ssb_temporary_card_no,
              )),
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
                  labels.smartCardYesNo,
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  controller.empData.value.smart_card == null ? 'No' : "Yes",
                  style: datalistStyle(),
                ),
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
                  labels.smartCardIssueDate,
                  style: datalistStyle(),
                ),
              ),
              Container(
                  child: Text(
                controller.empData.value.smart_card_issue_date == null
                    ? '-'
                    : controller.empData.value.smart_card_issue_date,
              )),
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
                  labels.smartCardNumber,
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  controller.empData.value.smart_card_no == null
                      ? '-'
                      : controller.empData.value.smart_card_no,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget documentaionList(BuildContext context) {
    return Container(
      child: Obx(
        () => SizedBox(
          // paddingOnly(left: 30),
          child: ListView.builder(
              itemCount: dcontroller.docList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        dcontroller.docList[index].name,
                        style: subtitleStyle(),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: GridView.builder(
                              // padding: EdgeInsets.all(10),
                              itemCount: dcontroller
                                  .docList[index].documentList.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2,
                                crossAxisSpacing: 0.9,
                                mainAxisSpacing: 0.5,
                                crossAxisCount: 2,
                              ),
                              itemBuilder:
                                  (BuildContext context, int fileIndex) {
                                return InkWell(
                                  onTap: () async {
                                    File? file = await dcontroller.getDoc(
                                        dcontroller.docList[index]
                                            .documentList[fileIndex].documentId,
                                        dcontroller.docList[index]
                                            .documentList[fileIndex].file_type);
                                    if (AppUtils.isImage(file!.path)) {
                                      Get.dialog(Stack(
                                        children: [
                                          Center(child: Image.file(file)),
                                          Positioned(
                                              right: 0,
                                              child: TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  )))
                                        ],
                                      ));
                                    } else {
                                      await OpenFile.open(file.path);
                                      /*Get.to(PdfView(file.path,dcontroller
                                                      .docList[index].documentList[fileIndex].documentName));*/
                                    }
                                  },
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Icon(
                                            FontAwesomeIcons.file,
                                            size: 50,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 30,
                                        // ),
                                        Text(
                                          dcontroller
                                              .docList[index]
                                              .documentList[fileIndex]
                                              .documentName,
                                          style: datalistStyle(),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    ),
                    Divider(
                      height: 1,
                      thickness: 2,
                      color: Colors.black,
                    )
                  ],
                );
              }),
        ),
      ),
    );

    //   Row(
    //     children: [
    //       Expanded(
    //         child: Container(
    //           height: 100,
    //           // width: 100,
    //           child: Card(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 Expanded(
    //                   child: Icon(
    //                     FontAwesomeIcons.file,
    //                     size: 50,
    //                   ),
    //                 ),
    //                 // SizedBox(
    //                 //   height: 30,
    //                 // ),
    //                 Text("Documents")
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         child: Container(
    //           height: 100,
    //           // width: 100,
    //           child: Card(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 Expanded(
    //                   child: Icon(
    //                     FontAwesomeIcons.file,
    //                     size: 50,
    //                   ),
    //                 ),
    //                 // SizedBox(
    //                 //   height: 40,
    //                 // ),
    //                 Text("Documents")
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         child: Container(
    //           height: 100,
    //           // width: 100,
    //           child: Card(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 Expanded(
    //                   child: Icon(
    //                     FontAwesomeIcons.file,
    //                     size: 50,
    //                   ),
    //                 ),
    //                 // SizedBox(
    //                 //   height: 30,
    //                 // ),
    //                 Text("Documents")
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
  }
}
