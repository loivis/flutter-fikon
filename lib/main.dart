import 'package:fikon/model/main.dart';
import 'package:fikon/pages/home.dart';
import 'package:fikon/pages/search.dart';
import 'package:fikon/pages/self_add.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(Fikon());

class Fikon extends StatelessWidget {
  final _routes = <String, WidgetBuilder>{
    "/search": (context) => SearchPage(),
    "/self_add": (context) => SelfAddPage(),
  };

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        title: "fikon",
        home: Home(),
        theme: _themeData(),
        routes: _routes,
      ),
    );
  }

  ThemeData _themeData() {
    // https://docs.flutter.io/flutter/material/ThemeData-class.html
    return ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.amber[800],
      backgroundColor: Colors.indigo[200],
      buttonColor: Colors.indigo[300],
      // primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black)),
    );
  }
}
