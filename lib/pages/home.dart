import 'package:fikon/pages/favorite.dart';
import 'package:fikon/pages/rank.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String activePage = "favorite";
  RankPage rank;
  FavoritePage favorite;
  Map<String, Widget> pages;

  @override
  void initState() {
    super.initState();
    rank = RankPage();
    favorite = FavoritePage();
    pages = {
      "rank": rank,
      "favorite": favorite,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: pages[activePage],
      // drawer: _drawer(),
      bottomNavigationBar: _btmNavBar(),
      floatingActionButton: _fltActionBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Icon(Icons.import_contacts),
      title: Text("Fikon"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).pushNamed('/search');
          },
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            Navigator.of(context).pushNamed('/self_add');
          },
        ),
      ],
    );
  }

  Widget _btmNavBar() {
    return BottomAppBar(
      color: Colors.teal[100],
      shape: CircularNotchedRectangle(),
      notchMargin: 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.local_library),
            color: activePage == "favorite"
                ? Theme.of(context).accentColor
                : Colors.black,
            onPressed: () {
              setState(() {
                activePage = "favorite";
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.library_books),
            color: activePage == "rank"
                ? Theme.of(context).accentColor
                : Colors.black,
            onPressed: () {
              setState(() {
                activePage = "rank";
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _fltActionBar() {
    Icon _icon;
    if (activePage == "rank") {
      _icon = Icon(
        Icons.trending_up,
        color: Theme.of(context).accentColor,
      );
    } else if (activePage == "favorite") {
      _icon = Icon(
        Icons.refresh,
        color: Theme.of(context).accentColor,
      );
    }

    return FloatingActionButton(
      backgroundColor: Colors.teal[100],
      elevation: 0.0,
      mini: true,
      child: _icon,
      onPressed: () {},
    );
  }
}
