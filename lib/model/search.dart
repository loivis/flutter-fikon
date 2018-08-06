import 'dart:async';
import 'package:fikon/data/book.dart';
import 'package:fikon/data/search.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchModel extends Model {
  List<Book> _books = [];
  List<Book> get searchResult => _books;

  String _progress = 'ready';
  String get searchProgress => _progress;

  List<String> _searchHistory = [];
  List<String> get searchHistory => _searchHistory;

  readSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    print('read saved search: $_searchHistory');
    if (_searchHistory == null) {
      _searchHistory = prefs.getStringList('searchHistory');
      print('saved search: $_searchHistory');
      notifyListeners();
    }
  }

  clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('searchHitory');
  }

  Future startSearch(String keywords) async {
    final prefs = await SharedPreferences.getInstance();
    print('start searching: $keywords');
    _progress = 'searching';
    notifyListeners();
    _searchHistory.add(keywords);
    prefs.setStringList('searchHistory', _searchHistory);
    var result = await Search(keywords).get();
    _books = result;
    _progress = 'done';
    print('search finished');
    notifyListeners();
  }

  void resetSearch() {
    _books = [];
    notifyListeners();
  }

  void resetSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('searchHistory');
    _searchHistory = [];
    notifyListeners();
  }
}
