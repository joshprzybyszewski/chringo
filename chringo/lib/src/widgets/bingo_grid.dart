import 'dart:math';
import 'package:flutter/material.dart';
import 'bingo_tile.dart';

class BingoGrid extends StatelessWidget {
  final List<String> words;
  BingoGrid(this.words);

  @override
  Widget build(BuildContext context) {
    var rand = Random();
    var tiles = <BingoTile>[];
    while (tiles.length < 25) {
      tiles.add(BingoTile(words.removeAt(rand.nextInt(words.length))));
    }
    return GridView.count(
      // Create a 5x5 bingo grid
      crossAxisCount: 5,
      // Generate 25 bingo squares
      children: tiles,
    );
  }
}
