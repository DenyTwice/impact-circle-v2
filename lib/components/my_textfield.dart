import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SizedBox(
        height: 45,
        child: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            
              enabledBorder: OutlineInputBorder(
                
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15.0),
                
                
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                 borderRadius: BorderRadius.circular(10.0),
                
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500])),
              
        ),
      ),
    );
  }
}
