import 'package:fikon/data/book.dart';
import 'package:fikon/data/search.dart';
import 'package:fikon/pages/book.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  String _searchStatus;
  final _controller = TextEditingController();
  List<Book> _result;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    Widget _appBar;

    _controller.addListener(() {
      // if (_controller.text.isEmpty) {
      //   print('null input');
      //   return;
      // }
    });

    _appBar = AppBar(
      backgroundColor: Colors.teal[300],
      title: Directionality(
        textDirection: Directionality.of(context),
        child: TextField(
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          decoration: InputDecoration(
            hintText: "try something to search",
            hintStyle: TextStyle(color: Colors.black38),
            isDense: true,
          ),
          onSubmitted: (String val) async {
            // print(val);
            setState(() {
              _searchStatus = "ongoing";
            });
            // print(_controller.text);
            Search(_controller.text).get().then((data) {
              setState(() {
                _searchStatus = "done";
                _result = data;
              });
            });
          },
          autofocus: true,
          controller: _controller,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            _controller.clear();
          },
        )
      ],
    );

    return _appBar;
  }

  Widget _buildBody() {
    Widget _body;

    if (_result == null) {
      _body = Center(
        child: Text('ready to search'),
      );
    } else {
      _body = ListView.builder(
        itemCount: _result.length,
        itemBuilder: (BuildContext context, int index) {
          Book book = _result[index];
          // return ListTile(
          //   title: Text(_result[index].name),
          // );
          String desc = book.introduction.length > 44
              ? book.introduction.substring(0, 44)
              : book.introduction;
          return Card(
            margin: EdgeInsets.all(5.0),
            elevation: 5.0,
            child: ListTile(
              leading: Image(
                width: 75.0,
                height: 100.0,
                // https://github.com/renefloor/flutter_cached_network_image/issues/55
                // image: new CachedNetworkImageProvider(book.image),
                image: NetworkImage(book.image),
              ),
              title: Text(
                book.name + ' by ' + book.author,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text([
                    book.site,
                    book.category,
                    book.progress,
                    book.wordCount
                  ].join(' | ') +
                  '\n' +
                  desc +
                  ' ...'),
              isThreeLine: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => BookPage(book),
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return _body;
  }
}
