import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:impact_circle/pages/profilepage.dart';
import 'package:impact_circle/pages/request.dart';


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
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                  _communities.add(Community(name: name, description: description));
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

  const AddGroupDialog({Key? key, required this.onAddCommunity}) : super(key: key);
 
  @override
  _AddGroupDialogState createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {
    final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
   @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Community Name",
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Community Description",
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.onAddCommunity(_nameController.text, _descriptionController.text);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 219, 79, 24)),
                ),
                child: const Center(child: Text("Add Community",style: TextStyle(color: Colors.white),)),
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
          title: Text('$email',),
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
                onPressed: () 
                  async {
    await FirebaseAuth.instance.signOut();
                },
              ),
            ),

          ],
        );
      },
    );} 