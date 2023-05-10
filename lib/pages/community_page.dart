import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'package:impact_circle/pages/request.dart';

class Community {
  final String name;
  final String description;

  Community({required this.name, required this.description});
}

class Communities extends StatefulWidget {
  const Communities({Key? key}) : super(key: key);

  @override
  State<Communities> createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  List<Community> _communities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 219, 79, 24),
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
                              builder: (context) => Requests(),
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
                  intiateSave();
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

Future<void> _dialogBuilder(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser!;
  final email = user.email;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '$email',
        ),
        content: const Text('A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.'),
        actions: <Widget>[
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Logout'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      );
    },
  );
}
