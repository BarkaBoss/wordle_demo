import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:wordle/wordle.dart';

class HurdleProvider extends ChangeNotifier{
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];

  init(){
    totalWords = words.all.where((element) => element.length == 5).toList();
  }

  generateBoard(){
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }
}