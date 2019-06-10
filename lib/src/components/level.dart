import 'package:flutter/material.dart';
import '../components/play.dart';

class Level extends StatelessWidget {
  Level();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),

        Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: Image.asset('assets/images/home/easy.jpeg',
                    fit: BoxFit.fitWidth),
              ),
            ),
            Positioned(
                bottom: 100.0,
                left: 10.0,
                right: 10.0,
                child: Center(
                    child: RaisedButton(
                  splashColor: Colors.amber,
                  textColor: Colors.amberAccent,
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Text(
                    "Easy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Play(level: 'Easy')));
                  },
                ))),
          ],
        ),
        SizedBox(
            height: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Choose Level',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 25.0, shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.amberAccent,
                    ),
                  ]),
                ),
              ],
            )),
        Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: Image.asset('assets/images/home/medium.jpeg',
                    fit: BoxFit.fitWidth),
              ),
            ),
            Positioned(
                bottom: 100.0,
                left: 10.0,
                right: 10.0,
                child: Center(
                    child: RaisedButton(
                  splashColor: Colors.amber,
                  textColor: Colors.amberAccent,
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Text(
                    "Medium",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Play(level: 'Medium')));
                  },
                ))),
          ],
        ),
      ],
    );
  }
}
