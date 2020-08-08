import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.lightBlueAccent, // navigation bar color
    statusBarColor: Colors.lightBlueAccent, // status bar color
  ));
  runApp(new App());
}
