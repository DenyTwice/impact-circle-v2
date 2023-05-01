import 'package:flutter/material.dart';
import 'add_communities.dart';
import 'profile.dart';
import 'home.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  //* Navigation bar:
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const AddCommunities(),
    const UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE8D5C7),
        
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: const Color(0xFFE8D5C7),
          centerTitle: true,
          title: const Text(
            //: Change title according to page
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
      ),
    );
  }
}
