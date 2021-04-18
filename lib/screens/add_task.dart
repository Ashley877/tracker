import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_textfield.dart';
import '../constants/tokens/colors.dart';
import '../widgets/custom_button.dart';
import '../services/database.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;
  final TextEditingController _controllerTask = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  void _addTask() async {
    var title = _controllerTitle.text.capitalize();
    var isComplete = false;
    // var name = _controllerAnimal.text.capitalize();
    final snapshot = await FirebaseFirestore.instance.collection("tasks").get();
    var docID = FirebaseFirestore.instance.collection("Tasks").doc();
    if (snapshot.docs.length == 0) {
      FirebaseFirestore.instance.collection("Tasks").doc(docID.id).set({
        "title": title,
        "isComplete": false,
        "id": docID.id,
        "uid": currentUser.uid,
      });
    }
    _controllerTitle.text = "";
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
            "Add New Task",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: 24,
          ),
          CustomTextField(
              controller: _controllerTitle, labelText: 'Enter Task'),
          SizedBox(height: 12),
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
                    _addTask();
                  })
              //),
            ],
          ),
        ],
      ),
    );
  }
}
