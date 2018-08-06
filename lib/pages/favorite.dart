import 'package:fikon/data/shumil.dart';
import 'package:fikon/model/main.dart';
import 'package:fikon/model/reading.dart';
import 'package:fikon/pages/reading.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        if (model.favorite.length == 0) {
          model.readFavorite();
          return Center(
            child: Text('no favorite'),
          );
        }
        return _buildFavorite(model);
      },
    );
  }

  Widget _buildFavorite(MainModel model) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: model.favorite.length * 2,
      itemBuilder: (BuildContext context, int index) {
        var books = model.favorite.values.toList();
        if (index.isOdd) {
          return Divider(color: Colors.teal[200]);
        }
        var book = books[index ~/ 2];
        return ListTile(
          leading: Image(
            image: NetworkImage(book.image),
            height: 75.0,
            width: 50.0,
          ),
          title: Row(
            children: <Widget>[
              Text(book.name),
              Icon(Icons.bookmark, color: Colors.red, size: 15.0),
            ],
          ),
          subtitle: Text(book.key),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ReadingPage(book),
              ),
            );
          },
        );
      },
    );
  }
}
