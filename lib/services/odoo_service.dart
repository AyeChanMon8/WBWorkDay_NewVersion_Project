import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../models/odoo_instance.dart';
import '../models/user.dart';
import '../utils/app_utils.dart';

class OdooService extends GetxService {
  final odooInstance = OdooInstance().obs;
  final String tokenURL = Globals.baseURL + "/auth/get_tokens";
  String token = '';
  var box = GetStorage();
  Dio dioClient = Dio();

  // Future<OdooService> init() async {
  //   odooInstance.value = await getOdooInstance();
  //   return this;
  // }
  Future<OdooService> init() async {
    //TODO testing disable
    token = box.read(Globals.token);
    if (token == "") {
      this.odooInstance.value = await getOdooInstance();
      token = this.odooInstance.value.user!.access_token;
      box.write(Globals.tokenDate, DateTime.now().toString());
      box.write(Globals.token, token);
    }
    dioClient = Dio();

    return this;
  }

  Future<OdooInstance> getOdooInstance() async {
    //http.Response response;
    OdooInstance newOdooInstance = OdooInstance();
    Dio dio = Dio(BaseOptions(
      validateStatus: (status) {
        return status != null;
      },
    ));
    dio.options.headers['content-Type'] = 'text/html';
    try {
      Response response = await dio.post(tokenURL,
          data: json.encode({"username": "__system__", "password": "sysadmin"}));
      print("response Status ${response.statusCode}");
      print(response.data);
      if (response.statusCode == 200) {
        newOdooInstance.user = User.fromMap(response.data);
        print(newOdooInstance.user!.access_token);
        newOdooInstance.connected = true;
        box.write(Globals.token, newOdooInstance.user!.access_token);
      } else {
        throw Exception('Failed to create album.');
      }
    } on Exception catch (e) {
      print('error caught: $e');
    }
    // this.odooInstance.value = newOdooInstance;
    return newOdooInstance;
  }

  Future<Dio> client() async {
    Dio dio = new Dio();

    try {
      //TODO testing commit the box.
      final tokenVariable = box.read(Globals.token);
      String currentDate = AppUtils.formatter.format(DateTime.now());
      final tokenDate = box.read(Globals.tokenDate);
      if (tokenVariable != null &&
          tokenDate != null &&
          currentDate == AppUtils.formatter.format(DateTime.parse(tokenDate))) {
        token = tokenVariable;
        print('used $token');
      } else {
        OdooInstance newInst = await getOdooInstance();
        token = newInst.user!.access_token;
        box.write(Globals.tokenDate, DateTime.now().toString());
        box.save();
      }

      dio.interceptors.clear();

      dio.interceptors
        ..add(InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers.clear();
            options.headers["Access-Token"] = token;
            options.headers['Content-Type'] = "text/html";
            options.headers['Connection'] = "Keep-Alive";
            // options.connectTimeout = 60 * 30 * 1000;
            // options.receiveTimeout = 60 * 30 * 1000;
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (DioError e, handler) async {
            print('Odoo error response=> ${e.response}');
            Get.back();
            // Do something with response error
            if (e.response?.statusCode == 403) {
              // dio.interceptors.requestLock.lock();
              // dio.interceptors.responseLock.lock();
              RequestOptions options = e.requestOptions;
              OdooInstance newInst = await getOdooInstance();
              token = newInst.user!.access_token;
              options.headers["Access-Token"] = token;
              // options.connectTimeout = 5000000;
              // options.receiveTimeout = 3000000;
              // dio.interceptors.requestLock.unlock();
              // dio.interceptors.responseLock.unlock();
              dio.request(options.path, options: options as Options);
            } else {
              // Get.snackbar("Try Again", "Token is expired or invalid!");
            }
            // return error;
            // Get.snackbar("Try Again Login", "Token is expired or invalid!",snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);
            this.odooInstance.value = await getOdooInstance();
            token = this.odooInstance.value.user!.access_token;
            box.write(Globals.token, token);
            box.write(Globals.tokenDate, DateTime.now().toString());
            box.save();
            var error_message = '';
            if (e.response?.data != null && e.response?.statusCode!=414) {
              if (e.response!.data['error_descrip']
                  .contains("ValidationError('")) {
                error_message = e.response!.data['error_descrip']
                    .split('ValidationError(')[1];
              } else {
                error_message = e.response!.data['error_descrip'];
              }
            } else {
              //Globals.ph_hardware_back.value = true;
              error_message =
                  'Network connection fail ${e.response?.statusCode}!\nPlease, try again';
            }
            AppUtils.showDialog('Warning', error_message);

            print("Server down and please check");
            return handler.next(e);
          },
        ))

        // dio.interceptors
        //   ..add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        //     // Do something before request is sent
        //     options.headers.clear();
        //     options.headers["Access-Token"] = token;
        //     options.headers['Content-Type'] = "text/html";
        //     options.headers['Connection'] = "Keep-Alive";
        //     options.connectTimeout = 60 * 30 * 1000;
        //     options.receiveTimeout = 60 * 30 * 1000;
        //     return options;
        //   }, onResponse: (Response response) {
        //     // Do something with response data
        //     return response; // continue
        //   }, onError: (DioError error) async {
        //     print('Odoo error response=> ${error.response}');
        //     Get.back();
        //     // Do something with response error
        //     if (error.response?.statusCode == 403) {
        //       dio.interceptors.requestLock.lock();
        //       dio.interceptors.responseLock.lock();
        //       RequestOptions options = error.response.request;
        //       OdooInstance newInst = await getOdooInstance();
        //       token = newInst.user.access_token;
        //       options.headers["Access-Token"] = token;
        //       options.connectTimeout = 5000000;
        //       options.receiveTimeout = 3000000;
        //       dio.interceptors.requestLock.unlock();
        //       dio.interceptors.responseLock.unlock();
        //       dio.request(options.path, options: options);
        //     } else {
        //      // Get.snackbar("Try Again", "Token is expired or invalid!");
        //     }
        //     // return error;
        //    // Get.snackbar("Try Again Login", "Token is expired or invalid!",snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);
        //     this.odooInstance.value = await getOdooInstance();
        //     token = this.odooInstance.value.user.access_token;
        //     box.write(Globals.token, token);
        //     box.write(Globals.tokenDate, DateTime.now().toString());
        //     box.save();
        //     var error_message = '';
        //     if(error.response?.data != null){
        //       if(error.response.data['error_descrip'].contains("ValidationError('")){
        //         error_message =  error.response.data['error_descrip'].split('ValidationError(')[1];
        //       }else{
        //         error_message =  error.response.data['error_descrip'];
        //       }
        //     }else{
        //       //Globals.ph_hardware_back.value = true;
        //       error_message = 'Network connection fail ${error.response?.statusCode}!\nPlease, try again';
        //     }
        //     AppUtils.showDialog('Warning', error_message);

        //     print("Server down and please check");
        //   }))
        ..add(LogInterceptor(
            request: true,
            requestBody: true,
            responseBody: true,
            logPrint: (log) => print(log)));
    } catch (error) {
      print(error);
    }
    return dio;
  }
}
