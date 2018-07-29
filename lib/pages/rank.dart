import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RankPageState();
  }
}

class _RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      ),
    );
  }
}
