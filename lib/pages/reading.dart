import 'package:fikon/data/book.dart';
import 'package:flutter/material.dart';

class ReadingPage extends StatelessWidget {
  ReadingPage(Book book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('show me the text')),
    );
  }
}
