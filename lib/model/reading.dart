import 'dart:math';

import 'package:scoped_model/scoped_model.dart';

class ReadingModel extends Model {
  final List<Map<String, String>> _sources = [
    {'书迷楼': 'http://www.shumil.com'},
    {'盗梦人': 'http://www.daomengren.com'},
  ];

  bool _showMenuBar = false;
  bool get showMenuBar => _showMenuBar;

  Map<String, String> randomSource() {
    int index = Random().nextInt(_sources.length);
    return _sources[index];
  }

  void toggleMenuBar() {
    _showMenuBar = !_showMenuBar;
    notifyListeners();
  }
}
