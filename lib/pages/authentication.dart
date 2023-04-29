import 'package:flutter/material.dart';
import './login.dart';
import 'signup.dart';

class Authentication extends StatefulWidget {
  const Authentication({ Key? key }) : super(key: key);

  @override
  State<Authentication> createState() => _AuthState();
}

class _AuthState extends State<Authentication> {
  bool isLogin = true;

  //* Show Login or Register depending on onClickedSignUp's value
  @override
  Widget build(BuildContext context) => isLogin 
    ? Login(onClickedSignUp: toggle) 
    : Register(onClickedSignUp: toggle);

  // Toggle function
  void toggle() => setState(() {
    isLogin = !isLogin;
  });
}