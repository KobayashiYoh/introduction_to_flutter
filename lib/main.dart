import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // ThemeData
      home: const BottomNavigation(),
    ); // MaterialApp
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
  ]; // <Widget>[]

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          // ----- Page1 -----
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Page1',
          ), //BottomNavigationBarItem
          // ----- Page2 -----
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Page2',
          ), //BottomNavigationBarItem
          // ----- Page3 -----
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Page3',
          ), //BottomNavigationBarItem
          // ----- Page4 -----
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Page4',
          ), //BottomNavigationBarItem
        ],
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ), // BottomNavigation
    ); // Scaffold
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
