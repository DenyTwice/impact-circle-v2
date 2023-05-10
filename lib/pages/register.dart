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

  Future signUp() async {
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
                  "Impact Circle.",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  const Text(
                            "Create your account now to volunteer...",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400)),
                  SizedBox(
                    child: Image.asset(
                      'assets/images/register.png',
                    ),
                  ),

                  const Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                // Username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                   prefixIcon: const Icon(
                    Icons.person,
                     color: Color.fromARGB(255, 219, 79, 24)
                   )
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 219, 79, 24)
                  ),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock,
                     color: Color.fromARGB(255, 219, 79, 24)
                  ),
                ),
                   const SizedBox(height: 25),
                  // Sign in button
                  MyButton(
                    onTap: signUp,
                  ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    text: 'Already a User?  ',
                    children: [
                      TextSpan(
                        text: 'Sign Up',
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



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(111, 19, 110, 170),
//       body: SafeArea(
//           child: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo
//               Stack(
//                 alignment: Alignment.center,
//                 children: const [
//                   Icon(
//                     Icons.circle_outlined,
//                     size: 200,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     'IMPACT',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 26,
//                     ),
//                   ),
//                 ],
//               ),
              
//               const SizedBox(height: 20,),
//               const Text(
//                 'REGISTER',
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 255, 255, 255),
//                     fontSize: 32,
//                     fontWeight: FontWeight.w900),
//               ),
//               // Username
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: TextField(
//                     controller: usernameController,
//                     obscureText: false,
//                     textAlign: TextAlign.center,
//                     decoration: InputDecoration(
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: 'Username',
//                       fillColor: Colors.grey.shade200,
//                       filled: true,
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50.0),
//                         borderSide: const BorderSide(color: Colors.white),
//                       ),
//                     )),
//               ),
//               // Email
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: TextField(
//                     controller: emailController,
//                     textAlign: TextAlign.center,
//                     obscureText: false,
//                     decoration: InputDecoration(
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: 'Email',
//                       fillColor: Colors.grey.shade200,
//                       filled: true,
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                     )),
//               ),
//               // Password
//               const SizedBox(height: 25),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: TextField(
//                     controller: passwordController,
//                     textAlign: TextAlign.center,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       hintText: 'Password',
//                       fillColor: Colors.grey.shade200,
//                       filled: true,
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                     )),
//               ),
              // const SizedBox(height: 25),
              // SizedBox(
              //   height: 60,
              //   width: 300,
              //   child: ElevatedButton(
              //     onPressed: signUp,
              //     style: ButtonStyle(
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //         ),
              //       ),
              //       backgroundColor:
              //           MaterialStateProperty.all<Color>(Colors.grey.shade200),
              //     ),
              //     child: const Text(
              //       'Sign Up',
              //       style: TextStyle(color: Colors.black),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 25),
              // RichText(
              //     text: TextSpan(
              //         recognizer: TapGestureRecognizer(),
              //         style: const TextStyle(color: Colors.white, fontSize: 20),
              //         text: 'Already a User?  ',
              //         children: [
              //       TextSpan(
              //           text: 'Login',
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = widget.onClickedSignUp,
              //           style: TextStyle(
              //               decoration: TextDecoration.underline,
              //               color: Theme.of(context).colorScheme.secondary))
              //     ]))
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
}