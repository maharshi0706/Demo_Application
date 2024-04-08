// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:weather_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyMainPage(),
    );
  }
}

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedPage) {
      case 0:
        page = MyHomePage();
      case 1:
        page = Placeholder();
      case 2:
        page = Placeholder();
      case 3:
        page = Placeholder();
      default:
        throw UnimplementedError('No widget for this $selectedPage index.');
    }
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              child: page,
            ),
          ),
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: "Liked",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded),
              label: "Community",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.turned_in_not_rounded),
              label: "Saved",
            ),
          ],
          currentIndex: selectedPage,
          onTap: (value) => {setState(() => selectedPage = value)},
        ),
      ),
    );
  }
}
