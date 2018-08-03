import 'package:fikon/data/book.dart';
import 'package:fikon/model/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BookPage extends StatefulWidget {
  Book book;
  BookPage(this.book);

  @override
  State<StatefulWidget> createState() {
    return _BookPageState();
  }
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('书籍简介'),
      centerTitle: true,
      actions: <Widget>[
        ScopedModelDescendant<MainModel>(
          builder: (context, child, model) => IconButton(
                icon: model.isFavorite(widget.book.key)
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  if (model.isFavorite(widget.book.key)) {
                    model.removeFavorite(widget.book.key);
                  } else {
                    model.addFavorite(widget.book);
                  }
                },
              ),
        ),
        IconButton(
          icon: Icon(Icons.cloud_download),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image(
                image: NetworkImage(widget.book.image),
                height: 100.0,
                width: 75.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text(
                          widget.book.name + ' by ' + widget.book.author,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text([
                        widget.book.site,
                        widget.book.category,
                        widget.book.progress,
                        widget.book.wordCount
                      ].join(' | '))),
                  Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text('last update time')),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text('收藏'),
                onPressed: () {},
              ),
              RaisedButton(
                child: Text('阅读'),
                onPressed: () {},
              )
            ],
          ),
          Container(
            child: Text(widget.book.introduction),
          ),
        ],
      ),
    );
  }
}
