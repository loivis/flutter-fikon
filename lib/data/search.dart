import 'dart:async';
import 'package:fikon/data/qidian.dart';

import 'package:fikon/data/book.dart';
import 'package:fikon/data/zongheng.dart';

class Search {
  List<Book> books = [];
  String keywords;

  Search(this.keywords);

  Future<List<Book>> get() async {
    var books = <Book>[];
    var results = await Future.wait([
      Qidian().search(keywords),
      Zongheng().search(keywords),
    ]);
    for (var r in results) {
      books.addAll(r);
    }
    return books;
  }
}
