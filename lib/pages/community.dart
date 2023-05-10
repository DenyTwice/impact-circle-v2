import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:impact_circle/pages/profilepage.dart';

class MyCommunity extends StatefulWidget {
  const MyCommunity({Key? key}) : super(key: key);

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 79, 24),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
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

      body: Align(
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
      ]
    ),
    
    height: 200,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(10),
      child: const ListTile(
      
        title:  Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Cleaning",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.left,),
        ),
        subtitle:  Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Tap to see all the cleaning events happening",textAlign: TextAlign.left,),
        ),
      ),
    ),
  ),
),

      
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey[700],
          ),
          const SizedBox(
            height: 15,
          ),
          // Text(
          //   userName,
          //   textAlign: TextAlign.center,
          //   style: const TextStyle(fontWeight: FontWeight.bold),
          // ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyCommunity()),
              );
            },
            selectedColor: const Color.fromARGB(255, 219, 79, 24),
            selected: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.group),
            title: const Text(
              "Community",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreenReplace(
                  context,
                  ProfilePage(
                    userName: "userName",
                    email: "email",
                  ));
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.group),
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
GestureDetector(
  onTap: () async {
    await FirebaseAuth.instance.signOut();
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => Login(onClickedSignUp: () {  },)),
    //   (route) => false,
    // );
  },
  child: const ListTile(
    contentPadding:
         EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    leading:  Icon(Icons.exit_to_app),
    title:  Text(
      "Logout",
      style: TextStyle(color: Colors.black),
    ),
  ),
)

        ],
      )),
      

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddGroupDialog();
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
      ),
    );
  }
    
  }

  groupList() {}

class AddGroupDialog extends StatefulWidget {
  const AddGroupDialog({Key? key}) : super(key: key);

  @override
  _AddGroupDialogState createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {
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
                child:  Text(
                  "Add a New Community",
                  style: TextStyle(
                      
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Community Name",
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Community Description",
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 219, 79, 24)),
                ),
                child: const Center(child: Text("Add Community")),
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
