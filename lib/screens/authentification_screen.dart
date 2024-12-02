import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:sondage/screens/sondage_screen.dart';

class AuthentificationScreen extends StatelessWidget {
  const AuthentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Text("Bienvenue");
            },
            footerBuilder: (context, builder) {
              return Column(
                children: [
                  Text("En vous connectant vous acceptez nos conditions d'utilisation"),
                  ElevatedButton(onPressed: () {}, child: Text("OK")),
                ],
              );
            },
          );
        }
        return SondageScreen();
      },
    );
  }
}
