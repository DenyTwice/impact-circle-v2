import 'package:flutter/material.dart';
import './login.dart';
import 'register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthState();
}

class _AuthState extends State<AuthPage> {
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