import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:online_shopping/pages/admin_panel.dart';
import 'package:online_shopping/pages/basket.dart';
import 'package:online_shopping/pages/home.dart';
import 'package:online_shopping/pages/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color background = const Color.fromRGBO(44, 60, 80, 1);
  int currentIndex = 0;
  List<Widget> pages = [const Home(), const Basket(), const Profile()];
  bool isSearch = false;
  TextEditingController loginController  =TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String login = "admin";
  String password = "1234";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: !isSearch
            ? const Text(
          "E-Commerce",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        )
            : const TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Show login dialog here
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Login"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Login',
                        ),
                        controller: loginController,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        loginController.clear();
                        passwordController.clear();
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        log("message");
                        log(loginController.text);
                        log(passwordController.text);

                        if (loginController.text == login &&
                            passwordController.text == password) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminPanel(),
                            ),
                          );
                        } else {
                          loginController.clear();
                          passwordController.clear();
                          // Show an error message or handle incorrect credentials
                          // For simplicity, just print a message
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.person, size: 30, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            icon: const Icon(Icons.search, color: Colors.white,),
          )
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          backgroundColor: background,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined), label: "Basket"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
