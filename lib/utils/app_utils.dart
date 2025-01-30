import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../routes/app_pages.dart';

class AppUtils {
  static void showSnackBar(String str, BuildContext context,
      {color = Colors.blue}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: color,
    ));
  }

  static var formatter = new DateFormat('dd-MM-yyyy');
  static bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType!.startsWith('image/');
  }

  // static Future<File?> createPDF(
  //     String pdfString, String fileName, String type) async {
  //   try {
  //     if (pdfString.isNotEmpty) {
  //       var bytes = base64Decode(pdfString.replaceAll('\n', ''));
  //       String dir = (await getExternalStorageDirectory())!.path;
  //       var typeValue = (type.split('/').last);
  //       var doted = ".";
  //       var file_name = "";

  //       if (fileName.contains(typeValue)) {
  //         file_name = (fileName.split(typeValue).first);
  //         file_name += typeValue;
  //       } else {
  //         file_name = fileName + doted + typeValue;
  //       }

  //       String fullPath = "$dir/$file_name";
  //       final File file = File(fullPath);
  //       await file.writeAsBytes(bytes);
  //       return file;
  //     }
  //   } catch (error) {}
  // }

  static Future<File?> createPDF(
      String pdfString, String fileName, String type) async {
        print("typee>>>>>"+type);
        print("fileNameeee>>>>"+fileName);
    try {
      if (pdfString.isNotEmpty) {
        var bytes = base64Decode(pdfString.replaceAll('\n', ''));
        if (Platform.isAndroid) {
        // Get the download folder directory using path_provider
        final directory = await getExternalStorageDirectory();

        if (directory == null) {
          print('Could not get external storage directory');
          return null;
        }

        final downloadFolder = Directory('${directory.path}/Download');
        if (!await downloadFolder.exists()) {
          await downloadFolder.create(recursive: true);
        }
        var typeValue = (type.split('/').last);
        var doted = ".";
        var file_name = "";

        if (fileName.contains(typeValue)) {
          file_name = (fileName.split(typeValue).first);
          file_name += typeValue;
        } else {
          file_name = fileName + doted + typeValue;
        }

        final file =
            File('${downloadFolder.path}/$file_name'); // Set the file name
        await file.writeAsBytes(bytes);

        print("File saved to: ${file.path}");

        // Open the file after downloading
        return file;
        }else{
           var path = await getApplicationDocumentsDirectory();
      final file = new File('${path.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      return file;
        }
      }
    } catch (error) {}
  }

  Future<void> openDownloadedFile(String filePath) async {
    final result = await OpenFile.open(filePath);
    print(result.type);
    // if (result.type == ResultType.done) {
    //   print("File opened successfully");
    // } else {
    //   print("Failed to open file: ${result.message}");
    // }
  }

  static double getFileSizeInKB(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInKb = sizeInBytes / 1024;
    return sizeInKb;
  }

  static Future<File> reduceImageFileSize(File image) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(image.path);
    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: 80,
        targetWidth: 640,
        targetHeight: (properties.height! * 640 / properties.width!).round());
    double sizeInKb = getFileSizeInKB(compressedFile);
    print("sizeInKb");
    print(sizeInKb);
    if (sizeInKb > 200) {
      compressedFile = await FlutterNativeImage.compressImage(image.path,
          quality: 70,
          targetWidth: 640,
          targetHeight: (properties.height! * 640 / properties.width!).round());
    }
    return compressedFile;
  }

  static String onemonthago() {
    var now = new DateTime.now();
    print("now date >>" + now.toString());
    var oldDate = now.subtract(Duration(days: 30));
    print("oldDate >>" + oldDate.toString());
    return formatDate(
        oldDate, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', 'ss']);
  }

  static String threemonthago() {
    var now = new DateTime.now();
    var oldDate = now.subtract(Duration(days: 90));
    return formatDate(
        oldDate, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', 'ss']);
  }

  static String oneYearago() {
    var now = new DateTime.now();
    var oldDate = now.subtract(Duration(days: 366));
    return formatDate(
        oldDate, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', 'ss']);
  }

  static String onemonthpre() {
    var now = new DateTime.now();
    var oldDate = now.add(Duration(days: 60));
    return formatDate(
        oldDate, [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', 'ss']);
  }

  static void showToast(String msg) {
    Get.snackbar('Warning', msg,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
  }

  static void showDialog(
    String title,
    String msg,
  ) {
    Get.defaultDialog(
      title: title,
      content: Text(msg),
      textCancel: 'OK',
    );
  }

  static void showConfirmDialog(String title, String msg, Function onConfirm) {
    Get.defaultDialog(
        title: title,
        middleText: msg,
        onConfirm: onConfirm(),
        confirmTextColor: Colors.white);
  }

  // static void otDialog(String title, String msg) {
  //   Get.defaultDialog(title: title, content: Text(msg), confirm:);
  // }
  static DateTime? convertStringToDate(String dateStr) {
    try {
      if (dateStr != null && dateStr.length > 0) {
        DateTime date = DateTime.parse(dateStr);
        return date;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  static String timeInfo(String dateStr) {
    try {
      if (dateStr != null && dateStr != "") {
        var now = new DateTime.now();
        DateTime date = DateTime.parse(dateStr);
        date = date.add(Duration(hours: 06, minutes: 30));
        final difference = now.difference(date);
        return timeago.format(now.subtract(difference));
      } else {
        return dateStr;
      }
    } catch (error) {
      return dateStr;
    }
  }

  static List<DateTime> getDaysInBeteween(
      DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  static void showConfirmCancelDialog(
      String title, String msg, Function onConfirm, Function onCancel) async {
    Get.defaultDialog(
        title: title,
        content: Text(msg),
        textCancel: 'Cancel',
        textConfirm: 'Proceed',
        onConfirm: () => onConfirm(),
        onCancel: () => onCancel(),
        confirmTextColor: Colors.white);
  }

  static String removeNullString(String value) {
    var mValue = "-";
    if (value == null || value.isEmpty || value == 'null') {
      mValue = "-";
    } else {
      mValue = value;
    }
    return mValue;
  }

  static String addThousnadSperator(double amount) {
    var mAmount = '';
    if (amount != null) {
      mAmount = NumberFormat('#,###').format(amount).toString();
    } else {
      mAmount = '';
    }
    return mAmount;
  }

  static String changeDateTimeFormat(String date) {
    var formatted_date = "";
    if (date != null && date.isNotEmpty) {
      formatted_date = DateFormat("dd/MM/yyyy hh:mm:ss")
          .format(DateTime.parse(date).add(Duration(hours: 6, minutes: 30)));
    } else {
      formatted_date = "";
    }

    return formatted_date;
  }

  static String changeDefaultDateTimeFormat(String date) {
    var formatted_date = "";
    if (date != null && date.isNotEmpty) {
      formatted_date =
          DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(date));
    } else {
      formatted_date = "";
    }

    return formatted_date;
  }

  static String convertDT2String(DateTime date) {
    var formatted_date = "";
    if (date != null) {
      formatted_date = new DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    }

    return formatted_date;
  }

  static String changeDateFormat(String date) {
    var formatted_date = "";
    if (date != null && date != '' && date != "null") {
      formatted_date = DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
    } else {
      formatted_date = "";
    }
    return formatted_date;
  }

  static String changeDateFormatAndAddDate(String date) {
    var formatted_date = "";
    var today = DateTime.parse(date);
    var checkDate = int.parse(DateFormat("dd").format(DateTime.parse(date)));
    var checkHour = int.parse(DateFormat("HH").format(DateTime.parse(date)));
    print("checkDate $checkDate $checkHour");
    if (checkDate != 31 || checkDate != 30) {
      //&& checkDate != 1
      if (checkHour > 10 && checkHour < 18) {
        if (checkHour == 17) {
          today = today.add(Duration(days: 1));
        }
      } else if (checkHour > 18) {
        today = today.add(Duration(days: 1));
      } else if (checkHour == 2 || checkHour == 5) {
      } else {
        today = today.add(Duration(days: 1));
      }
    }
    if (date != null && date != '' && date != "null") {
      formatted_date = DateFormat("dd/MM/yyyy").format(today);
    } else {
      formatted_date = "";
    }

    return formatted_date;
  }

  String changeToLocalDateTime(String date) {
    // print('date==>$date');
    // var prepareDate =
    //     DateTime.parse(date).add(new Duration(hours: 6, minutes: 30));
    // return '$prepareDate';
    return DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(date, true)
        .toLocal()
        .toString();
  }

  static void showDialogPassword(
    String title,
    String msg,
  ) {
    final box = GetStorage();
    Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      content: Text(msg),
      actions: [
        TextButton(
          child: Text('Yes', style: TextStyle(color: Colors.red)),
          onPressed: () {
            box.write('emp_image', "");
            OneSignal.shared.removeExternalUserId();
            Get.offAllNamed(Routes.LOGIN);
          },
        ),
      ],
    );
  }

  static void showErrorDialog(String errorMessage, String statusCode) {
    var error_message = '';
    if (errorMessage.contains("('") && errorMessage.contains("', None")) {
      const start = "('";
      const end = "', None";
      final startIndex = errorMessage.indexOf(start);
      final endIndex = errorMessage.indexOf(end, startIndex + start.length);
      error_message = errorMessage.substring(
          startIndex + start.length, endIndex); // brown fox jumps
      AppUtils.showDialog('Warning', error_message);
    } else if (errorMessage.contains("('") && errorMessage.contains("',")) {
      const start = "('";
      const end = "',";
      final startIndex = errorMessage.indexOf(start);
      final endIndex = errorMessage.indexOf(end, startIndex + start.length);
      error_message = errorMessage.substring(
          startIndex + start.length, endIndex); // brown fox jumps
      AppUtils.showDialog('Warning', error_message);
    } else if (errorMessage.contains("Warning('") &&
        errorMessage.contains("')")) {
      const start = "Warning('";
      const end = "')";
      final startIndex = errorMessage.indexOf(start);
      final endIndex = errorMessage.indexOf(end, startIndex + start.length);
      error_message = errorMessage.substring(
          startIndex + start.length, endIndex); // brown fox jumps
      AppUtils.showDialog('Warning', error_message);
    } else if (errorMessage.contains('ERROR: ValidationError(\"') &&
        errorMessage.contains('\",')) {
      const start = 'ERROR: ValidationError(\"';
      const end = '\",';
      final startIndex = errorMessage.indexOf(start);
      final endIndex = errorMessage.indexOf(end, startIndex + start.length);
      error_message = errorMessage.substring(
          startIndex + start.length, endIndex); // brown fox jumps
      AppUtils.showDialog('Warning', error_message);
    } else if (errorMessage.contains('ERROR: ValidationError(\\"') &&
        errorMessage.contains('\\",')) {
      const start = 'ERROR: ValidationError(\\"';
      const end = '\\",';
      final startIndex = errorMessage.indexOf(start);
      final endIndex = errorMessage.indexOf(end, startIndex + start.length);
      error_message = errorMessage.substring(
          startIndex + start.length, endIndex); // brown fox jumps
      AppUtils.showDialog('Warning', error_message);
    } else if (errorMessage.contains('ERROR: ValidationError(\\"') &&
        errorMessage.contains("!")) {
      const start = 'ERROR: ValidationError(\\"';
      const end = "!";
      final startIndex = errorMessage.indexOf(start);
      final endIndex = errorMessage.indexOf(end, startIndex + start.length);
      error_message = errorMessage.substring(
          startIndex + start.length, endIndex); // brown fox jumps
      AppUtils.showDialog('Warning', error_message);
    } else if (errorMessage.contains("ERROR:") && errorMessage.contains('"}')) {
      const start = "ERROR:";
      const end = '"}';
      final startIndex = errorMessage.indexOf(start);
      final endIndex = errorMessage.indexOf(end, startIndex + start.length);
      error_message = errorMessage.substring(
          startIndex + start.length, endIndex); // brown fox jumps
      AppUtils.showDialog('Warning', error_message);
    } else if (errorMessage.contains('error_descrip":"')) {
      const start = 'error_descrip":"';
      const end = '"';
      final startIndex = errorMessage.indexOf(start);
      final endIndex = errorMessage.indexOf(end, startIndex + start.length);
      error_message =
          errorMessage.substring(startIndex + start.length, endIndex) +
              " (" +
              statusCode.toString() +
              ")"; // brown fox jumps
      AppUtils.showDialog('Warning', error_message);
    } else {
      AppUtils.showDialog('Warning', errorMessage);
    }
  }

  static String changeDateAndTimeFormat(String date) {
    var formatted_date = "";
    if (date != null && date.isNotEmpty) {
      formatted_date = DateFormat("MM/dd/yyyy HH:mm:ss")
          .format(DateTime.parse(date).add(Duration(hours: 6, minutes: 30)));
    } else {
      formatted_date = "";
    }

    return formatted_date;
  }

  static void showSuspendDialog(
    String title,
    String msg,
  ) {
    final box = GetStorage();
    Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      content: Text(msg),
      actions: [
        TextButton(
          child: Text('Yes', style: TextStyle(color: Colors.red)),
          onPressed: () {
            // box.write('emp_image',"");
            // OneSignal.shared.removeExternalUserId();
            // Get.offAllNamed(Routes.LOGIN);
            Get.offAllNamed(Routes.LOGIN);
          },
        ),
      ],
    );
  }
}
