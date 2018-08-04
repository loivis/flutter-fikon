import 'dart:math';

class ReadingModel {
  final List<Map<String, String>> _sources = [
    {'书迷楼': 'http://www.shumil.com'},
    {'盗梦人': 'http://www.daomengren.com'},
  ];

  Map<String, String> randomSource() {
    int index = Random().nextInt(_sources.length);
    return _sources[index];
  }
}
