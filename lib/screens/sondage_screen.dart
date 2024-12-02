// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sondage/vote_provider.dart';

class SondageScreen extends StatelessWidget {
  SondageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(96),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("sondage").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var appleVotes = snapshot.data!.docs.first.get("apple");
                var windowsVotes = snapshot.data!.docs.first.get("windows");
                return Text(
                    "Apple - ${(appleVotes * 100 / (appleVotes + windowsVotes)).toStringAsFixed(1)}%    |     Windows - ${(windowsVotes * 100 / (appleVotes + windowsVotes)).toStringAsFixed(1)}%\nTotal votes: ${appleVotes + windowsVotes}");
              },
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<VoteProvider>(context, listen: false).vote("apple");
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
                Provider.of<VoteProvider>(context, listen: false).vote("windows");
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

  
}
