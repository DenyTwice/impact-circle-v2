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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          
          body:Container(
          
                    decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgc.png',), // Replace with your background image path
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
              const SizedBox(height: 20,),
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

                const SizedBox(height: 25),

                // Username textfield
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
                style: const TextStyle(color: Colors.white, fontSize: 16),
                text: 'New user?  ',
                children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                  text: 'Sign Up',
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black)
        )]))
      ],
    ),
          ),
        ]),
      ),
  ))));

//         child: Scaffold(
//            backgroundColor:const Color(0xFFE8D5C7),
//       body: Padding(
//         padding: const EdgeInsets.only(top:330),
// child: SingleChildScrollView(
//   physics:const NeverScrollableScrollPhysics(),
//         child: Container(
//           decoration: const BoxDecoration(
      // image: DecorationImage(
      //   image: AssetImage("assets/images/bg.jpeg"),
      //   fit: BoxFit.cover,
      //    alignment: Alignment.topCenter,
      // ),
  

    // child: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     const SizedBox(height: 50),

    //     // Logo

    //     const SizedBox(height: 50),

    //     // Welcome back, you've been missed!

    //     const SizedBox(height: 10),

    // Password textfield

    //     const SizedBox(height: 10),

    //     // Forgot password?
    //     // Ivin: Lmao I did not think about this
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 25.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: const [
    //           Text(
    //             'Forgot Password?',
    //             style:
    //                 TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
    //           ),
    //         ],
    //       ),
    //     ),

        // const SizedBox(height: 25),

        // // Sign in button
        // MyButton(
        //   onTap: signIn,
        // ),

    //     const SizedBox(height: 50),

    //     // or continue with
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 25.0),
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: Divider(
    //               thickness: 0.5,
    //               color: Colors.grey[400],
    //             ),
    //           ),
    //           const Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 10.0),
    //             child: Text(
    //               'Or',
    //               style: TextStyle(
    //                   color: Color.fromARGB(255, 255, 255, 255)),
    //             ),
    //           ),
    //           Expanded(
    //             child: Divider(
    //               thickness: 0.5,
    //               color: Colors.grey[400],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),

    //     const SizedBox(height: 24),
    //     RichText(
    //         text: TextSpan(
    //             style: const TextStyle(color: Colors.white, fontSize: 20),
    //             text: 'New user?  ',
    //             children: [
    //           TextSpan(
    //               recognizer: TapGestureRecognizer()
    //                 ..onTap = widget.onClickedSignUp,
    //               text: 'Sign Up',
    //               style: TextStyle(
    //                   decoration: TextDecoration.underline,
    //                   color: Theme.of(context).colorScheme.secondary))
    //         ]))
    //   ],
    // ),
    //       ),
    //     ),
    //   ),
    // ));
  }
}
