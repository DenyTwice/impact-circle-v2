import 'package:flutter/material.dart';
import 'package:impact_circle/pages/auth.dart';
import 'pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {

  //* Initalize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const Main());
}

final navigatorKey = GlobalKey<NavigatorState>(); // ?

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    navigatorKey: navigatorKey,
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        
        //* If waiting for Firebase
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        //* If error with Firebase
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong try again!'));
        //* If Logged In
        } else if (snapshot.hasData) {
          return const Home();
        //* If Not Logged In
        } else {
          return const AuthPage();
        }

      }
    ),  
  );
}