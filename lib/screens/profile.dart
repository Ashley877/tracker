//import 'dart:js';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tracker/constants/tokens/colors.dart';
import 'package:tracker/models/animals.dart';
import 'package:tracker/screens/authenticate/login.dart';
import 'package:tracker/screens/household_invite.dart';
import 'package:tracker/screens/notifications.dart';
import 'package:tracker/services/auth2.dart';
import 'home.dart';
import '../locator.dart';
import '../widgets/avatar.dart';
import '../widgets/custom_button.dart';
import 'package:path/path.dart';
import '../constants/tokens/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LivestockProfile extends StatelessWidget {
  final Livestock livestock;
  // TODO: Add a variable for Category (104)
  LivestockProfile({Key key, this.title, this.livestock}) : super(key: key);
  final String title;
  final AuthService _auth = AuthService();
  bool circular = false;
  File _image;
  final _globalkey = GlobalKey<FormState>();
  //final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    Future sourcePicker() async {}
    Future getImage() async {
      var image = await ImagePicker()
          .getImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
      _image = File(image.path);
      String fileName = basename(_image.path);
      FirebaseFirestore.instance.collection("Livestock").doc(livestock.id).set(
          {"profilePic": fileName},
          SetOptions(merge: true)).then((_) => print("success"));
      String _fileName = livestock.profilePic;
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(_fileName);
      firebaseStorageRef.putFile(_image);

      return Scaffold(
          appBar: AppBar(
              title: Text('Homestead Tracker'),
              leading: GestureDetector(
                child: Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()));
                },
              )),
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
                        builder: (BuildContext context) =>
                            NotificationsView()));
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
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 16,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Builder(
                        builder: (context) => Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                        radius: 100,
                                        backgroundColor: colorCustomOrange,
                                        child: ClipOval(
                                          child: SizedBox(
                                              width: 180.0,
                                              height: 180.0,
                                              child: (_image != null)
                                                  ? Image.file(_image,
                                                      fit: BoxFit.fill)
                                                  : Image.network(
                                                      "https://animalnames.org/wp-content/uploads/2020/10/Alpaca-Names.jpg",
                                                      fit: BoxFit.fill)),
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 60.0,
                                    ),
                                    child: IconButton(
                                      icon: Icon(FontAwesomeIcons.camera,
                                          size: 30.0),
                                      onPressed: () {
                                        getImage();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          livestock.name,
                          //translate
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: colorCustomOrange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ]),
              ),
            ]),
          )));
    }
  }
}
