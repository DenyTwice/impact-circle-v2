import 'package:flutter/material.dart';
import 'package:impact_circle/components/my_button.dart';
import 'package:impact_circle/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:impact_circle/main.dart';
import 'package:flutter/gestures.dart';
import 'package:impact_circle/pages/communities.dart';

class Login extends StatefulWidget {
  //* Toggle between Login and Sign Up
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

  // Sign in with Firebase
  Future signIn() async {
    // ...existing code for signing in...

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Communities()),
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
      //: Show error to user
    }

    //* Remove showDialog
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  //* Dispose controllers as well
  // ?
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bgc.png',
              ), // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),

          // backgroundColor: const Color(0xFFE8D5C7),
          child: Transform.translate(
            offset: const Offset(0, 30),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/logoo.png', // Replace with your logo image path
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 500,
                    height: 380,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 20,
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                            height: 30), // add some space to move the text down
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        //* Username Input Field
                        const SizedBox(height: 25),
                        MyTextField(
                          controller: emailController,
                          hintText: 'username',
                          obscureText: false,
                        ),
                        const SizedBox(height: 25),
                        MyTextField(
                          controller: passwordController,
                          hintText: 'password',
                          obscureText: true,
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
                                color: Colors.white, fontSize: 16),
                            text: 'New user?  ',
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignUp,
                                  text: 'Sign Up',
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black))
                            ],
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
