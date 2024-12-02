import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sondage/firebase_options.dart';
import 'package:sondage/screens/authentification_screen.dart';
import 'package:provider/provider.dart';
import 'package:sondage/vote_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VoteProvider(),
      child: MaterialApp(
        title: 'Sondage',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthentificationScreen(),
      ),
    );
  }
}
