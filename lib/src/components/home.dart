import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/level.dart';
import '../components/history.dart';
import '../services/audioplayer.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  FirebaseUser socialUser;
  SharedPreferences prefs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  List<Widget> _screens = <Widget>[Level(), History()];
  AudioService homeAudio = AudioService();
  AudioService signinAudio = AudioService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    homeAudio
      ..loadAsset('home-music')
      ..play('home-music');
    homeAudio.getInstance().onPlayerStateChanged.listen((state) {
      print('home $state');
      if (state == AudioPlayerState.COMPLETED) {
        print('play home music again');
        homeAudio.play('home-music');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    homeAudio.stop();
    signinAudio
      ..loadAsset('signin-music')
      ..play('signin-music');
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

  AppLifecycleState appLifecycleState;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        setState(() {
          homeAudio.pause();
        });
        break;
      case AppLifecycleState.resumed:
        setState(() {
          homeAudio.play('home-music');
        });
        break;
      default:
        break;
    }
  }
}
