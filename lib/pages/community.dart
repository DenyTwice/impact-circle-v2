
import 'package:flutter/material.dart';
import 'add.dart';
import 'profile.dart';

class MyCommunity extends StatefulWidget {
  const MyCommunity({Key? key}) : super(key: key);

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // Add your pages here
    const Home(),
     AddCommunities(),
     UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xFFE8D5C7),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color(0xFFE8D5C7),
        centerTitle: true,
        title: const Text(
          'COMMUNITY',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        
        ),
      ),
      
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE8D5C7),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    ));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      backgroundColor:  const Color(0xFFE8D5C7),
      
      body:Transform.translate(
        offset:const Offset(0,20),
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 500,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: Colors.white,
            )
          ),
          
        ),
      ),
     ) );
  }
}
