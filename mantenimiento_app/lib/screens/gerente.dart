import 'package:flutter/material.dart';

class GerenteScreen extends StatelessWidget {
  const GerenteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerente"),
      ),
      body: const Center(
        child: Text(
          "Bienvenido Gerente",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}