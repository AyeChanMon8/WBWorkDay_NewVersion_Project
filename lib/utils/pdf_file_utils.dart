import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Future<String> createPDFFileFromString(String encodedStr) async {
//   //final encodedStr = "put base64 encoded string here";
//   Uint8List bytes = base64.decode(encodedStr);
//   String dir = (await getApplicationDocumentsDirectory()).path;
//   File file =
//       File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
//   await file.writeAsBytes(bytes);
//   return file.path.toString();
// }

 Future<void> createPDFFileFromString(String encodedStr) async {
    //final encodedStr = "put base64 encoded string here";
    if (Platform.isAndroid) {
      // var status = await Permission.storage.status;
      // if (!status.isGranted) {
      //   print("request");
      //   await Permission.storage.request();
      // }
      Uint8List bytes = base64.decode(encodedStr);
      final directory = await getExternalStorageDirectory();

        if (directory == null) {
          print('Could not get external storage directory');
          return;
        }

        final downloadFolder = Directory('${directory.path}/Download');
        if (!await downloadFolder.exists()) {
          await downloadFolder.create(recursive: true);
        }
      // String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File(
          "${downloadFolder.path}/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      await file.writeAsBytes(bytes);
      // await requestManageExternalStoragePermission();
      await OpenFile.open(file.path.toString());
    // return file.path.toString();
    } else {
      Uint8List bytes = base64.decode(encodedStr);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File(
          "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      await file.writeAsBytes(bytes);
      // await requestManageExternalStoragePermission();
      await OpenFile.open(file.path.toString());
    }
    
    // Uint8List bytes = base64.decode(encodedStr);
    // String dir = (await getApplicationDocumentsDirectory()).path;
    // File file = File(
    //     "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    // await file.writeAsBytes(bytes);
    // return file.path.toString();
  }

  Future<void> requestManageExternalStoragePermission() async {
    if (Platform.isAndroid && await Permission.manageExternalStorage.isDenied) {
      var status = await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        print("Permission granted.");
      } else {
        print("Permission denied.");
        // Redirect the user to app settings to enable the permission
        await openAppSettings();
      }
    }
}


Future<String> createExcelFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".xls");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}

Future<String> createWordFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".doc");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}

Future<String> createDocxWordFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".docx");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}

Future<String> createExFileFromString(String encodedStr) async {
  //final encodedStr = "put base64 encoded string here";
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file =
      File("$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".xlsx");
  await file.writeAsBytes(bytes);
  return file.path.toString();
}
