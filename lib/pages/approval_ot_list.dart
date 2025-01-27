

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/approval_controller.dart';
import '../controllers/leave_list_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import 'approval_details.dart';

class OvertimeApprovalList extends StatefulWidget {
  @override
  _OvertimeApprovalListState createState() => _OvertimeApprovalListState();
}

class _OvertimeApprovalListState extends State<OvertimeApprovalList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  @override
  void initState() {
    super.initState();
    controller.getOtResponse();
  }
  @override
  Widget build(BuildContext context) {
    image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, "Overtime Approval List", image)),
      body: ListView.builder(
        itemCount: controller.otcList.value.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ApprovalDetails()));

                  Get.toNamed(Routes.APPROVAL_OVERTIME_DETAILS, arguments: index);
                },
                child: ListTile(
                    // leading: CircleAvatar(
                    //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                    //   child: ClipRRect(
                    //     borderRadius: new BorderRadius.circular(50.0),
                    //     child: Image.network(
                    //       "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ),
                    // ),
                    // leading:
                    title: Text(
                        // "Approval 1",
                        controller.otcList.value[index]
                            .name),
                    subtitle: Text(controller
                        .otcList.value[index].requested_employee_id!.name),
                    trailing: arrowforwardIcon),
              ),
            ),
          );
        },
      ),
    );
  }
}
