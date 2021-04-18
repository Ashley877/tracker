import 'package:tracker/constants/tokens/colors.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import '../../constants/dimensions.dart';
import 'login.dart';
import '../../constants/loading.dart';

class RegisterView extends StatefulWidget {
  final Function toggleView;
  RegisterView({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterView> {
  final AuthBase _firebaseAuth = Auth();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Tracker"),
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
                    ),
                    Container(
                        width: loginContentWidth,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'REGISTER ACCOUNT',
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
                          vertical: 20.0, horizontal: 50.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
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
                            SizedBox(height: 16.0),
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
                                    'Create Account',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      dynamic result = await _firebaseAuth
                                          .createUserWithEmailAndPassword(
                                              email, password);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginView()));
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error = 'Please supply a valid email';
                                        });
                                      }
                                    }
                                  }),
                            ),
                            SizedBox(height: 12.0),
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
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: <Widget>[
                            Text('Already have an account?'),
                            FlatButton(
                                textColor: colorCustomOrange,
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginView()));
                                })
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )),
                  ],
                ),
              ),
            ));
  }
}
