import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Livestock {
  String uid;
  String name;
  String id;
  String breed;

  Livestock({
    this.uid,
    this.name,
    this.id,
    this.breed,
  });

  factory Livestock.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Livestock(
        uid: data['uid'],
        breed: data['breed'],
        id: data['id'],
        name: data['name']);
  }
  factory Livestock.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data();
    return Livestock();
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'breed': breed,
    };
  }
}
