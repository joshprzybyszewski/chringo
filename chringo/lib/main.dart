import 'package:chringo/records/wordbanks_record.dart';
import 'package:chringo/widgets/bingo_grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHRINGO',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CHRINGO')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('wordbanks').snapshots(),
      builder: (context, snapshot) {
        WordbanksRecord wordsRecord;
        // TODO if no data, show error
        if (snapshot.hasData) {
          wordsRecord =
              WordbanksRecord.fromSnapshot(snapshot.data.documents.first);
        }
        return BingoGrid(wordsRecord.words);
      },
    );
  }
}
