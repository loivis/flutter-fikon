import 'dart:async';
import 'package:fikon/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class Shumil {
  final String site = "书迷楼";
  final String baseUrl = "http://www.shumil.com";

  Future<List<Map<String, String>>> chapters(String book) async {
    var url = 'http://www.shumil.com/dadaochaotian/';
    final response = await http.get(url, headers: {
      'User-Agent': Const.userAgent,
    });
    var document = parse(response.body);
    var list = document.getElementsByClassName('zl');
    print(list.length);
  }
}
