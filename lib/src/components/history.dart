import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final List<DocumentSnapshot> userHistory;
  History({Key key, this.userHistory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (this.userHistory == null) {
      print('null');
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.history),
            title: Text('Score: unknown'),
            subtitle: Text('Level: unknown'),
            trailing: Text('unknown'),
          );
        }
      );
    } else {
      return ListView.builder(
        itemCount: this.userHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.history),
            title: Text('Score: ${this.userHistory[index].data['score']}'),
            subtitle: Text('Level: ${this.userHistory[index].data['level']}'),
            trailing: Text('${this.userHistory[index].data['dateCreated']}'),
          );
        }
      );
    }
  }
}
