import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:impact_circle/main.dart';
import 'package:flutter/gestures.dart';
import 'package:impact_circle/components/my_textfield.dart';
import '../components/my_button.dart';

class Register extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Register({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign up function
  Future signUp() async {

    // Show circular loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Try sign in
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseException catch (e) {
      print(e);
    }

    // Remove circular loading indicator
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Transform.translate(
            offset: const Offset(0, 30),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  
                  const Text(
                    "Impact Circle.",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const Text("Join us!",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)
                      ),
                  
                  SizedBox(
                    child: Image.asset(
                      'assets/images/register.png',
                    ),
                  ),

                  // Username textfield
                  MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.person,
                          color: Color.fromARGB(255, 219, 79, 24))),
                  
                  // Email textfield
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email,
                        color: Color.fromARGB(255, 219, 79, 24)),
                  ),

                  // Password textfield
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock,
                        color: Color.fromARGB(255, 219, 79, 24)),
                  ),
                  const SizedBox(height: 25),
                  
                  // Sign up button
                  MyButton(
                    onTap: signUp,
                  ),
                  const SizedBox(height: 20),
                  
                  // Text to swap to Login page
                  RichText(
                    text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: 'Log in here.',
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
