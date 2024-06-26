import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/helper_funtions.dart';
import 'package:wordle/hurlde_provider.dart';
import 'package:wordle/keyboard_view.dart';
import 'package:wordle/wordle_view.dart';

class WordHurdle extends StatefulWidget {
  const WordHurdle({super.key});

  @override
  State<WordHurdle> createState() => _WordHurdleState();
}

class _WordHurdleState extends State<WordHurdle> {
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Hurdle"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.80,
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: provider.hurdleBoard.length,
                      itemBuilder: (context, index) {
                        final wordle = provider.hurdleBoard[index];
                        return WordleView(wordle: wordle);
                      }),
                ),
              ),
            ),
            Consumer<HurdleProvider>(
              builder: (context, provider, child) => KeyboardView(
                  excludedLetters: provider.excludedLetters,
                  onPressed: (value) {
                    provider.inputLetters(value);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<HurdleProvider>(
                builder: (context, provider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {
                      provider.deleteLetter();
                    }, child: const Text("DELETE")),
                    ElevatedButton(onPressed: () {
                      if(!provider.isAValidWord){
                        showMessage(context, "Not a word in my dictionary");
                        return;
                      }
                      if(provider.shouldCheckForAnswer){
                        provider.checkCorrectAnswer();
                      }
                      if(provider.win){
                        // showResult(context: context,
                        //     title: "Congratulations!!",
                        //     body: "The word is ${provider.targetWord}",
                        //     onPlayAgain: (){},
                        //     onCancel: (){}
                        // );

                        showDia(context: context, title: "Test", body: "body",
                            isChecked: false,
                            onConfirm: (){},
                            onCancel: (){},
                          checkBox: StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Checkbox(
                                  checkColor: Colors.white,
                                  value: isChecked,
                                  onChanged: (value){

                                    setState(() {
                                      isChecked = value!;
                                      print(isChecked);
                                    });
                                  });
                            },
                          )
                        );
                      }
                    }, child: const Text("SUBMIT"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
