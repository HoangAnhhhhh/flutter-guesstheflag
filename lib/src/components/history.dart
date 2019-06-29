import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _History();
  }
}

class _History extends State<History> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> documentDataList = [];
  AnimationController _controller;
  Animation _scaleAnimation;
  @override
  void initState() {
    super.initState();
    this._controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    this._scaleAnimation = Tween(begin: 10.0, end: 1.0)
        .animate(CurvedAnimation(parent: this._controller, curve: Curves.fastOutSlowIn));
    this._controller.forward();
    SharedPreferences.getInstance().then((prefs) {
      String userID = prefs.getString('userID');
      Firestore.instance
          .collection('$userID-history')
          .where('userID', isEqualTo: userID)
          .getDocuments()
          .then((snapshot) {
        List<DocumentSnapshot> documents = snapshot.documents;
        if (documents.isEmpty) {
          this.documentDataList = [];
        } else {
          documents.forEach((data) {
            setState(() {
              documentDataList.add(data.data);
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: this._controller,
        builder: (BuildContext context, Widget child) {
          if (this.documentDataList.isEmpty) {
            return Container(
              child: ScaleTransition(
                scale: this._scaleAnimation,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.history),
                        title: Text('Score: unknown'),
                        subtitle: Text('Level: unknown'),
                        trailing: Text('unknown'),
                      );
                    }),
              ),
            );
          } else {
            return Container(
              child: ScaleTransition(
                  scale: this._scaleAnimation,
                  child: ListView.builder(
                      itemCount: this.documentDataList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.history),
                          title: Text(
                              'Score: ${this.documentDataList[index]['score']}'),
                          subtitle: Text(
                              'Level: ${this.documentDataList[index]['level']}'),
                          trailing: Text(
                              '${this.documentDataList[index]['dateCreated']}'),
                        );
                      })),
            );
          }
        });
  }
}
