import 'package:fikon/data/book.dart';
import 'package:fikon/model/main.dart';
import 'package:fikon/pages/book.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

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
      backgroundColor: Theme.of(context).backgroundColor,
      title: Directionality(
        textDirection: Directionality.of(context),
        child: ScopedModelDescendant<MainModel>(
          builder: (context, child, model) => Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText: "try something to search",
                      hintStyle: TextStyle(color: Colors.black38),
                      isDense: true,
                    ),
                    onSubmitted: (String keywords) async {
                      // print('$keywords');
                      model.startSearch(_controller.text);
                    },
                    autofocus: true,
                    controller: _controller,
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      model.resetSearch();
                    },
                  )
                ],
              ),
        ),
      ),
    );

    return _appBar;
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        if (model.searchProgress == 'ready') {
          List<String> history = model.searchHistory;
          if (history == null) {
            model.readSearchHistory();
            return Center(child: Text('ready to search'));
          }
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Search History',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                        ScopedModelDescendant<MainModel>(
                            builder: (context, child, model) => IconButton(
                                  icon: Icon(Icons.delete_forever),
                                  onPressed: () {
                                    model.resetSearchHistory();
                                  },
                                )),
                      ],
                    ));
              }
              return Text(history[index]);
            },
          );
        } else if (model.searchProgress == "searching") {
          return Center(child: CircularProgressIndicator());
        } else if (model.searchProgress == 'done') {
          return ListView.builder(
            itemCount: model.searchResult.length,
            itemBuilder: _buildSearchResult(model),
          );
        }
      },
    );
  }

  _buildSearchResult(model) {
    return (BuildContext context, int index) {
      Book book = model.searchResult[index];
      String desc = book.introduction.length > 44
          ? book.introduction.substring(0, 44)
          : book.introduction;
      Widget leading = Image(
        width: 75.0,
        height: 100.0,
        // https://github.com/renefloor/flutter_cached_network_image/issues/55
        // image: new CachedNetworkImageProvider(book.image),
        image: NetworkImage(book.image),
      );
      Widget title = Text(
        book.name + ' by ' + book.author,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
      Widget subtitle = Text(
          '${book.site} | ${book.category} | ${book.progress} | ${book.wordCount}' +
              '\n$desc ...');
      return Card(
        margin: EdgeInsets.all(5.0),
        elevation: 5.0,
        child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
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
    };
  }
}
