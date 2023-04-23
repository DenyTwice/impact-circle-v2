import 'package:flutter/material.dart';
import 'package:impact_circle/components/my_button.dart';
import 'package:impact_circle/components/my_textfield.dart';
import 'package:impact_circle/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(111, 19, 110, 170),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
          
                // logo
                Stack(
            alignment: Alignment.center,
            children: [
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
          )
          ,
          
                const SizedBox(height: 50),
          
                // welcome back, you've been missed!
                Text(
                  'Take part in making society better',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),
          
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // sign in button
                MyButton(
                  onTap: signUserIn,
                ),
          
                const SizedBox(height: 50),
          
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or',
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 50),
          
                // google  sign in buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: const [
                //     // google button
                //     SquareTile(imagePath: 'impact-circle/lib/images/google.png'),
          
                //     SizedBox(width: 25),
                //   ],
                // ),
          
                const SizedBox(height: 50),
          
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
