import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:impact_circle/main.dart';
import 'package:flutter/gestures.dart';

class Register extends StatefulWidget {
  // Toggle between Login and Sign Up
  final VoidCallback onClickedSignUp;

  const Register({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int _count = 0;

  final database = FirebaseDatabase.instance.ref();

  void incrementCount() {
    setState(() {
      _count++;
    });
  }

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signUp() async {
    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseException catch (e) {
      print(e);
      //! TODO_ Show error to user
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    writeToDatabase();
  }

  void writeToDatabase() async {

    final user = database.child('/user_$_count/');

    try {
      await user.set({
        'username': usernameController.text,
        'email': emailController.text,
        'avater_url': 'https://unsplash.com/photos/9Ozb6a3DTcI',
        'requests_done': 0,
        'communities': 'null'
      });
    } on Exception catch (e) {
      print(e); //! TODO_ Block sign up
    }

    incrementCount(); // TODO_ Change to last database entry += 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(111, 19, 110, 170),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Stack(
                  alignment: Alignment.center,
                  children: const [
                    Icon(
                      Icons.circle_outlined,
                      size: 200,
                      color: Colors.white,
                    ),
                    Text(
                      'IMPACT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),

                // Register Text
                const SizedBox(height: 20),
                const Text(
                  'REGISTER',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 32,
                      fontWeight: FontWeight.w900),
                ),

                // Username Input Field
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: usernameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Username',
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      )),
                ),

                // Email Input Field
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: emailController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Email',
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      )),
                ),

                // Password Input Field
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Password',
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      )),
                ),

                // Sign up button
                const SizedBox(height: 25),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade200),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                // Already a user? Login!
                const SizedBox(height: 25),
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    text: 'Already a User?  ',
                    children: [
                      TextSpan(
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                widget.onClickedSignUp, // Toggle to Login Page
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).colorScheme.secondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
