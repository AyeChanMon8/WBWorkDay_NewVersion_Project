

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/change_password_controller.dart';
// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../my_class/my_style.dart';
import '../my_class/theme.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  ChangePasswordController controller = Get.put(ChangePasswordController());

  TextEditingController employeeIDController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscureText1 = true;

  bool _obscureText2 = true;

  bool _obscureText3 = true;
  final box = GetStorage();
  toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  toggle3() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }
  String emp_id = '';
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    final _formKey = GlobalKey<FormState>();
    emp_id = Get.arguments ?? "";
    if(emp_id!=null && emp_id!=""){
      controller.employeeIDController.text = emp_id;
    }else{
      controller.employeeIDController.text = box.read('login_employee_id');
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(labels!.changePassword,style: appBarTextStyle(),),
        backgroundColor: backgroundIconColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              // Add TextFormFields and RaisedButton here.
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextFormField(
                      controller: controller.employeeIDController,
                      readOnly: true,
                      enabled: false,
                      validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please Enter Employee ID';
                      }
                      return null;
                    },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (labels?.employeeID),
                      ),
                      onChanged: (text) {
                        // setState(() {});
                      },
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextFormField(
                      controller: controller.newPasswordController,
                      validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please Enter New Password';
                      }
                      return null;
                    },
                      obscureText: _obscureText2,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: toggle2,
                        ),
                        border: OutlineInputBorder(),
                        hintText: (labels?.newPassword),
                      ),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextFormField(
                      controller: controller.confirmPasswordController,
                       validator: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'Please Enter Confirm New Password';
                      }
                      if(controller.newPasswordController.text!=controller.confirmPasswordController.text){
                        return "Password does not match";
                      }
                      return null;
                    },
                      obscureText: _obscureText3,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: toggle3,
                        ),
                        border: OutlineInputBorder(),
                        hintText: (labels?.confirmNewPassword),
                      ),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Container                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               (
                width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                    backgroundColor: textFieldTapColor,
                  ),
                  onPressed: () {
                    if(_formkey.currentState!.validate())
                      {
                        controller.changePassword();
                      }else{
                        print("UnSuccessfull");
                      }
                    
                  },
                  child: Text(
                    labels.submit,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
