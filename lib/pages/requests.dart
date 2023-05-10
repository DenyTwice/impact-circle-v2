import 'package:flutter/material.dart';

void main() => runApp(const Requests());

class Requests extends StatelessWidget {
  const Requests({super.key});

  static const String _title = 'REQUESTS';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('1st request'),
              subtitle: Text('Description of the request'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('JOIN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}