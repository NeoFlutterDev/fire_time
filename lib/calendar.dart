import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key, required this.title});
  final String title;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
      ),
    );
  }
}