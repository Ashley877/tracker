import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/models/animals.dart';
import 'package:tracker/screens/profile.dart';

class AnimalListPage extends StatefulWidget {
  @override
  _AnimalListPageState createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<AnimalListPage> {
  final TextEditingController _controllerType = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;

  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final livestock = Livestock.fromFirestore(doc);
          return _buildListItem(livestock);
        });
  }

  void _deleteBreed(Livestock livestock) async {
    await FirebaseFirestore.instance
        .collection("Livestock")
        .doc(livestock.id)
        .delete()
        //.update(Breed.fromSnapshot(snapshot))
        .then((_) {
      print(" $livestock.breed  Deleted");
    });
    {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$livestock.breed Deleted")));
    }
  }

  Widget _buildListItem(Livestock livestock) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        _deleteBreed(livestock);
      },
      background: Container(
        color: Colors.red,
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: ExpansionTile(
        title: Text(livestock.breed,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            // livestock.breed,
            // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        children: <Widget>[
          ListTile(
              title: Text(livestock.name, style: TextStyle(fontSize: 18)),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LivestockProfile(livestock: livestock),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          children: [],
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Livestock")
                .where("isArchived", isEqualTo: false)
                .where("uid", isEqualTo: currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return Expanded(child: _buildList(snapshot.data));
            })
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}
