import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'De una Soluciones',

      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),

      routes: {
        '/login': (context) => const LoginScreen(),
      },

      home: const LoginScreen(),
    );
  }
}