// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SondageScreen extends StatelessWidget {
  SondageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(96),
        child: Column(
          children: [
            StreamBuilder<Object>(
              stream: FirebaseFirestore.instance.collection("sondage").snapshots(),
              builder: (context, snapshot) {
                return Text("Votes : Apple - ${showVotes("apple").toString()}, Windows - ${showVotes("windows")}");
              }
            ),
            ElevatedButton(
              onPressed: () {
                vote("apple");
              },
              child: Row(
                children: [
                  Icon(Icons.apple),
                  Text("Apple"),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                vote("windows");
              },
              child: Row(
                children: [
                  Icon(Icons.window),
                  Text("Windows"),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text("Déconnexion")),
          ],
        ),
      ),
    );
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
  }

  Future showVotes(String selection) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collection = db.collection("sondage");
    QuerySnapshot snapshot = await collection.get();
    List<QueryDocumentSnapshot> list = snapshot.docs;
    DocumentSnapshot document = list.first;
    final id = document.id;
    if (selection == "windows") {
      int windowsVotes = document.get("windows");
      return windowsVotes;
    } else if (selection == "apple") {
      int appleVotes = document.get("apple");
      return appleVotes;
    }
  }
}
