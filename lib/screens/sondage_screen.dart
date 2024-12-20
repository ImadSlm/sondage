// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sondage/vote_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class SondageScreen extends StatelessWidget {
  SondageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(96),
        child: Column(
          children: [
            Consumer<VoteProvider>(
              builder: (context, voteProvider, child) {
                if (!voteProvider.hasVoted) {
                  return Text("Veuillez voter pour voir les résultats :");
                }
                var totalVotes = voteProvider.appleVotes + voteProvider.windowsVotes;
                var applePercentage = (voteProvider.appleVotes * 100 / totalVotes).toStringAsFixed(1);
                var windowsPercentage = (voteProvider.windowsVotes * 100 / totalVotes).toStringAsFixed(1);
                return Column(
                  children: [
                    Text(
                      "Apple - $applePercentage%    |     Windows - $windowsPercentage%\nTotal votes: $totalVotes",
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
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
