import 'package:flutter/material.dart';
import 'package:tracker/constants/dimensions.dart';
import 'package:tracker/constants/tokens/colors.dart';
import 'package:tracker/screens/home.dart';

class HouseholdView extends StatefulWidget {
  HouseholdView({Key key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<HouseholdView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tracker"),
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
                      'HOUSEHOLD',
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
                    width: loginContentWidth,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Invite Your Family To Join',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    )),
                Container(
                  height: 16.0,
                ),
                Container(
                  width: loginContentWidth,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Edit Household Name',
                    ),
                  ),
                ),
                Container(
                  width: loginContentWidth,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  width: loginContentWidth,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  width: loginContentWidth,
                  padding: EdgeInsets.fromLTRB(
                      3 * cellSize, 3 * cellSize, 3 * cellSize, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  width: loginContentWidth,
                  padding: EdgeInsets.fromLTRB(
                      3 * cellSize, 3 * cellSize, 3 * cellSize, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  height: 16.0,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                ),
                Container(
                    width: loginContentWidth,
                    height: 48,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: colorCustomOrange,
                      child: Text('Invite'),
                      onPressed: () {},
                    )),
                Container(
                    width: loginContentWidth,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                          textColor: colorCustomOrange,
                          child: Text(
                            'Remove Accesses',
                          ),
                          onPressed: () {},
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
