import 'dart:async';

import 'package:fikon/data/book.dart';
import 'package:fikon/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class Qidian {
  final String site = "起点";
  final String baseUrl = "https://www.qidian.com";
  final String searchUrl = 'https://www.qidian.com/search?kw=';

  Future<List<Book>> search(keywords) async {
    var books = <Book>[];

    print('search $keywords at ${this.site}');
    var url = this.searchUrl + keywords;
    final response = await http.get(url, headers: {
      'User-Agent': Const.userAgent,
      'Referer': 'https://www.qidian.com/',
    });
    if (response.statusCode != 200) {
      print('failed to search $keywords at ${this.site}');
      return books;
    }
    final document = parse(response.body);
    var elements = document.getElementsByClassName('res-book-item');
    for (var e in elements) {
      // print(e.outerHtml);
      var image = 'https:' +
          e
              .getElementsByClassName('book-img-box')[0]
              .getElementsByTagName('img')[0]
              .attributes['src'];
      var info = e.getElementsByClassName('book-mid-info')[0];
      var h4a = info.getElementsByTagName('h4')[0].getElementsByTagName('a')[0];
      var link = 'https:' + h4a.attributes['href'];
      var chapterLink = link;
      var id = h4a.attributes['data-bid'];
      var name = h4a.text;
      var authorClass = info.getElementsByClassName('author')[0];
      var author = authorClass.children[1].text;
      var category = authorClass.children[3].text;
      var progress = authorClass.children[5].text;
      var intro = info.getElementsByClassName('intro')[0].text.trim();
      var wordCount = e
          .getElementsByClassName('book-right-info')[0]
          .getElementsByClassName('total')[0]
          .getElementsByTagName('span')[0]
          .text
          .trim();

      var book = Book(id, name, this.site, link, author, intro, image, category,
          progress, wordCount, chapterLink);
      print(book);
      books.add(book);
    }

    print('return ${books.length} books from ${this.site} for $keywords');
    return books;
  }
}
