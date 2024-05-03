import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});
  final String title;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      ),
    );
  }
}