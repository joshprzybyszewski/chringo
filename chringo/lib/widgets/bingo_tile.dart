import 'package:auto_size_text/auto_size_text.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: AutoSizeText(
              word,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
              maxLines: 4,
              wrapWords: false,
              minFontSize: 8,
            ),
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