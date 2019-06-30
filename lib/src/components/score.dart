import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history.dart';
import './loading.dart';

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

class _Score extends State<Score> with SingleTickerProviderStateMixin {
  final String level;
  final int score;
  History historyFromClass;
  AnimationController _controller;
  Animation<double> _scaleAnimation, _rotateAnimation;
  _Score({Key key, @required this.level, @required this.score});

  @override
  void initState() {
    super.initState();
    this._controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    this._scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: this._controller, curve: Curves.fastOutSlowIn));
    this._rotateAnimation = Tween<double>(begin: 15.0, end: 0.0).animate(
        CurvedAnimation(parent: this._controller, curve: Curves.fastOutSlowIn));
    this._controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
    print('dispose: score');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: this._controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            body: ScaleTransition(
              scale: this._scaleAnimation,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('$level Level',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 35.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Your Score',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('$score',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            floatingActionButton: Transform.rotate(
              angle: this._rotateAnimation.value,
              child: FloatingActionButton(
                tooltip: 'Back to Home',
                child: Icon(Icons.home),
                backgroundColor: Colors.amberAccent,
                clipBehavior: Clip.antiAlias,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String userID = prefs.getString('userID');
                  String dateTime = DateTime.now().toLocal().toString();
                  historyFromClass =
                      History(userID, dateTime, this.score, this.level);
                  CollectionReference historyCollection =
                      Firestore.instance.collection('$userID-history');
                  historyCollection.add(historyFromClass.toJSON()).whenComplete(
                      () => Navigator.popUntil(
                          context, ModalRoute.withName('/home')));
                },
              ),
            ),
          );
        });
  }
}
