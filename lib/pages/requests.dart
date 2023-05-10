import 'package:flutter/material.dart';
import 'package:impact_circle/pages/community.dart';
import 'package:impact_circle/pages/profilepage.dart';

void main() => runApp(const Requests());

class Requests extends StatelessWidget {
  const Requests({super.key});

  static const String _title = 'name of community';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFB8B8),
      ),
      title: _title,
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCommunity(),
                    ),
                  );
                },
            ),
            title: const Text(_title),
            backgroundColor: Color(0xFFFFB8B8),
            actions: <Widget>[
    IconButton(
      icon: const Icon(Icons.account_circle),
      onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                    userName: "userName",
                    email: "email",
                  ),
                    ),
                  );
                },
    ),
  ],
            ),
           
        body:  MyStatelessWidget(),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddRequestDialog();
            },
          );
        },
        elevation: 0,
        backgroundColor: Color(0xFFFFB8B8),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  

  final List<String> cardsData = ['Card 1', 'Card 2', 'Card 3', 'Card 4'];

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          children: cardsData.map((data) {
            return Container(
              width: double.infinity,
              height: 200,
              child: Card(
                
                shape: RoundedRectangleBorder(
                
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(data),
                ),
              ),
            );
          }).toList(),
          
        ),
      ),
      
    );
  }
}

class AddRequestDialog extends StatefulWidget {
  const AddRequestDialog({Key? key}) : super(key: key);

  @override
  _AddRequestDialogState createState() => _AddRequestDialogState();
}

class _AddRequestDialogState extends State<AddRequestDialog> {
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
                child:  Text(
                  "Add a New Request",
                  style: TextStyle(
                      
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Request Name",
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Request Description",
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "No of volunteers required",
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
                child: const Center(child: Text("Add Request")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



