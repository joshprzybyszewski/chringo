import 'package:flutter/material.dart';

class BingoTile extends StatefulWidget {
  final String word;
  BingoTile(this.word);

  @override
  _BingoTileState createState() => _BingoTileState(word);
}

class _BingoTileState extends State {
  bool _isChecked = false;
  final String word;
  _BingoTileState(this.word);

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