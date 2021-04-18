import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tracker/constants/tokens/colors.dart';
import 'package:tracker/screens/authenticate/register.dart';
import 'package:tracker/screens/home.dart';
import '../../services/auth.dart';
import '../../constants/loading.dart';
import '../../services/auth.dart';
import '../../constants/dimensions.dart';

class LoginView extends StatefulWidget {
  final Function toggleView;
  LoginView({this.toggleView});

  @override
  _State createState() => _State();
}

class _State extends State<LoginView> {
  // text field state
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthBase _firebaseAuth = Auth();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  User user;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Homestead Tracker"),
            ),
            body: Center(
              child: new SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 16.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage('assets/images/house.png'),
                      ),
                    ),
                    Container(
                        width: loginContentWidth,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Maximize your productivity\n on your homestead\n by joining now',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colorCustomOrange,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                    Container(
                      height: 16.0,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 50.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            Container(
                              width: loginContentWidth,
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email'),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                              width: loginContentWidth,
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                obscureText: true,
                                validator: (val) => val.length < 6
                                    ? 'Enter a password 6+ chars long'
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password'),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              width: loginContentWidth,
                              height: 48,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: RaisedButton(
                                  color: colorCustomOrange,
                                  textColor: Colors.white,
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(fontSize: 20),
                                    // style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      dynamic result = await _firebaseAuth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        // loading = false;
                                        // print(error);
                                        setState(() {
                                          loading = false;
                                          error =
                                              'Could not sign in with those credentials';
                                        });
                                      } else {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        HomePage()));
                                      }
                                    }
                                  }),
                            ),
                            SizedBox(height: 6.0),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: loginContentWidth,
                        height: 48,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                            color: colorCustomOrange,
                            textColor: Colors.white,
                            child: Text(
                              'Sign In With Facebook',
                              style: TextStyle(fontSize: 20),
                              // style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              FacebookLogin();
                            })),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    InkWell(
                      child: Container(
                          margin: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/google.jpg'),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ))),
                      onTap: () async {
                        _firebaseAuth.signInWithGoogle().then((User user) {
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage());
                        }).catchError((e) => print(e));
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: FlatButton(
                        onPressed: () {},
                        textColor: colorCustomOrange,
                        child: Text('Forgot Password'),
                      ),
                    ),
                    Container(
                        width: loginContentWidth,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: <Widget>[
                            Text('Does not have account?'),
                            FlatButton(
                              textColor: colorCustomOrange,
                              child: Text(
                                'Sign up',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RegisterView()));
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )),
                    Container(
                      width: loginContentWidth,
                      height: 24.0,
                    ),
                  ],
                ),
              ),
            ));
  }
}
