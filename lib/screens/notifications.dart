import 'package:flutter/material.dart';
import 'package:tracker/constants/tokens/colors.dart';
import 'package:tracker/screens/home.dart';
import 'package:tracker/screens/household_invite.dart';
import '../screens/authenticate/login.dart';
import '../services/auth.dart';

class NotificationsView extends StatefulWidget {
  NotificationsView({Key key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<NotificationsView> {
  final AuthBase _firebaseAuth = Auth();
  var _alerts = false;
  var _familychange = false;
  var _anychange = false;

  @override

//         body: Center(
//           child: new SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Container(
//                   height: 16.0,
//                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 ),
//                 Container(
//                     width: loginContentWidth,
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       'NOTIFICATIONS',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: colorCustomOrange,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 20),
//                     )),
//                 Container(
//                   height: 16.0,
//                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 ),
//                 Container(
//                   height: 16.0,
//                 ),
//                 MyStatefulWidget(),
//                 Container(
//                   width: loginContentWidth,
//                   height: 24.0,
//                   // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

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
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
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
                onTap: () {},
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
                title: Text('FAQ'),
                onTap: () {},
              ),
              ListTile(
                title: Text('RESOURCES'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('ARCHIVED'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('SIGN OUT'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginView()));
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
