import 'package:flutter/material.dart';

class FlashCards extends StatefulWidget {
  const FlashCards({super.key, required this.title});
  final String title;

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
      ),
    );
  }
}

class FlashCardCreator extends StatefulWidget {
  const FlashCardCreator({super.key, required this.title});
  final String title;

  @override
  State<FlashCardCreator> createState() => _FlashCardCreatorState();
}

class _FlashCardCreatorState extends State<FlashCardCreator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle.merge(
        child: const Center(
          child: Text('Flutter'),
        ),
      ),
    );
  }
}