import 'package:flutter/material.dart';
import 'package:tracker/constants/tokens/colors.dart';
import 'package:tracker/screens/home.dart';
import 'package:tracker/screens/household_invite.dart';
import 'package:tracker/screens/profile.dart';
import '../screens/authenticate/login.dart';
import '../services/auth.dart';

class NotificationsView extends StatefulWidget {
  NotificationsView({Key key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<NotificationsView> {
  final AuthBase _firebaseAuth = Auth();
  final AuthBase _auth = Auth();

  var _alerts = false;
  var _familychange = false;
  var _anychange = false;

  @override

//
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NOTIFICATIONS"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Settings'),
                decoration: BoxDecoration(
                  color: colorCustomOrange,
                ),
              ),
              ListTile(
                title: Text('ACCOUNT'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Profile()));
                },
              ),
              ListTile(
                  title: Text('HOUSEHOLD'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HouseholdView()));
                  }),
              ListTile(
                title: Text('NOTIFICATIONS'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => NotificationsView()));
                },
              ),
              ListTile(
                title: Text('SIGN OUT'),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: 16.0,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
            SwitchListTile(
              value: _alerts,
              onChanged: (alerts) {
                setState(() {
                  _alerts = alerts;
                });
              },
              subtitle: Text(
                  'Anytime a task or event comes up you will be alerted with a pop up box'),
            ),
            Container(
              height: 16.0,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
            SwitchListTile(
              value: _familychange,
              onChanged: (familychange) {
                setState(() {
                  _familychange = familychange;
                });
              },
              title: Text(
                'Household change',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                  'When someone in your household is added or removed you will be alrted'),
            ),
            Container(
              height: 16.0,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
            SwitchListTile(
              value: _anychange,
              onChanged: (anychange) {
                setState(() {
                  _anychange = anychange;
                });
              },
              title: Text(
                'Changed by household',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                  'When anyone in your household completes a task or updates the app you will be alerted'),
            )
          ],
        ));
  }
}
