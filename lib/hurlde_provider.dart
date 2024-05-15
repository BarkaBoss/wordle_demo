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
  final totalAttempts = 6;
  int attempts  = 0;
  bool win = false;

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

  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;
  bool get checkAnswer => targetWord == rowInputs.join('');

  void checkCorrectAnswer(){
    if(targetWord == rowInputs.join('')){
      win = true;
    }else{
      _markLetterOnBoard();
      if(attempts < totalAttempts){
        _goToNextRow();
      }
    }
  }

  void _markLetterOnBoard() {
    for(int i = 0; i <  hurdleBoard.length; i++){
      if(hurdleBoard[i].letter.isNotEmpty && targetWord.contains(hurdleBoard[i].letter)){
        hurdleBoard[i].existsInTarget = true;
      }else if(hurdleBoard[i].letter.isNotEmpty && !targetWord.contains(hurdleBoard[i].letter)){
        hurdleBoard[i].doesNotExistsInTarget = true;
        excludedLetters.add(hurdleBoard[i].letter);
      }
    }
    notifyListeners();
  }

  void _goToNextRow() {
    attempts++;
    count  = 0;
    rowInputs.clear();
  }
}