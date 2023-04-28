import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:impact_circle/main.dart';
import 'package:image_picker/image_picker.dart';


class AddCommunities extends StatefulWidget {
  @override
  State<AddCommunities> createState() => _AddCommunitiesState();
}

class _AddCommunitiesState extends State<AddCommunities> {
  final commnameController = TextEditingController();
  final commdescController = TextEditingController();
  File? _imageFile;  


  Future<void> _pickImage(ImageSource source) async {
  final pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile != null) {
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }
}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D5C7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

                // Logo
                Stack(
                  alignment: Alignment.center,
                  children: const [
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
                ),
              // Name field
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                    controller: commnameController,
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      hintText: 'Community Name',
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    )),
              ),

              // Description field
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                    controller: commdescController,
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      hintText: 'Community description',
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                child: const Text('Select Image'),
              ),
              if (_imageFile != null)
                Image.file(_imageFile!),
            ],
          ),
        ),
      ),
    );
  }
}