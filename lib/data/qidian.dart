import 'dart:async';

import 'package:fikon/data/book.dart';
import 'package:fikon/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class Qidian {
  final String site = "起点";
  final String baseUrl = "https://m.qidian.com";
  final String searchUrl = 'https://m.qidian.com/search?kw=';

  Future<List<Book>> search(keywords) async {
    var books = <Book>[];

    print('search $keywords at ${this.site}');
    var url = this.searchUrl + keywords;
    final response = await http.get(url, headers: {
      'User-Agent': Const.userAgent,
      'Referer': 'https://m.qidian.com/'
    });
    final document = parse(response.body);
    var elements = document.getElementsByClassName('book-li');
    for (var e in elements) {
      // print(e.outerHtml);
      var link = this.baseUrl +
          e.getElementsByClassName('book-layout')[0].attributes['href'];
      var id = RegExp(r'[0-9]+').stringMatch(link);
      var image = 'https:' +
          e.getElementsByClassName('book-cover')[0].attributes['data-src'];
      var name = e.getElementsByClassName('book-title')[0].text;
      var intro = e.getElementsByClassName('book-desc')[0].text;
      var author = e
          .getElementsByClassName('book-author')[0]
          .text
          .replaceAll('作者', '')
          .trim();
      var category = e.getElementsByClassName('gray')[0].text;
      var progress = e.getElementsByClassName('red')[0].text;
      var wordCount =
          e.getElementsByClassName('blue')[0].text.replaceAll('字', '');

      books.add(Book(id, name, this.site, link, author, intro, image, category,
          progress, wordCount));
    }

    print('return ${books.length} books from ${this.site} for ${keywords}');
    return books;
  }
}
