//zeta Soft Training App
import 'package:flutter/material.dart';
import 'package:sqlitedemo/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Login()
    );
  }
}