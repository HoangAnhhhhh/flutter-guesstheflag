import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/level.dart';
import '../components/history.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseUser socialUser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  List<Widget> _screens = <Widget>[Level(), History()];

  @override
  void initState() {
    super.initState();
    firebaseAuth.onAuthStateChanged.listen((FirebaseUser firebaseUser) {
      if (firebaseUser != null) {
        Firestore.instance
            .collection('history')
            .where('userID', isEqualTo: firebaseUser.uid)
            .getDocuments()
            .then((userHistory) {
          if (userHistory != null) {
            List<DocumentSnapshot> histories = userHistory.documents;
            print(histories[0].data);
            this._screens = <Widget>[Level(), History(userHistory: histories)];
          } else
            this._screens = <Widget>[Level(), History(userHistory: [])];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    socialUser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(
                '${socialUser?.displayName ?? "unknown"} ',
                textDirection: TextDirection.ltr,
              ),
              accountEmail: Text(
                '${socialUser?.email ?? "unknown"}',
                textDirection: TextDirection.ltr,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    '${socialUser?.photoUrl ?? "http://dkpp.go.id/wp-content/uploads/2018/10/2-2.jpg"}'),
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
          ListTile(
            leading: Icon(Icons.backspace),
            title: Text('Log out'),
            onTap: () {
              firebaseAuth
                  .signOut()
                  .then((_) => print('Log out'))
                  .whenComplete(() =>
                      Navigator.popUntil(context, ModalRoute.withName('/')))
                  .catchError((e) => print(e));
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
