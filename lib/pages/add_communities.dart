import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

class AddCommunities extends StatefulWidget {
  const AddCommunities({Key? key}) : super(key: key);

  @override
  State<AddCommunities> createState() => _AddCommunitiesState();
}

class _AddCommunitiesState extends State<AddCommunities> {
  final database = FirebaseDatabase.instance.ref();

  //* Try to save to Realtime Database
  void saveToDatabase(String nodeID) async{
    try {
      await database.child('/communities/$nodeID')
            .set({'name' : commnameController.text, 
                  'description': commdescController.text});
                  //! Add users: {users who joined this community}
                  //: Add profile picture URL
      print("yes");
    } catch (e) {
      print(e); //! Show to user and cancel save
    }
  }

  //* Performs three parts: 
  //* Generating random ID for node, checking if ID is already used and finally
  //* Saving it to database.
  void intiateSave() {
      String nodeID = generateRandomString(8);
    do {
      nodeID = generateRandomString(8);
    } while (checkIfNodeExists('/communities/$nodeID'));

    saveToDatabase(nodeID);
  }

  //* Generate random ID from characters from $chars
  String generateRandomString(int len) {
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }
 
  //* Check if ID is already used
  bool checkIfNodeExists(String node) {
    bool nodeExists = false;

    database.child('/communities/$node').onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        nodeExists = true;
      }
    });

    return nodeExists;
  }

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
              
              //* Logo
              const SizedBox(height: 50),
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

              //* Name field
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: commnameController,
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
                  ),
                ),
              ),

              //* Description field
              //: Make this taller
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: commdescController,
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
                  ),
                ),
              ),

              //* Select image button
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                child: const Text('Select Image'),
              ),
              if (_imageFile != null) Image.file(_imageFile!),

              ElevatedButton(
                onPressed: intiateSave,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
