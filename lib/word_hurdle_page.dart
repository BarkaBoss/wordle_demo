import 'package:flutter/material.dart';

class WordHurdle extends StatefulWidget {
  const WordHurdle({super.key});

  @override
  State<WordHurdle> createState() => _WordHurdleState();
}

class _WordHurdleState extends State<WordHurdle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Hurdle"),
      ),
    );
  }
}
