import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/animals.dart';
import '../widgets/custom_textfield.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class AddAnimalsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;

  final TextEditingController _controllerType = TextEditingController();
  final TextEditingController _controllerAnimal = TextEditingController();

  void _addAnimal() async {
    var uid = currentUser.uid;
    var type = _controllerType.text.capitalize();
    var name = _controllerAnimal.text.capitalize();
    var docID = FirebaseFirestore.instance.collection("Livestock").doc();
    docID.set({
      "name": name,
      "breed": type,
      "gender": "",
      "father": "",
      "mother": "",
      "birthday": "",
      "profilePic": "",
      "kids": "",
      "isArchived": false,
      "isRegistered": false,
      "healthNotes": "",
      "vet": "",
      "medication": "",
      "product": "",
      "nextVisit": "",
      "breedingNotes": "",
      "id": docID.id,
      "uid": uid,
    }).then((_) => print("success"));
    _controllerAnimal.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: Text(
            "Add New Livestock",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          CustomTextField(
              controller: _controllerType, labelText: 'Animal Breed'),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
              controller: _controllerAnimal, labelText: 'Animal Name'),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            children: [
              ElevatedButton(
                  child: Text("Close"),
                  onPressed: () => Navigator.of(context).pop()),
              SizedBox(
                width: 16,
              ),
              ElevatedButton(
                  child: Text("Save"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //_addBreed();
                    _addAnimal();
                  })
            ],
          ),
        ],
      ),
    );
  }
}
