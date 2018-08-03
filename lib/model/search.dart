import 'dart:async';

import 'package:fikon/data/book.dart';
import 'package:fikon/data/search.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchModel extends Model {
  List<Book> _books = [];
  List<Book> get searchResult => _books;

  String _progress = 'ready';
  String get searchProgress => _progress;

  List<String> _searchHistory = [];
  List<String> get searchHistory => _searchHistory;

  Future startSearch(String keywords) async {
    print('start searching: $keywords');
    _progress = 'searching';
    notifyListeners();
    var result = await Search(keywords).get();
    _books = result;
    _progress = 'done';
    print('search finished');
    notifyListeners();
  }

  void addHistory(String s) {
    _searchHistory.add(s);
  }

  void resetSearch() {
    _books = [];
    notifyListeners();
  }
}
