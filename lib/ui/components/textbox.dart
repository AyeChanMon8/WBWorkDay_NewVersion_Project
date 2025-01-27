

import 'package:flutter/material.dart';
class TextBox extends StatelessWidget {
 final TextEditingController? textEditingController;
 final String? hintText;
 final bool enable;

  TextBox({this.textEditingController, this.hintText,this.enable=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: TextField(
        enabled: enable,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.none,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black)
        ),
      ),
    );
  }
}
