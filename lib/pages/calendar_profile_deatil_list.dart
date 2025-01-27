

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/user_profile_controller.dart';
import '../my_class/my_app_bar.dart';
import '../routes/app_pages.dart';

class DetailsList extends StatefulWidget {
  DetailsList({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _DetailsListState createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList>
    with TickerProviderStateMixin {
  Map<DateTime, List>? _events;
  late List _selectedEvents;
  late AnimationController _animationController;
  late CalendarController _calendarController;
  String image = '';
  UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(8.0),
        child: appbar(context, 'Calendar', image)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          dataProfile(context),
          Divider(
            thickness: 2,
          ),
          profileLeave(context),
          Divider(
            thickness: 2,
          ),
          clientInfo(context),
          Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }

  Widget dataProfile(context) {
    late Uint8List bytes;
    if (controller.empData.value.image_128 != null) {
      bytes = base64Decode(controller.empData.value.image_128);
    }

    return Container(
      margin: EdgeInsets.all(20),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color.fromRGBO(216, 181, 0, 1),
          child: ClipRRect(
              borderRadius: new BorderRadius.circular(50.0),
              child: new Image.memory(
                bytes,
                fit: BoxFit.fitWidth,
              )),
        ),
        // leading:
        title: Text(
          controller.empData.value.name,
          // "Announcements 1",
        ),
        subtitle: Text(controller.empData.value.job_title),
        trailing: InkWell(
          child: FaIcon(FontAwesomeIcons.calendar),
          onTap: () {
            Get.offNamed(Routes.CALENDAR);
          },
        ),
      ),
    );
  }

  Widget profileLeave(context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Casual Leave'),
              Text('3Days'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text('09/01/2020(06:00) - 11/01/2020(06:00)'),
          SizedBox(
            height: 5,
          ),
          Text('Doctor appointment')
        ],
      ),
    );
  }

  Widget clientInfo(context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Meeting with client'),
          SizedBox(
            height: 5,
          ),
          Text('16/01/2020(10:00) - 16/01/2020(12:00)'),
          SizedBox(
            height: 5,
          ),
          Text('Project ABC')
        ],
      ),
    );
  }
}
