import 'package:flutter/material.dart';

import 'src/pages/bingo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHRINGO',
      home: BingoPage(),
    );
  }
}
