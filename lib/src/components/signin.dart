import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../services/audioplayer.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _socialUser;
  AudioService _signinAudio = AudioService();

  // animation
  AnimationController _controller;
  Animation _googleAnimation, _facebookAnimation, _textAnimation;

  Animation<double> _buildDelayedAnimation(
      {AnimationController controller, double begin, double end}) {
    return CurvedAnimation(
        parent: controller,
        curve: Interval(begin, end, curve: Curves.fastOutSlowIn));
  }

  Future<bool> _checkConnect() async {
    dynamic isConnect;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect = true;
        return isConnect;
      }
    } on SocketException catch (_) {
      isConnect = false;
      return isConnect;
    }
    return isConnect;
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Connection Failed"),
          content: new Text(
              "We cannot detect a network connection on this device. Please check Network Settings to connect to an available network"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    this._controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    this._googleAnimation = Tween(begin: -1.0, end: 0.0).animate(this
        ._buildDelayedAnimation(
            controller: this._controller, begin: 0.5, end: 1.0));
    this._facebookAnimation = Tween(begin: -1.0, end: 0.0).animate(this
        ._buildDelayedAnimation(
            controller: this._controller, begin: 0.6, end: 1.0));
    this._textAnimation = Tween(begin: -1.0, end: 0.0).animate(this
        ._buildDelayedAnimation(
            controller: this._controller, begin: 0.7, end: 1.0));
    this._controller.forward();
    _signinAudio
      ..loadAsset('signin-music')
      ..play('signin-music');
    _signinAudio.getInstance().onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.COMPLETED) {
        print('play signin music again');
        _signinAudio.play('signin-music');
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _signinAudio.stop();
    this._controller.dispose();
  }

  AppLifecycleState appLifecycleState;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        setState(() {
          _signinAudio.pause();
        });
        break;
      case AppLifecycleState.resumed:
        setState(() {
          _signinAudio.play('signin-music');
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: this._controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 75.0,
                ),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/signin/logo.png',
                      width: 200.0,
                      height: 200.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('Guess The Flag',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                )),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 15.0, right: 15.0),
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              this._googleAnimation.value * width, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            child: RaisedButton(
                              color: Color(0xFFDF513B),
                              splashColor: Colors.deepPurple[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text('Login with Google',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                              onPressed: () async {
                                bool isConnect = await this._checkConnect();
                                if (isConnect) {
                                  try {
                                    final GoogleSignInAccount googleUser =
                                        await _googleSignIn.signIn();
                                    final GoogleSignInAuthentication
                                        googleAuth =
                                        await googleUser.authentication;
                                    final AuthCredential credential =
                                        GoogleAuthProvider.getCredential(
                                            accessToken: googleAuth.accessToken,
                                            idToken: googleAuth.idToken);
                                    _socialUser = await _auth
                                        .signInWithCredential(credential);
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => Home(googleAccount: googleAccount)));
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    // set data
                                    prefs.setString('userID', _socialUser.uid);
                                    prefs.setString('email', _socialUser.email);
                                    prefs.setString(
                                        'name', _socialUser.displayName);
                                    AudioService().stop();
                                    Navigator.pushNamed(context, '/home',
                                        arguments: _socialUser);
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  this._showDialog();
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              this._facebookAnimation.value * width, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            child: RaisedButton(
                              color: Color(0xFF3B5998),
                              splashColor: Colors.deepPurple[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text('Login with Facebook',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                              onPressed: () async {
                                bool isConnect = await this._checkConnect();
                                if (isConnect) {
                                  final result = await this
                                      ._facebookLogin
                                      .logInWithReadPermissions(
                                          ['email', 'public_profile']);

                                  switch (result.status) {
                                    case FacebookLoginStatus.loggedIn:
                                      final AuthCredential credential =
                                          FacebookAuthProvider.getCredential(
                                              accessToken:
                                                  result.accessToken.token);
                                      _socialUser = await _auth
                                          .signInWithCredential(credential);
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'userID', _socialUser.uid);
                                      prefs.setString(
                                          'email', _socialUser.email);
                                      prefs.setString(
                                          'name', _socialUser.displayName);
                                      AudioService().stop();
                                      Navigator.pushNamed(context, '/home',
                                          arguments: _socialUser);
                                      break;
                                    case FacebookLoginStatus.cancelledByUser:
                                      break;
                                    case FacebookLoginStatus.error:
                                      print(result.errorMessage);
                                      break;
                                  }
                                } else {
                                  this._showDialog();
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ))),
                SizedBox(
                  height: 20.0,
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      this._textAnimation.value * width, 0, 0),
                  child: Center(
                    child: Text(
                      'Copyright ©2019 | Hoang Anh Author',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
