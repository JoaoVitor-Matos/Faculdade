import 'package:exercice1/LoginPage.dart';
import 'package:exercice1/main.dart';
import 'package:flutter/material.dart';

class MainPageLogin extends StatefulWidget {
  const MainPageLogin({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageLoginState();
}

class _MainPageLoginState extends State<MainPageLogin> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Minha Conta'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: IndexedStack(
            index: _currentIndex, children: const [LoginHomePage(), CreateUserPage()]),
      ),
    );
  }
}