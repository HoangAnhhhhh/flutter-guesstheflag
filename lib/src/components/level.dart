import 'package:flutter/material.dart';
import '../components/play.dart';
class Level extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            color: Colors.deepPurpleAccent,
            textColor: Colors.white,
            splashColor: Colors.white,
            child: Text('Easy'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Play(level: 'Easy')));
              // Navigator.pushNamed(context, 'level', arguments: 'Easy');
            },
          ),
          RaisedButton(
            color: Colors.deepPurpleAccent,
            textColor: Colors.white,
            splashColor: Colors.white,
            child: Text('Medium'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Play(level: 'Medium')));
              // Navigator.pushNamed(context, 'level', arguments: 'Medium');
            },
          ),
        ],
      ),
    );
  }
}