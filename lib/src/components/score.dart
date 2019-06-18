import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/history.dart';

class Score extends StatelessWidget {
  final String level;
  final int score;
  History historyFromClass;
  CollectionReference historyCollection =
      Firestore.instance.collection('history');
  Score({Key key, @required this.level, @required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$level Level',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Your Score',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$score',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Back to Home',
        child: Icon(Icons.home),
        backgroundColor: Colors.amberAccent,
        clipBehavior: Clip.antiAlias,
        onPressed: () {
          FirebaseAuth.instance.onAuthStateChanged
              .listen((FirebaseUser firebaseUser) {
            if (firebaseUser != null) {
              String dateTime =
                  DateTime.now().toLocal().toString();
              historyFromClass =
                  History(firebaseUser.uid, dateTime, this.score, this.level);
              historyCollection.add(historyFromClass.toJSON()).whenComplete(
                  () => Navigator.popUntil(
                      context, ModalRoute.withName('/home')));
            } else
              print('null user');
          });
          Navigator.popUntil(context, ModalRoute.withName('/home'));
        },
      ),
    );
  }
}
