import 'package:flutter/material.dart';
import 'package:online_shopping/pages/initial_page.dart';
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitialPage(),
    );
  }
}
