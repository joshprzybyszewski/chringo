import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

final dummySnapshot = [
  {"name": "Filip", "votes": 15},
  {"name": "Abraham", "votes": 14},
  {"name": "Richard", "votes": 11},
  {"name": "Ike", "votes": 10},
  {"name": "Justin", "votes": 1},
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
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
        Record wordsRecord;
        // TODO if no data, show error
        if (snapshot.hasData) {
          wordsRecord = Record.fromSnapshot(snapshot.data.documents.first);
        }

        return _buildGrid(context, wordsRecord.words);
      },
    );
  }

  Widget _buildGrid(BuildContext context, List<String> words) {
    return GridView.count(
      // Create a 5x5 bingo grid
      crossAxisCount: 5,
      // Generate 25 bingo squares
      children: List.generate(25, (index) {
        return new BingoCard(words[index]);
      }),
    );
  }
}

class BingoCard extends StatefulWidget {
  final String word;
  BingoCard(this.word);

  @override
  _BingoCardState createState() => _BingoCardState(word);
}

class _BingoCardState extends State {
  bool _isChecked = false;
  final String word;
  _BingoCardState(this.word);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: _isChecked ? Colors.green : Colors.white,
        child: Center(
          child: Text(
            word,
            style: Theme.of(context).textTheme.subtitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: _toggleChecked,
    );
  }

  void _toggleChecked() {
    setState(() => _isChecked = !_isChecked);
  }
}

class Record {
  final List<String> words;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['words'] != null),
        words = List<String>.from(map['words']);

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$words>";
}
