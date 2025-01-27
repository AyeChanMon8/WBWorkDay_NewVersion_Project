// import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../localization.dart';

import '../tools/internet_provider.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import '../pages/admin_page.dart';
import '../pages/chat.dart';
import '../pages/home_page.dart';
import '../pages/hr_page.dart';
import '../pages/setting_page.dart';

import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int selectedIndex = 0;
  late String index;
  final CircularBottomNavigationController _navigationController =
      CircularBottomNavigationController(0);
  PageController _controller = PageController(
    initialPage: 0,
  );
  int _page = 0;

  void initState() {
    index = Get.arguments.toString();
    print(index);
    if (index == "leave") {
      selectedIndex = 1;
      _controller = PageController(
        initialPage: 1,
      );
    } else if (index == "expense") {
      selectedIndex = 2;
      _controller = PageController(
        initialPage: 2,
      );
    } else {
      selectedIndex = selectedIndex;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    //bool isInternet = InternetProvider.of(context).internet;
    index = Get.arguments.toString();

    bool isInternet = true;
    return Scaffold(
      key: scaffoldKey,
      body: isInternet == true
          ? PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              onPageChanged: onPageChanged,
              children: <Widget>[
                // Get.toNamed(Routes);
                HomePage(),
                HRPage(),
                AdminPage(),
                // ChatPage(),
                SettingPage(),
              ],
            )
          : Container(
              color: Colors.white, child: Center(child: Text("no_internet"))),

      // bottomNavigationBar: FFNavigationBar(
      //   theme: FFNavigationBarTheme(
      //     barBackgroundColor: barBackgroundColorStyle,
      //     selectedItemBorderColor: selectedItemBorderColorStyle,
      //     selectedItemBackgroundColor: selectedItemBackgroundColorStyle,
      //     selectedItemIconColor: selectedItemIconColorStyle,
      //     selectedItemLabelColor: selectedItemLabelColorStyle,
      //     showSelectedItemShadow: false,
      //     barHeight: navigationBarHeightStyle,
      //   ),
      //   selectedIndex: selectedIndex,
      //   onSelectTab: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //       _controller.jumpToPage(index);
      //     });
      //   },
      //   items: [
      //     FFNavigationBarItem(
      //       iconData: bottomNavigationIcon1,
      //       label: (labels.home),
      //     ),

      //     FFNavigationBarItem(
      //       iconData: bottomNavigationIcon2,
      //       label: (labels.hr),
      //     ),
      //     FFNavigationBarItem(
      //         iconData: bottomNavigationIcon3, label: (labels.admin)),
      //     // FFNavigationBarItem(
      //     //   iconData: bottomNavigationIcon4,
      //     //   label: (labels.message),
      //     // ),
      //     FFNavigationBarItem(
      //       iconData: bottomNavigationIcon5,
      //       label: (labels.more),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: CircularBottomNavigation(
        tableTabs(),
        controller: _navigationController,
        circleStrokeWidth: 0,
        barBackgroundColor: barBackgroundColorStyle,
        circleSize: 50,
        iconsSize: 25,
        // backgroundColor: Colors.purple,
        // selectedLabelStyle: TextStyle(color: Colors.purple),
        // unselectedLabelStyle: TextStyle(color: Colors.grey),
        // backgroundColor: Colors.black,
        selectedIconColor: Colors.white,
        selectedCallback: (index) {
          setState(() {
            selectedIndex = index ?? 0;

            _controller.jumpToPage(index ?? 0);
          });
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   // backgroundColor: Colors.purple,
      //   selectedIconTheme: IconThemeData(color: Colors.purple),
      //   unselectedIconTheme: IconThemeData(color: Colors.grey),
      //   // selectedLabelStyle: TextStyle(color: Colors.purple),
      //   // unselectedLabelStyle: TextStyle(color: Colors.grey),
      //   // backgroundColor: Colors.black,
      //   currentIndex: selectedIndex,
      //   onTap: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //       _controller.jumpToPage(index);
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: (labels!.home),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: (labels.hr),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.people),
      //       label: (labels.admin),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.more),
      //       label: (labels.more),
      //     ),
      //   ],
      // ),
    );
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  List<TabItem> tableTabs() {
    final labels = AppLocalizations.of(context);
    List<TabItem> tabItems = List.of([
      TabItem(
        bottomNavigationIcon1,
        labels!.home,
        backgroundIconColor,
        labelStyle: TextStyle(
          color: backgroundIconColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      TabItem(
        bottomNavigationIcon2,
        labels.hr,
        backgroundIconColor,
        labelStyle: TextStyle(
          color: backgroundIconColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      TabItem(
        bottomNavigationIcon3,
        labels.admin,
        backgroundIconColor,
        labelStyle: TextStyle(
          color: backgroundIconColor,
          fontWeight: FontWeight.bold,
        ),
        // circleStrokeColor: Colors.black,
      ),
      TabItem(
        bottomNavigationIcon5,
        labels.more,
        backgroundIconColor,
        labelStyle: TextStyle(
          color: backgroundIconColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
    return tabItems;
  }
}
