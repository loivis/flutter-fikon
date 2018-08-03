import 'package:fikon/model/favorite.dart';
import 'package:fikon/model/search.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with FavoriteModel, SearchModel {}
