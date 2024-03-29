import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../records/wordbanks_record.dart';
import '../widgets/bingo_grid.dart';

class BingoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CHRINGO')),
      body: StreamBuilder<QuerySnapshot>(
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
      ),
    );
  }
}
