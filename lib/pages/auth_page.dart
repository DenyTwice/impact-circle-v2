import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({ Key? key }) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageStage();
}

class _AuthenticationPageStage extends State<AuthenticationPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin 
    ? LoginPage(onClickedSignUp: toggle) 
    : RegisterPage(onClickedSignUp: toggle);

  void toggle() => setState(() {
    isLogin = !isLogin;
  });
}