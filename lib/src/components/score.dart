import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class Score extends StatelessWidget {
  final String level;
  final int score;
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
          // FirebaseAuth.instance.onAuthStateChanged
          //     .listen((FirebaseUser firebaseUser) {
          //   if (firebaseUser != null) {
          //     User userFromClass = User.fromJSON(firebaseUser);
          //     CollectionReference userScoreCollection =
          //         Firestore.instance.collection('user-score');

          //     userScoreCollection.getDocuments().then((snapshot) {
          //       snapshot.documents.forEach((user) {
          //         String emailAlreadyExist = user.data['email'];
          //         String newComerEmail = firebaseUser.email;
          //         if (emailAlreadyExist == newComerEmail) {
          //           userScoreCollection
          //               .document(user.documentID)
          //               .updateData({'score': this.score});
          //         } else
          //           userScoreCollection.add(userFromClass.userJSON(this.score));
          //       });
          //     }).whenComplete(() =>
          //         Navigator.popUntil(context, ModalRoute.withName('/home')));
          //   } else
          //     print('null user');
          // });
          Navigator.popUntil(context, ModalRoute.withName('/home'));
        },
      ),
    );
  }
}
