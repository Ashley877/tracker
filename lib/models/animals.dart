import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Livestock {
  String uid;
  String name;
  String gender;
  String id;
  String father;
  String mother;
  String birthday;
  String profilePic;
  String kids;
  List<String> links;
  List<String> labels;
  bool isArchived;
  bool isRegistered;
  String healthNotes;
  String vet;
  String medication;
  String product;
  String breed;
  String nextVisit;
  String breedingNotes;
  String breedId;
  String breedName;
  Timestamp createdAt;
  Timestamp updatedAt;
  int amount;

  Livestock(
      {this.uid,
      this.name,
      this.gender,
      this.id,
      this.mother,
      this.father,
      this.birthday,
      this.profilePic,
      this.kids,
      this.isArchived,
      this.isRegistered,
      this.healthNotes,
      this.vet,
      this.medication,
      this.product,
      this.breed,
      this.nextVisit,
      this.breedingNotes,
      this.links,
      this.labels,
      this.breedId,
      this.breedName,
      this.createdAt,
      this.updatedAt,
      this.amount});

  factory Livestock.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Livestock(
        uid: data['uid'],
        breed: data['breed'],
        id: data['id'],
        name: data['name'],
        birthday: data['birthday'],
        father: data['father'],
        mother: data['mother'],
        profilePic: data['profilePic'],
        healthNotes: data['healthNotes'],
        nextVisit: data['nextVisit'],
        kids: data['kids'],
        isArchived: data['isArchived'] ?? false,
        isRegistered: data['isRegistered'] ?? false,
        vet: data['vet'],
        medication: data['medication'],
        breedingNotes: data['breedingNotes'],
        links: List.from(['links']),
        labels: List.from(['labels']),
        breedId: data['breedId'],
        breedName: data['breedName'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt'],
        gender: data['gender'],
        amount: data['amount']);
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
      'healthNotes': healthNotes,
      'vet': vet,
    };
  }
}
