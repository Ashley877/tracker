import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker/models/todo.dart';
import 'package:tracker/widgets/custom_button.dart';
import '../constants/tokens/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class TodosPage extends StatefulWidget {
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;
  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final todos = Todos.fromFirestore(doc);
          return todos.isComplete
              ? _taskComplete(todos)
              : _taskUncomplete(todos);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
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
                .collection("Tasks")
                .where("uid", isEqualTo: currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              return Expanded(child: _buildList(snapshot.data));
            })
      ]),
    );
  }

  void _deleteTask(Todos todos) async {
    await FirebaseFirestore.instance
        .collection("Tasks")
        .doc(todos.id)
        .delete()
        .then((_) {
      print(" $todos.breed  Deleted");
    });
    {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$todos.breed Deleted")));
    }
  }

  Widget _taskUncomplete(Todos todos) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Confirm Task",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(
                          height: 24,
                        ),
                        Text(todos.title),
                        SizedBox(
                          height: 24,
                        ),
                        // Text("Time"),
                        // SizedBox(
                        //   height: 24,
                        // ),
                        CustomButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("Tasks")
                                .doc(todos.id)
                                .set({"isComplete": true},
                                    SetOptions(merge: true));
                            _taskComplete(todos);
                            Navigator.pop(context);
                            //todo:implement database request to complete
                          },
                          buttonText: "Complete",
                          color: colorCustomOrange,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ));
            });
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Delete Task",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(
                          height: 24,
                        ),
                        Text(todos.title),
                        SizedBox(
                          height: 24,
                        ),
                        CustomButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("Tasks")
                                .doc(todos.id)
                                .delete()
                                .then((_) => Navigator.pop(context));
                            //todo:implement database request to complete
                          },
                          buttonText: "Delete",
                          color: colorCustomOrange,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ));
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_unchecked,
              color: colorCustomOrange,
              size: 20,
            ),
            SizedBox(
              width: 28,
            ),
            Text(todos.title)
          ],
        ),
      ),
    );
  }

  Widget _taskComplete(Todos todos) {
    //return Container(
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        _deleteTask(todos);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_checked,
              color: colorCustomOrange,
              size: 20,
            ),
            SizedBox(
              width: 28,
            ),
            Text(todos.title)
          ],
        ),
      ),
    );
  }
}
