import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VoteProvider extends ChangeNotifier {
  int appleVotes = 0;
  int windowsVotes = 0;
  bool hasVoted = false;

  VoteProvider() {
    FirebaseFirestore.instance.collection("sondage").snapshots().listen((event) {
      appleVotes = event.docs.first.get("apple");
      windowsVotes = event.docs.first.get("windows");
      notifyListeners();
    });
  }

  Future vote(String selection) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collection = db.collection("sondage");
    QuerySnapshot snapshot = await collection.get();
    List<QueryDocumentSnapshot> list = snapshot.docs;
    DocumentSnapshot document = list.first;
    final id = document.id;

    if (selection == "windows") {
      int windowsVotes = document.get("windows");
      collection.doc(id).update({"windows": ++windowsVotes});
    } else if (selection == "apple") {
      int appleVotes = document.get("apple");
      collection.doc(id).update({"apple": ++appleVotes});
    }
    hasVoted = true;
    notifyListeners();
  }
}
