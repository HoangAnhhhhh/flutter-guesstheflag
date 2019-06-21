import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    FacebookLogin facebookLogin = FacebookLogin();
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser socialUser;
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
              Text(
                'Guess The Flag',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          )),
          Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
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
                            try {
                              final GoogleSignInAccount googleUser =
                                  await _googleSignIn.signIn();
                              final GoogleSignInAuthentication googleAuth =
                                  await googleUser.authentication;
                              final AuthCredential credential =
                                  GoogleAuthProvider.getCredential(
                                      accessToken: googleAuth.accessToken,
                                      idToken: googleAuth.idToken);
                              socialUser =
                                  await _auth.signInWithCredential(credential);
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => Home(googleAccount: googleAccount)));
                              final prefs =
                                  await SharedPreferences.getInstance();
                              // set data
                              prefs.setString('userID', socialUser.uid);
                              prefs.setString('email', socialUser.email);
                              prefs.setString('name', socialUser.displayName);
                              Navigator.pushNamed(context, '/home',
                                  arguments: socialUser);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
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
                            final result = await facebookLogin
                                .logInWithReadPermissions(
                                    ['email', 'public_profile']);

                            switch (result.status) {
                              case FacebookLoginStatus.loggedIn:
                                final AuthCredential credential =
                                    FacebookAuthProvider.getCredential(
                                        accessToken: result.accessToken.token);
                                socialUser = await _auth
                                    .signInWithCredential(credential);
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('userID', socialUser.uid);
                                prefs.setString('email', socialUser.email);
                                prefs.setString('name', socialUser.displayName);
                                Navigator.pushNamed(context, '/home',
                                    arguments: socialUser);
                                break;
                              case FacebookLoginStatus.cancelledByUser:
                                break;
                              case FacebookLoginStatus.error:
                                print(result.errorMessage);
                                break;
                            }
                          },
                        ),
                      )
                    ],
                  )
                ],
              )),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'Copyright ©2019 | Hoang Anh Author',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          )
        ],
      ),
    );
  }
}
