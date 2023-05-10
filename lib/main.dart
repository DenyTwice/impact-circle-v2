import 'package:flutter/material.dart';
import 'package:impact_circle/pages/auth_page.dart';
import 'package:impact_circle/pages/community_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const Main());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(useMaterial3: true),
    navigatorKey: navigatorKey,
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong try again!'));
        } else if (snapshot.hasData) {
          return const Communities();
        } else {
          return const AuthenticationPage();
        }

      }
    ),  
  );
}