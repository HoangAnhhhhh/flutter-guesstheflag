import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final items = List<String>.generate(25, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.history),
          title: Text('Score: 0'),
          subtitle: Text('Level: '),
          trailing: Text('12/09/2019'),
        );
      },
    );
  }
}
