import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:tracker/models/house.dart';
import 'firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tracker/models/animals.dart';
import 'package:tracker/services/api_path.dart';

abstract class Database {
  Future<void> addLivestock(Livestock livestock);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  Future<void> addLivestock(Livestock livestock) => _setData(
        path: APIPath.livestock(uid, "uid"),
        data: livestock.toMap(),
      );

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = await FirebaseFirestore.instance.doc(path);
    print('$path:$data');
    await reference.set(data);

    @override
    Future<void> deleteLivestock(Livestock livestock) => _service.deleteData(
          path: APIPath.livestock(uid, livestock.id),
        );
  }
}

List<Livestock> _finalLivestockList = [];
livestockList() async {
  List listOfLivestock = await FirebaseFirestore.instance
      .collection("Livestock")
      .get()
      .then((val) => val.docs);
  for (int i = 0; i < listOfLivestock.length; i++) {
    FirebaseFirestore.instance
        .collection("Livestock")
        .doc(listOfLivestock[i].documentID.toString())
        .snapshots();
  }
}

createListofLivestock(QuerySnapshot snapshot) async {
  var docs = snapshot.docs;
  for (var Doc in docs) {
    _finalLivestockList.add(Livestock.fromSnapshot(Doc));
  }
}

deleteLivestock(Livestock livestock, Function animalDeleted) async {
  if (livestock.profilePic != null) {
    Reference storageReference =
        await FirebaseStorage.instance.refFromURL(livestock.profilePic);

    // print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await FirebaseFirestore.instance
      .collection('Animals')
      .doc(livestock.id)
      .delete();
  animalDeleted(livestock);
}

class DatabaseService {
  final String uid;
  final String currentUser;
  DatabaseService({this.uid, this.currentUser});
  CollectionReference livestockCollection =
      FirebaseFirestore.instance.collection("Livestock");

  List<House> _houseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return House(
        household: doc.data()['household'] ?? '',
        name: doc.data()['name'] ?? '',
        members: doc.data()['members'] ?? '',
      );
    }).toList();
  }

  Stream<List<House>> get house {
    return livestockCollection.snapshots().map(_houseListFromSnapshot);
  }

  Future createNewLivestock(String name) async {
    return await livestockCollection.add({
      "name": name,
      // "isComplet": false,
    });
  }

  Future removeLivestock(uid) async {
    await livestockCollection.doc(uid).delete();
  }

  List<Livestock> animalFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Livestock(
          //isComplet: e.data()["isComplet"],
          name: e.data()["name"],
          id: e.id,
        );
      }).toList();
    } else {
      return null;
    }
  }

  static List<Livestock> finalAnimalList = [];

  Future completLivestock(uid) async {
    await livestockCollection.doc(uid).update({"isComplete": true});
  }

  List<Livestock> breedFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Livestock(
          name: e.data()["name"],
          id: e.id,
        );
      }).toList();
    } else {
      return null;
    }
  }
}
