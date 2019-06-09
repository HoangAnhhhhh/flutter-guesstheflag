import 'package:flutter/material.dart';
import 'src/components/signin.dart';
import 'src/components/home.dart';
import 'src/components/level.dart';
import 'src/components/highscore.dart';
void main() => runApp(GuessTheFlag());

class GuessTheFlag extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GuessTheFlag',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => SignIn(),
        '/home': (BuildContext context) => Home(),
        '/level': (BuildContext context) => Level(),
        '/highscore': (BuildContext context) => HighScore(),
      },
    );
  }
}