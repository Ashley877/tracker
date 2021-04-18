import 'package:cloud_firestore/cloud_firestore.dart';
// class Todo {
//   Todo({this.title, this.isDone = false});

//   String title;
//   bool isDone;
// }

///////////////////////////////////////////////////

class Todos {
  String uid;
  String id;
  String title;
  bool isComplete;

  Todos({this.uid, this.id, this.title, this.isComplete});

  factory Todos.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Todos(
      uid: data['uid'],
      id: data['id'],
      title: data['title'],
      isComplete: data['isComplete'] ?? false,
    );
  }
  factory Todos.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data();
    return Todos();
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'title': title,
      'isComplete': isComplete,
    };
  }
}
