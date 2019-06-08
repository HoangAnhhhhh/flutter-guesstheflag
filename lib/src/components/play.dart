import 'package:flutter/material.dart';
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
  List<Flag> _flagList;
  int _indexFlag = 0;
  int _timeEachQuestion = 5;
  _PlayState(this._level);

  String _isEaseOrMedium() => this._level == 'Easy' ? 'Easy' : 'Medium';

  @override
  void initState() {
    super.initState();
    print('initState');
    if (this._isEaseOrMedium() == 'Easy') {
      this._flagList = EasyLevel.getFlags();
      Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          this._timeEachQuestion -= 1;
          if (this._timeEachQuestion == 0) {
            this._timeEachQuestion = 5;
            print('Next Question');
            if (_indexFlag < this._flagList.length - 1) {
              _indexFlag++;
            } else
              t.cancel();
          }
        });
      });
    } else if (this._isEaseOrMedium() == 'Medium') {
      this._flagList = MediumLevel.getFlags();
      Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          this._timeEachQuestion -= 1;
          if (this._timeEachQuestion == 0) {
            this._timeEachQuestion = 5;
            print('Next Question');
            if (_indexFlag < this._flagList.length - 1) {
              _indexFlag++;
            } else
              t.cancel();
          }
        });
      });
    }
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
                RaisedButton(
                  color: Colors.amberAccent,
                  splashColor: Colors.deepPurpleAccent,
                  child: Text('50/50'),
                  onPressed: () {},
                ),
                RaisedButton(
                  color: Colors.amberAccent,
                  splashColor: Colors.deepPurpleAccent,
                  child: Text('Pass'),
                  onPressed: () {},
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
                        child: RaisedButton(
                          color: Colors.amberAccent,
                          child: Text('Answer 1'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: RaisedButton(
                          color: Colors.amberAccent,
                          child: Text('Answer 2'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: RaisedButton(
                          color: Colors.amberAccent,
                          child: Text('Answer 3'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: RaisedButton(
                          color: Colors.amberAccent,
                          child: Text('Answer 4'),
                          onPressed: () {},
                        ),
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
    print('disposeState');
  }
}
