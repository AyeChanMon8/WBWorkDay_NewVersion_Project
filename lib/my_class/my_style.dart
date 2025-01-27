import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
TextStyle labelStyle() =>
    TextStyle(fontSize: 13, color: Color.fromRGBO(58, 47, 112, 1));

TextStyle countLabelStyle() =>
    TextStyle(fontSize: 13, color: Colors.white);
TextStyle middleLabelStyle() =>
    TextStyle(fontSize: 14, color: Colors.black);
TextStyle middleHintLabelStyle() =>
    TextStyle(fontSize: 14, color: Colors.grey);
TextStyle smallLabelStyle() =>
    TextStyle(fontSize: 10, color: Colors.black);
double middleFont() =>  14;
double smallFont() =>  8;
TextStyle pmstitleStyle() =>
    TextStyle(fontSize: 15, color: Color.fromRGBO(58, 47, 112, 1));

TextStyle listTileStyle() => TextStyle(
    fontSize: 13,
    color: Color.fromRGBO(58, 47, 112, 1),
    fontWeight: FontWeight.bold);

TextStyle subTitleStyle() => TextStyle(
    fontSize: 13,
    color: Color.fromRGBO(58, 47, 112, 1),
    fontWeight: FontWeight.bold);

TextStyle appBarTextStyle() =>
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

TextStyle textfieldStyle() =>
    TextStyle(fontSize: 13, color: Color.fromRGBO(58, 47, 112, 1));

TextStyle labelGreyHightlightTextStyle() =>
    TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold);

TextStyle labelGreyStyle() => TextStyle(fontSize: 13, color: Colors.grey);

TextStyle labelPrimaryHightlightTextStyle() => TextStyle(
    fontSize: 12,
    color: Color.fromARGB(255, 63, 51, 128),
    fontWeight: FontWeight.bold);

TextStyle labelPrimaryTitleTextStyle() =>
    TextStyle(fontSize: 15, color: Color.fromARGB(255, 63, 51, 128));

TextStyle labelPrimaryTitleBoldTextStyle() => TextStyle(
    fontSize: 15,
    color: Color.fromARGB(255, 63, 51, 128),
    fontWeight: FontWeight.bold);

TextStyle buttonTextStyle() => TextStyle(fontSize: 16, color: Colors.white);

TextStyle iconCircleColor() => TextStyle(color: Color.fromRGBO(58, 47, 112, 1));

final drawerIconColor = IconThemeData(color: Colors.white);

final arrowforwardIcon = Icon(Icons.arrow_forward_ios);
final arrowforwardIconWhite = Icon(
  Icons.arrow_forward_ios,
  color: Colors.white,
);

final arrowbackwardIcon = Icon(Icons.arrow_back);

final withdrawIcon = FaIcon(FontAwesomeIcons.reply);

final delegateIcon = Icon(Icons.people);

final backgroundIconColor = Color.fromRGBO(58, 47, 112, 1);

TextStyle appbarTextStyle() =>
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15);
TextStyle appbarTextStyleFont() =>
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

//Login Page//
final textFieldTapColor = Color.fromRGBO(60, 47, 126, 1);
final attachmentButtonColor = Color.fromRGBO(211, 211, 211, 1);
final logoImage = Image.asset('assets/icon/icon.jpg');

//Home Page//
final createRequestIcon = Icon(
  FontAwesomeIcons.plus,
  color: Colors.white,
  size: 18,
);
final attendanceCheckInIcon = Icon(
  Icons.fingerprint,
  color: Color.fromARGB(255, 63, 51, 128),
  size: 60,
);
final attendanceCheckOutIcon = Icon(
  Icons.add_to_home_screen,
  color: Color.fromARGB(255, 63, 51, 128),
  size: 60,
);
final rewardsIcon = Icon(
  FontAwesomeIcons.rssSquare,
  color: Colors.white,
  size: 18,
);
final attendanceIcon = Icon(
  Icons.fingerprint,
  color: Colors.white,
  size: 18,
);
final testIcon = Icon(
  Icons.fingerprint,
  color: Colors.white,
  size: 10,
);
final leaveReportIcon = Icon(
  Icons.calendar_today,
  color: Colors.white,
  size: 18,
);
final reportIcon = Icon(
  Icons.report,
  color: Colors.white,
  size: 18,
);
final approvalIcon = Icon(
  Icons.check,
  color: Colors.white,
  size: 18,
);
final organizationIcon = Icon(
  FontAwesomeIcons.chartArea,
  color: Colors.white,
  size: 18,
);
TextStyle appbarBackgroundColor() =>
    TextStyle(color: Color.fromRGBO(60, 47, 126, 1));

