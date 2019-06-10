import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/level.dart';
import '../components/highscore.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseUser googleUser;
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[Level(), HighScore()];
  _HomeState();

  @override
  Widget build(BuildContext context) {
    googleUser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(
                '${googleUser.displayName}',
                textDirection: TextDirection.ltr,
              ),
              accountEmail: Text(
                '${googleUser.email}',
                textDirection: TextDirection.ltr,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage('${googleUser.photoUrl}'),
              )),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              setState(() {
                this._selectedIndex = 0;
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.score),
            title: Text('HighScore'),
            onTap: () {
              setState(() {
                this._selectedIndex = 1;
                Navigator.pop(context);
              });
            },
          ),
        ],
      )),
      // this._selectedIndex == 0 ? Level() : HighScore()
      body: this._screens[this._selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.score), title: Text('HighScore')),
        ],
        currentIndex: this._selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: (int index) {
          setState(() {
            this._selectedIndex = index;
          });
        },
      ),
    );
  }
}
