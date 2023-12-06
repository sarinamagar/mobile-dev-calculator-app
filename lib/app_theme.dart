import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

getAppTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  return ThemeData(
    fontFamily: 'Montserrat Medium',
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
