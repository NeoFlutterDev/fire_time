import 'package:flutter/material.dart';

class Quizzes extends StatefulWidget {
  const Quizzes({super.key, required this.title});
  final String title;

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '**WIP**',
          style: TextStyle(
            color: Colors.white
          )
        )
      )
    );
  }
}