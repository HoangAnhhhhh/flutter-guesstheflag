import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/level.dart';
import '../components/highscore.dart';

class Home extends StatefulWidget {
  final GoogleSignInAccount googleAccount;
  Home({Key key, @required this.googleAccount}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomeState(this.googleAccount);
}

class _HomeState extends State<Home> {
  final GoogleSignInAccount _googleAccount;
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[
    Level(),
    HighScore()
  ];
  _HomeState(this._googleAccount);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(
                '${this._googleAccount.displayName}',
                textDirection: TextDirection.ltr,
              ),
              accountEmail: Text(
                '${this._googleAccount.email}',
                textDirection: TextDirection.ltr,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage('${this._googleAccount.photoUrl}'),
              )),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.score),
            title: Text('HighScore'),
            onTap: () {},
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
