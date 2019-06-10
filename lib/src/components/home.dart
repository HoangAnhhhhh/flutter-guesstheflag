import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/level.dart';
import '../components/history.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseUser googleUser;
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[Level(), History()];
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
                '${googleUser?.displayName ?? "unknown"} ',
                textDirection: TextDirection.ltr,
              ),
              accountEmail: Text(
                '${googleUser?.email ?? "unknown"}',
                textDirection: TextDirection.ltr,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage('${googleUser?.photoUrl ?? "http://dkpp.go.id/wp-content/uploads/2018/10/2-2.jpg"}'),
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
            leading: Icon(Icons.history),
            title: Text('History'),
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
              icon: Icon(Icons.history), title: Text('History')),
        ],
        currentIndex: this._selectedIndex,
        selectedItemColor: Colors.amberAccent,
        onTap: (int index) {
          setState(() {
            this._selectedIndex = index;
          });
        },
      ),
    );
  }
}
