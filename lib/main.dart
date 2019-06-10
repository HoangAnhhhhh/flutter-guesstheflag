import 'package:flutter/material.dart';
import 'src/components/signin.dart';
import 'src/components/home.dart';
import 'src/components/history.dart';
void main() => runApp(GuessTheFlag());

class GuessTheFlag extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GuessTheFlag',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => SignIn(),
        '/home': (BuildContext context) => Home(),
        '/history': (BuildContext context) => History(),
      },
    );
  }
}