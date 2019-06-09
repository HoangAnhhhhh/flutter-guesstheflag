import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Score extends StatelessWidget {
  final String level;
  final int score;
  Score({Key key, @required this.level, @required this.score})
      : super(key: key);

  void googleAccount(){
    GoogleSignInAccount googleSignInAccount;
    print(googleSignInAccount.id);
  }

  
  
  @override
  Widget build(BuildContext context) {
    this.googleAccount();
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
        clipBehavior: Clip.antiAlias,
        onPressed: () {

        },
      ),
    );
  }
}
