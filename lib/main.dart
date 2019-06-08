import 'package:flutter/material.dart';

void main() => runApp(GuessTheFlag());

class GuessTheFlag extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GuessTheFlagState();
}

class _GuessTheFlagState extends State<GuessTheFlag>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GuessTheFlag',
      debugShowCheckedModeBanner: false,
    );
  }
}