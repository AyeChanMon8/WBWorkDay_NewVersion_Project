
import 'dart:convert';
import 'package:dio/dio.dart';
import '../constants/globals.dart';
import '../services/odoo_service.dart';

//import 'package:dio/dio.dart';
class AuthService extends OdooService {
  String url = Globals.baseURL + "/res.partner/2/generate_otp_mobile";

  generateToken(String mobile) async {
    String otp = "";
    Dio dioClient = await client();
    Response response =
        await dioClient.put(url, data: jsonEncode({'mobile': mobile}));
    if (response.statusCode == 200) {
      otp = response.data;
    } else {
      print(response.data);
    }
    return otp;
  }

  authenticate(String mobile, String otp) async {
    String userId = '';
    String url = Globals.baseURL + "/res.partner/2/authenticate";
    Dio dioClient = await client();
    Response response = await dioClient.put(url,
        data: jsonEncode({'mobile': mobile, 'otp': otp}));
    if (response.statusCode == 200) {
      userId = response.data;
    } else {
      print(response.data);
    }
    return userId;
  }
}
