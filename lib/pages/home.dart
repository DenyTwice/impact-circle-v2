import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      backgroundColor:  const Color(0xFFE8D5C7),
      body:Transform.translate(
        offset:const Offset(0,20),
      child:Padding(
        padding: const EdgeInsets.all(10.0),

        //* Card
        // ToDo Should probably define a class for a card so that we can dynamically add more
        child: Container(
          width: 500,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.white,
            )
          ),
          
        ),
      ),
     ) );
  }
}
