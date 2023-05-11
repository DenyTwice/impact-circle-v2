import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:impact_circle/pages/request.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

class Community {
  final String name;
  final String description;

  Community({required this.name, required this.description});
}

class MyCommunity extends StatefulWidget {
  const MyCommunity({Key? key}) : super(key: key);

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity> {
  List<Community> _communities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 219, 79, 24),
          // User profile
          actions: [
            IconButton(
                onPressed: () => _dialogBuilder(context),
                icon: const Icon(
                  Icons.account_circle,
                ))
          ],

          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Community",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
          ),
        ),
        body: ListView.builder(
          itemCount: _communities.length,
          itemBuilder: (context, index) {
            final community = _communities[index];
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ]),
                height: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        community.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        community.description,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    trailing: SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyRequests(),
                            ),
                          );
                        },
                        child: const Text("View Requests"),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddGroupDialog(onAddCommunity: (name, description) {
                  setState(() {
                    _communities
                        .add(Community(name: name, description: description));
                  });
                });
              },
            );
          },
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 219, 79, 24),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ));
  }
}

class AddGroupDialog extends StatefulWidget {
  final Function(String, String) onAddCommunity;

  const AddGroupDialog({Key? key, required this.onAddCommunity})
      : super(key: key);

  @override
  _AddGroupDialogState createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {
  final database = FirebaseDatabase.instance.ref();

  // Try to save to Realtime Database
  void saveToDatabase(String nodeID) async {
    try {
      await database.child('/communities/$nodeID').set({
        'name': commNameController.text,
        'description': commDescController.text
      });
    } catch (e) {
      print(e); //! Show to user and cancel save
    }
  }

  // Performs three parts:
  // Generating random ID for node, checking if ID is already used and finally
  // Saving it to database.
  void intiateSave() {
    String nodeID = generateRandomString(8);
    do {
      nodeID = generateRandomString(8);
    } while (checkIfNodeExists('/communities/$nodeID'));

    saveToDatabase(nodeID);
  }

  // Generate random ID from characters from $chars
  String generateRandomString(int len) {
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  // Check if ID is already used
  bool checkIfNodeExists(String node) {
    bool nodeExists = false;

    database.child('/communities/$node').onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        nodeExists = true;
      }
    });

    return nodeExists;
  }

  final commNameController = TextEditingController();
  final commDescController = TextEditingController();

  @override
  void dispose() {
    commNameController.dispose();
    commDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 300,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Add a New Community",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: commNameController,
                decoration: const InputDecoration(
                  labelText: "Community Name",
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: commDescController,
                decoration: const InputDecoration(
                  labelText: "Community Description",
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.onAddCommunity(
                      commNameController.text, commDescController.text);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 219, 79, 24)),
                ),
                child: const Center(
                    child: Text(
                  "Add Community",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

String? getUsernameFromString(String userDataString) {
  RegExp regExp = RegExp(r'username:\s*(\S.*?)\s*(?=}})');
  Match? match = regExp.firstMatch(userDataString);
  if (match != null) {
    var username = match.group(1);
    return username;
  } else {
    print('No username found in string');
    return null;
  }
}

final databaseReference = FirebaseDatabase.instance.ref('users');

void searchDatabase(String? valueToSearch) {
  databaseReference
      .orderByChild('email')
      .equalTo(valueToSearch)
      .onValue
      .listen((event) {
    if (event.snapshot.value != null) {
      print('Found value in database!');
      getUsernameFromString(event.snapshot.value.toString());
    } else {
      print('Value not found in database.');
    }
  });
}

Future<void> _dialogBuilder(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser!;
  final email = user.email;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$email',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: const Text(
          'You will be logged out of your account when you click the "Logout" button.',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
