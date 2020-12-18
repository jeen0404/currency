import 'package:currency/view/ui/screen/main_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> authenticatedAppRoute(RouteSettings routeSettings) {
  //final arguments = routeSettings.arguments;

  /// for handline parms

  switch (routeSettings.name) {

  /// in dafult route user will land in main screen
    default:
      return MaterialPageRoute(builder: (_) => MainScreen());
  }
}
