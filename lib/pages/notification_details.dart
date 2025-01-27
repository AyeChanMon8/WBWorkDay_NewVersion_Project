import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationDetails extends StatefulWidget {
  @override
  _NotificationDetailsState createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  final box = GetStorage();
  late String user_image;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    user_image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: appbar(context, labels!.notifications, user_image)),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                labels.notifications,
                // ("notifications"),
                style: maintitleStyle(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "From HR",
                style: maintitleStyle(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Dear Han Tun Zaw",
                    style: subtitleStyle(),
                  ),
                ),
                Container(
                  child: Text(
                    "9/8/2020",
                    style: subtitleStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                  "This is details of notification 1 .please check kindly!"),
            )
          ],
        ),
      ),
    );
  }
}
