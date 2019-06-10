import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/home.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                              final GoogleSignIn _googleSignIn = GoogleSignIn();
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              final GoogleSignInAccount googleUser =
                                  await _googleSignIn.signIn();
                              final GoogleSignInAuthentication googleAuth =
                                  await googleUser.authentication;
                              final AuthCredential credential =
                                  GoogleAuthProvider.getCredential(
                                      accessToken: googleAuth.accessToken,
                                      idToken: googleAuth.idToken);
                              final FirebaseUser user =
                                  await _auth.signInWithCredential(credential);
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => Home(googleAccount: googleAccount)));
                              Navigator.pushNamed(context, '/home',
                                  arguments: user);
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
                          onPressed: () {},
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
