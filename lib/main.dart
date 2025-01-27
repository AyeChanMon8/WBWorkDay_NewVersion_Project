import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/app.dart';

const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FlutterDownloader.initialize(debug: debug);  package downloader not need now
  await GetStorage.init();
  runApp(App());
}
