import 'package:fikon/data/book.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoriteModel extends Model {
  Map<String, Book> _favorite = {};
  Map<String, Book> get favorite => _favorite;

  bool isFavorite(String key) {
    var keys = _favorite.keys;
    print('current book $key');
    print('${keys.length} books in favorite: $keys');
    if (keys.contains(key)) {
      return true;
    }
    return false;
  }

  void addFavorite(Book book) {
    print('add book ${book.key} to favorite');
    _favorite.addAll({book.key: book});
    notifyListeners();
  }

  void removeFavorite(String key) {
    print('remove $key from favorite');
    _favorite.remove(key);
    notifyListeners();
  }
}
