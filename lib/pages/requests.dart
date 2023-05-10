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
           
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        elevation: 50,
        shadowColor: Color.fromARGB(255, 248, 161, 180),
        child: SizedBox(
          height: 100,
          child: Center(child: Text('Elevated Card')),
        ),
      ),
    );
  }
}
