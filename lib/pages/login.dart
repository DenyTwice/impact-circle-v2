import 'package:flutter/material.dart';
import 'package:impact_circle/components/my_button.dart';
import 'package:impact_circle/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:impact_circle/main.dart';
import 'package:flutter/gestures.dart';
import 'package:impact_circle/pages/community.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const Login({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign in method
  Future signIn() async {
    // ...existing code for signing in...

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyCommunity()),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseException catch (e) {
      print(e);
    }

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
                    "Impact Cirlce.",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login now to become one among us..",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    child: Image.asset(
                      'assets/images/login.png',
                    ),
                  ),

                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Username textfield
                  MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      prefixIcon:const  Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 219, 79, 24)
                      )),

                  const SizedBox(height: 25),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock,
                        color: Color.fromARGB(255, 219, 79, 24)),
                  ),
                  const SizedBox(height: 25),
                  // Sign in button
                  MyButton(
                    onTap: signIn,
                  ),
                  const SizedBox(height: 20),
                  // or continue with
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: Color.fromARGB(255, 219, 79, 24),
                          fontSize: 16),
                      text: 'New user?  ',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          text: 'Sign Up',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
