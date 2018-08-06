import 'package:fikon/data/book.dart';
import 'package:fikon/model/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ReadingPage extends StatelessWidget {
  ReadingPage(Book book);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
        builder: (context, child, model) => Stack(
              fit: StackFit.expand,
              children: _buildStackChildren(context, size, model),
            ),
      ),
    );
  }

  List<Widget> _buildStackChildren(
      BuildContext context, Size size, MainModel model) {
    List<Widget> children = <Widget>[];

    Widget content = Material(color: Colors.black12);

    Widget touchLayer = Opacity(
      opacity: 0.0,
      child: Table(
        children: () {
          List<TableRow> rows = [];
          Map<Color, dynamic> onTap = {
            Colors.red: () {
              model.toggleMenuBar();
            },
            Colors.green: () {
              print('back');
            },
            Colors.blue: () {
              print('forward');
            },
          };
          for (var i = 0; i < 3; i++) {
            var row = TableRow(
              children: () {
                List<Widget> cells = [];
                for (var j = 0; j < 3; j++) {
                  Color color;
                  if (i == j && i == 1) {
                    color = Colors.red;
                  } else if (j < 2 && i + j <= 2) {
                    color = Colors.green;
                  } else {
                    color = Colors.blue;
                  }

                  Widget cell = GestureDetector(
                    child: Container(
                      width: size.width / 3,
                      height: size.height / 3,
                      decoration: BoxDecoration(color: color),
                    ),
                    onTap: onTap[color],
                  );
                  cells.add(cell);
                }
                return cells;
              }(),
            );
            rows.add(row);
          }
          return rows;
        }(),
      ),
    );

    List<Widget> menuBar = <Widget>[
      Positioned(
        height: size.height,
        width: size.width,
        child: GestureDetector(onTap: () {
          model.toggleMenuBar();
        }),
      ),
      Positioned(
          top: size.height - 100.0,
          width: size.width,
          child: BottomAppBar(
              color: Colors.teal[100],
              child: Row(children: <Widget>[
                FlatButton(onPressed: () {}, child: null)
              ]))),
      Positioned(
        top: size.height - 75.0,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '换源',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            Text(
              '字体',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            Text(
              '亮度',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ],
        ),
      ),
      Positioned(
        top: size.height * 2 / 3,
        left: size.width / 2 - 60.0,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, size: 50.0),
              onPressed: () {
                Navigator.of(context).pop();
                model.toggleMenuBar();
              },
            ),
            IconButton(
              icon: Icon(Icons.format_list_bulleted, size: 50.0),
              onPressed: () {
                print('list chapters');
              },
            ),
          ],
        ),
      ),
    ];

    children.addAll(<Widget>[content, touchLayer]);
    if (model.showMenuBar) {
      children.addAll(menuBar);
    }

    return children;
  }
}
