import 'package:flutter/material.dart';

class HighScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Your highscore',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 25.0)),
          Text('Score',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 18.0)),
        ],
      ),
    );
  }
}
