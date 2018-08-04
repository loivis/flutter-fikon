import 'dart:async';
import 'dart:convert';
import 'package:fikon/data/book.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteModel extends Model {
  Map<String, Book> _favorite = {};
  Map<String, Book> get favorite => _favorite;

  readFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    // print(prefs.getKeys());
    // prefs.clear();
    var favString = prefs.getString('favorite');
    print('favString from shared preferences: $favString');
    if (favString != null) {
      Map<String, dynamic> favJson = json.decode(favString);
      favJson.forEach((k, v) {
        var book = Book.fromFavorite(v);
        _favorite.addAll({book.key: book});
      });
      notifyListeners();
    }
  }

  bool isFavorite(String key) {
    print(_favorite);
    var keys = _favorite.keys;
    print('current book $key');
    print('${keys.length} books in favorite: $keys');
    if (keys.contains(key)) {
      return true;
    }
    return false;
  }

  Future addFavorite(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    print('add book ${book.key} to favorite');
    _favorite.addAll({book.key: book});
    prefs.setString('favorite', json.encode(_favorite));
    notifyListeners();
  }

  Future removeFavorite(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print('remove $key from favorite');
    _favorite.remove(key);
    prefs.setString('favorite', _favorite.toString());
    notifyListeners();
  }
}
