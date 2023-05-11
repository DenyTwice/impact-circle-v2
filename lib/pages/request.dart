import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Requests {
  final String name;
  final String description;

  Requests({required this.name, required this.description});
}

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  List<Requests> _requests = [];

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
            "Community Name",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: _requests.length,
            itemBuilder: (context, index) {
              final community = _requests[index];
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
                            //volunteer for that request
                          },
                          child: const Text("Volunteer"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 219, 79, 24)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddRequestDialog(onAddRequests: (name, description) {
                  setState(() {
                    _requests
                        .add(Requests(name: name, description: description));
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

class AddRequestDialog extends StatefulWidget {
  final Function(String, String) onAddRequests;

  const AddRequestDialog({Key? key, required this.onAddRequests})
      : super(key: key);

  @override
  _AddRequestDialogState createState() => _AddRequestDialogState();
}

class _AddRequestDialogState extends State<AddRequestDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _volunteerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 400,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Add a New Request",
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
                  labelText: "Request Name",
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Request Description",
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _volunteerController,
                decoration: const InputDecoration(
                  labelText: "No of volunteers required",
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.onAddRequests(
                      _nameController.text, _descriptionController.text);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 219, 79, 24)),
                ),
                child: const Center(child: Text("Add Request")),
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
  title:  Padding(
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      icon: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
      label:const  Text(
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
