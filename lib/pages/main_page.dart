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
  int currentIndex= 0;
  List <Widget> pages =[const Home(), const Basket(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: const Text(
          "E-Commerce",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const AdminPanel()));
          },
          icon: const Icon(Icons.person, size: 30, color: Colors.white),
        )
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){setState(() { currentIndex = value; });},
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
          backgroundColor: background,
          items:  const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), label: "Basket"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ]),
    );
  }
}
