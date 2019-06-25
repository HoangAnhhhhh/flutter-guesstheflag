import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history.dart';

class Score extends StatefulWidget {
  final String level;
  final int score;
  Score({Key key, @required this.level, @required this.score})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Score(level: this.level, score: this.score);
  }
}

class _Score extends State<Score> {
  final String level;
  final int score;
  History historyFromClass;
  _Score({Key key, @required this.level, @required this.score});

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
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          String userID = prefs.getString('userID');
          String dateTime = DateTime.now().toLocal().toString();
          historyFromClass = History(userID, dateTime, this.score, this.level);
          CollectionReference historyCollection =
              Firestore.instance.collection('$userID-history');
          historyCollection.add(historyFromClass.toJSON()).whenComplete(
              () => Navigator.popUntil(context, ModalRoute.withName('/home')));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose: score');
  }
}