TextStyle DetailtitleStyle() => TextStyle(
    fontSize: 18,
    color: Color.fromRGBO(58, 47, 112, 1),
    fontWeight: FontWeight.bold);

TextStyle maintitleStyle() => TextStyle(
    fontSize: 12,
    color: Color.fromRGBO(58, 47, 112, 1),
    fontWeight: FontWeight.bold);

TextStyle maintitlenoBoldStyle() => TextStyle(
    fontSize: 16,
    color: Color.fromRGBO(58, 47, 112, 1),
    fontWeight: FontWeight.normal);

TextStyle maintitleBoldStyle() => TextStyle(
    fontSize: 16,
    color: Color.fromRGBO(58, 47, 112, 1),
    fontWeight: FontWeight.bold);
TextStyle detailsStyle() => TextStyle(
    fontSize: 16,
    color: Color.fromRGBO(88, 98, 134, 1),
    fontWeight: FontWeight.bold);
TextStyle subtitleStyle() => TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(63, 51, 128, 1),
    fontWeight: FontWeight.bold);

TextStyle datalistStyle() => TextStyle(
    fontSize: 12,
    overflow: TextOverflow.ellipsis,
    color: Color.fromRGBO(88, 98, 134, 1),
    fontWeight: FontWeight.bold);


TextStyle datalistStylenotBold() => TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(88, 98, 134, 1),
    fontWeight: FontWeight.normal);


//Botton Navigation Page Style ...//

final barBackgroundColorStyle = Colors.white;
final selectedItemBorderColorStyle = Colors.transparent;
final selectedItemBackgroundColorStyle = Color.fromRGBO(58, 47, 112, 1);
final selectedItemIconColorStyle = Color.fromRGBO(216, 181, 0, 1);
final selectedItemLabelColorStyle = Color.fromRGBO(60, 47, 126, 1);
final navigationBarHeightStyle = 60.0;
final bottomNavigationIcon1 = Icons.home;
final bottomNavigationIcon2 = Icons.person;
final bottomNavigationIcon3 = Icons.people;
final bottomNavigationIcon4 = Icons.message;
final bottomNavigationIcon5 = Icons.more;
final iconLeaveTripReport = Icons.calendar_today;

//textstyle for card text in grid
TextStyle cardTextStyle() =>
    TextStyle(fontSize: 13, color: Color.fromRGBO(58, 47, 112, 1));

TextStyle menuTextStyle() =>
    TextStyle(fontSize: 10, color: Color.fromRGBO(58, 47, 112, 1));

//HR Page

//circle avator styles
final circleAvatorBakgroundColor = Color.fromRGBO(58, 47, 112, 1);
final circleAvatorRadius = 30.0;

final overtimeIcon = Icon(
  FontAwesomeIcons.timesCircle,
);

final leaveTripReportIcon = Icon(
  FontAwesomeIcons.inbox,
);

final leaveTripRequestIcon = Icon(
  FontAwesomeIcons.signOutAlt,
);

final attendenceIcon = Icon(Icons.fingerprint);

final attendanceReportIcon = Icon(
  Icons.person_add,
);

final insuranceIcon = Icon(
  FontAwesomeIcons.inbox,
);

final loanIcon = Icon(
  FontAwesomeIcons.longArrowAltDown,
);

final payslipIcon = Icon(
  FontAwesomeIcons.solidPaperPlane,
);

final orgChartIcon = Icon(
  Icons.bubble_chart,
);

final pmsIcon = Icon(
  FontAwesomeIcons.plus,
);

//crossAxisAlignment
final crossAxisAlign = CrossAxisAlignment.center;
final mainAxisAlign = MainAxisAlignment.center;

final dim_color = Color.fromRGBO(63, 51, 128, 1);

