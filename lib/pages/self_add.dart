import 'package:flutter/material.dart';

class SelfAddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SelfAddPageState();
  }
}

class _SelfAddPageState extends State<SelfAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.playlist_add_check),
          onPressed: () {},
        ),
      ),
    );
  }
}
