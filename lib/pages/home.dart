import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
            

          ],

        ),
      ),
    );
  }
}
