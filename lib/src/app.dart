import 'package:flutter/material.dart';
import 'package:tlaco_point/resources/AppTheme.dart';
import 'package:tlaco_point/src/pages/log_in/log_inn.dart';
import 'package:tlaco_point/src/pages/main_menu.dart';
import 'package:tlaco_point/src/pages/log_in/loading.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
        home: Center(child: Loginn()),
        theme: ThemeData(
            primaryColor: AppTheme.primaryColor,
            primaryColorLight: AppTheme.primaryLightColor,
            primaryColorDark: AppTheme.primaryDarkColor,
            backgroundColor: AppTheme.white,
            buttonTheme: ButtonThemeData(
                buttonColor: AppTheme.primaryLightColor,
                splashColor: AppTheme.primaryDarkColor,
                textTheme: ButtonTextTheme.primary)));
  }
}
