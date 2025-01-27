import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';

Widget appbar(BuildContext context, title, String image) {
  return AppBar(
    backgroundColor: backgroundIconColor,
    title: Text(
      title,
      style: appbarTextStyle(),
    ),
    iconTheme: drawerIconColor,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
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
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(50.0),
              child: image != null&&image.isNotEmpty
                  ? new Image.memory(
                      base64Decode(image),
                      fit: BoxFit.cover,
                      scale: 0.1,
                      height: 40,
                      width: 40,
                    )
                  : new Container(),
            ),
          ),
        ),
        // Container(
        //     margin: EdgeInsets.only(right: 10),
        //     child: Icon(Icons.info,color: Colors.white,size: 30,)),
      ),
    ],
  );
}
