import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  
  //* Adds listener method to initState()
  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  //* Checks onValue on path and sets displayText
  // ToDo Append names of every community to list to make it accessible for UI 
  void _activateListeners() {
    database.child('/communities/"comm_id"/').onValue.listen((event) {
      Map<String, dynamic> communityMap = // ?
          jsonDecode(event.snapshot.value.toString());
      setState(() {
        displayText = communityMap['name'];
      });
    });
  }

  String displayText = 'Data';
  final database = FirebaseDatabase.instance.ref(); //* Access to "root path" of database

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('View Communities'),
      ),
      
      // ToDo Show List
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Text(displayText),
            ],
          ),
        ),
      ),
    );
  }
}
