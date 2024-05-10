import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/hurlde_provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Hurdle"),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<HurdleProvider>(
              builder: (context, provider, child) => GridView.builder(
                  gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: provider.hurdleBoard.length,
                  itemBuilder: (context, index){
                    provider.hurdleBoard[index];
                  }
                  ),
            )
          ],
        ),
      ),
    );
  }
}
