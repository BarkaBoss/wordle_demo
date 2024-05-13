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
  String targetWord = '';
  int count = 0;
  int index = 0;
  final lettersPerRow = 5;

  init(){
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandomWord();
  }

  generateBoard(){
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  generateRandomWord(){
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    print(targetWord);
  }

  inputLetters(String letter){
    if(count < lettersPerRow){
      rowInputs.add(letter);
      count++;
      hurdleBoard[index] = Wordle(letter: letter);
      index++;
      notifyListeners();
    }
  }

  void deleteLetter() {
    if(rowInputs.isNotEmpty){
      rowInputs.removeAt(rowInputs.length - 1);
    }

    if(count > 0){
      hurdleBoard[index - 1] = Wordle(letter: "");
      count--;
      index--;
    }

    notifyListeners();
  }
  bool get isAValidWord => totalWords.contains(rowInputs.join('').toLowerCase());
}