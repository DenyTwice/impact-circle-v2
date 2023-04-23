import 'package:flutter/material.dart';
import './login.dart';
import './register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthState();
}

class _AuthState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin 
    ? Login(onClickedSignUp: toggle) 
    : Register(onClickedSignUp: toggle);

  void toggle() => setState(() {
    isLogin = !isLogin;
  });
}