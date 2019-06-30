import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(backgroundColor: Colors.amberAccent),
        SizedBox(height: 10.0),
        Text('loading...',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ],
    )));
  }
}
