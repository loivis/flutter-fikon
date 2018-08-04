import 'dart:async';

import 'package:fikon/data/book.dart';
import 'package:fikon/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class Zongheng {
  final String site = "纵横";
  final String baseUrl = 'https://m.zongheng.com/h5/book?bookid=';
  final String searchUrl =
      "https://wap.zongheng.com/search?field=all&keywords=";
  // String bookUrl = 'https://m.zongheng.com/h5/book?bookid=ID&fpage=search&fmodule=searchlist&h5=1';

  Future<List<Book>> search(keywords) async {
    var books = <Book>[];

    print('search $keywords at ${this.site}');
    String url = this.searchUrl + keywords;
    var response = await http.get(url, headers: {
      'User-Agent': Const.userAgent,
      'Referer': 'https://wap.zongheng.com/search',
    });
    var search = parse(response.body);
    var elements = search.getElementsByTagName('li');
    for (var e in elements) {
      var uri = e.getElementsByTagName('a')[0].attributes['href'];
      var id = RegExp(r'[0-9]+').stringMatch(uri);
      var link = baseUrl + id;
      var name = e.getElementsByTagName('span')[0].text;
      var p = e.getElementsByTagName('p');
      var author = p[0]
          .text
          .replaceFirst(name, '')
          .trim()
          .replaceFirst(RegExp(r'著$'), '');
      var p1 = p[1].text.split(' - ');
      var category = p1[0];
      var progress = p1[1];
      // print('$id, $name, $author, $category, $progress');

      response = await http.get(link, headers: {
        'User-Agent': Const.userAgent,
        'Referer': 'https://m.zongheng.com/h5/searchrank?fpage=33&fmodule=55',
      });
      var detail = parse(response.body);
      var image = detail
          .getElementsByClassName('bookimg')[0]
          .getElementsByTagName('img')[0]
          .attributes['src'];
      var wordCount = detail
          .getElementsByClassName('info')[0]
          .getElementsByTagName('span')[2]
          .text;
      var intro = detail.getElementsByClassName('book_intro')[0].text.trim();

      var book = Book(id, name, this.site, link, author, intro, image, category,
          progress, wordCount, null);
      print(book);
      books.add(book);
    }

    print('return ${books.length} books from ${this.site} for ${keywords}');
    return books;
  }
}
