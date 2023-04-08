import 'package:flutter/material.dart';
import 'package:todo/widgets//home_screen.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'ذكرني',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
