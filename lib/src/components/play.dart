import 'package:flutter/material.dart';
import 'package:flutter_app/src/components/score.dart';
import 'dart:math';
import 'dart:async';
import '../models/flag.dart';
import '../models/easy.dart';
import '../models/medium.dart';

class Play extends StatefulWidget {
  final String level;
  Play({Key key, @required this.level}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PlayState(this.level);
}

class _PlayState extends State<Play> {
  final String _level;
  int _indexFlag = 0;
  int _timeEachQuestion = 10;
  List<Flag> _flagList;
  List<String> _answerList;
  int _point = 0;
  bool _is5050ButtonDisabled;
  bool _isAnswerButtonDisabled;
  _PlayState(this._level);

  String _isEaseOrMedium() => this._level == 'Easy' ? 'Easy' : 'Medium';

  // initialize flag list based-on easy or medium level
  List<Flag> _initFlagList(String level) => this._isEaseOrMedium() == 'Easy'
      ? this._flagList = EasyLevel.getFlags()
      : this._flagList = MediumLevel.getFlags();

  // this function takes an index of flag list to know which answer is already use
  // so that to prepare new answers
  List<String> _prepareAnswers(int index) {
    String a, b, c, d;
    List<String> listAnswer = <String>[];
    a = this._flagList[index].getName();
    do {
      b = this._flagList[Random().nextInt(this._flagList.length)].getName();
    } while (b == a);
    do {
      c = this._flagList[Random().nextInt(this._flagList.length)].getName();
    } while (c == a || c == b);
    do {
      d = this._flagList[Random().nextInt(this._flagList.length)].getName();
    } while (d == a || d == b || d == c);
    listAnswer.addAll([a, b, c, d]);
    listAnswer.shuffle();
    return listAnswer;
  }

  Timer _nextQuestion() {
    return Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          this._timeEachQuestion -= 1;
          if (this._timeEachQuestion == 0) {
            this._timeEachQuestion = 10;
            print('Next Question');
            if (_indexFlag < this._flagList.length - 1) {
              // increase the index to get new question and prepare the answers also
              _indexFlag++;
              this._answerList = this._prepareAnswers(this._indexFlag);
            } else {
              this._timeEachQuestion = 0;
              t.cancel();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Score(level: this._level, score: this._point)));
            }
          }
        });
      }
    });
  }

  void _chooseAnswer(String answer, BuildContext context) {
    if (answer.compareTo(this._flagList[this._indexFlag].getName()) == 0) {
      if (mounted) {
        setState(() {
          this._point++;
          if (this._indexFlag < this._flagList.length - 1) {
            // increase the index to get new question and prepare the answers also
            this._indexFlag++;
            this._answerList = this._prepareAnswers(this._indexFlag);
            this._timeEachQuestion = 10;
          } else {
            _isAnswerButtonDisabled = true;
            this._buildSnackBarWithBuilder(
                context, 'Yay!, You did a great job! Please wait us a moment');
          }
        });
      }
    } else {
      if (mounted) {
        setState(() {
          if (this._indexFlag < this._flagList.length - 1) {
            // increase the index to get new question and prepare the answers also
            this._indexFlag++;
            this._answerList = this._prepareAnswers(this._indexFlag);
            this._timeEachQuestion = 10;
          } else {
            _isAnswerButtonDisabled = true;
            this._buildSnackBarWithBuilder(
                context, 'Yay!, You did a great job! Please wait us a moment');
          }
        });
      }
    }
  }

  void _isClick5050Button() {
    if (mounted) {
      setState(() {
        _is5050ButtonDisabled = true;
      });
    }
  }

  // this button is created by function
  Widget _build5050Button() {
    return RaisedButton(
      color: Colors.amberAccent,
      splashColor: Colors.deepPurpleAccent,
      child: Text(this._is5050ButtonDisabled ? "50/50" : "50/50"),
      onPressed: this._is5050ButtonDisabled ? null : this._isClick5050Button,
    );
  }

  // this button is created by function
  Widget _buildAnswerButton(String answer) {
    return Builder(
      builder: (BuildContext context) {
        return RaisedButton(
          color: Colors.amberAccent,
          splashColor: Colors.deepPurpleAccent,
          child: Text(this._isAnswerButtonDisabled ? answer : answer),
          onPressed: this._isAnswerButtonDisabled
              ? null
              : () {
                  this._chooseAnswer(answer, context);
                },
        );
      },
    );
  }

  // why I have to use BuildContext to reach out SnackBar widget
  // because at this point, there is none the SnackBar context scope or the SnackBar context can not reach out the origin so
  // I have to use BuildContext to reach out the nearest Scaffold context
  void _buildSnackBarWithBuilder(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text('$message'),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    // initialize first question of the game
    this._initFlagList(this._level);
    this._answerList = this._prepareAnswers(this._indexFlag);
    this._nextQuestion();
    this._is5050ButtonDisabled = false;
    this._isAnswerButtonDisabled = false;
  }

  @override
  Widget build(BuildContext context) {
    print('buildState');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${this._level}'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 35.0),
                    height: 100,
                    alignment: Alignment.center,
                    child: Text(
                      '${this._timeEachQuestion}',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(), shape: BoxShape.circle),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(top: 45.0),
                    width: 150,
                    height: 150,
                    alignment: Alignment.center,
                    child: Image.asset(
                        '${this._flagList[this._indexFlag].getURL()}'),
                  ),
                )
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                this._build5050Button(),
                RaisedButton(
                  color: Colors.amberAccent,
                  splashColor: Colors.deepPurpleAccent,
                  child: Text('Point: ${this._point}'),
                  onPressed: null,
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 35.0, right: 35.0),
                        child: _buildAnswerButton(this._answerList[0]),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: _buildAnswerButton(this._answerList[1]),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: _buildAnswerButton(this._answerList[2]),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: _buildAnswerButton(this._answerList[3]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('disposeState: play');
  }
}
