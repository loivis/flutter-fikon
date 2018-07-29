import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _FavoritePageState();
  }
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.ac_unit,
            size: 50.0,
          ),
          title: Row(
            children: <Widget>[
              Text('帝国坑价格多少'),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                color: Colors.red,
                child: Text('10+ New'),
              ),
            ],
          ),
          subtitle: Text('32分钟之前更新: 章节数 章节名称'),
        ),
        Divider(color: Colors.teal[200]),
        ListTile(
          leading: Icon(
            Icons.beach_access,
            size: 50.0,
          ),
          title: Row(
            children: <Widget>[
              Text('帝国坑价格多少'),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                color: Colors.red,
                child: Text('10+更新', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          subtitle: Text('32分钟之前更新: 章节数 章节名称'),
        ),
        Divider(color: Colors.teal[200]),
        ListTile(
          leading: Icon(
            Icons.camera_enhance,
            size: 50.0,
          ),
          title: Row(
            children: <Widget>[
              Text('帝国坑价格多少'),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                color: Colors.red,
                child: Text('10+ New'),
              ),
            ],
          ),
          subtitle: Text('32分钟之前更新: 章节数 章节名称'),
        ),
      ],
    );
  }
}
