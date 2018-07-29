import 'package:fikon/pages/home.dart';
import 'package:fikon/pages/search.dart';
import 'package:fikon/pages/self_add.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
    title: "fikon",
    home: new Home(),
    theme: _themeData(),
    routes: {
      "/search": (context) => new SearchPage(),
      "/self_add": (context) => new SelfAddPage(),
    },
  ));
}

ThemeData _themeData() {
  // https://docs.flutter.io/flutter/material/ThemeData-class.html
  return ThemeData(
    primaryColor: Colors.teal,
    accentColor: Colors.purple,
    backgroundColor: Colors.teal[100],
    buttonColor: Colors.teal[100],
    // primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
  );
}
