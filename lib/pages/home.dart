import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:impact_circle/pages/add_communities.dart';
import 'package:impact_circle/pages/user_profile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Signed in as:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              user.email!,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              icon: const Icon(Icons.arrow_back, size: 32),
              label: const Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                // Navigate to user profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
              child: const Icon(
                Icons.person,
                size: 64,
              ),
            ),
            const SizedBox(height: 40),
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: 64,
              onPressed: () {
                Navigator.push(
                  context,   //to go to add page
                  MaterialPageRoute(builder: (context) => AddCommunities()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
