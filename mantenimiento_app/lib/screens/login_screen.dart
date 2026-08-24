import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'registro_screen.dart';
import '../models/usuario.dart';

import 'home_cliente.dart';
import 'home_tecnico.dart';
import 'admin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController correoController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool cargando = false;

  Future<void> iniciarSesion() async {

    final correo = correoController.text.trim();
    final password = passwordController.text.trim();

    // ==========================================
    // VALIDAR CAMPOS
    // ==========================================

    if (correo.isEmpty || password.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Completa todos los campos"),
        ),
      );

      return;
    }

    setState(() {
      cargando = true;
    });

    try {

      // ==========================================
      // ENVIAR LOGIN AL BACKEND
      // ==========================================

      final response = await http.post(
        Uri.parse(
          "http://10.0.2.2:8080/api/login",
        ),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "correoUsu": correo,
          "contUsu": password,
        }),
      );

      // ==========================================
      // LOGIN CORRECTO
      // ==========================================

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        // Convertimos la respuesta en Usuario
        final usuario = Usuario.fromJson(data);

        // Obtenemos el nombre del perfil
        final perfil = usuario.nombrePerfil;

        if (!mounted) return;

        // ==========================================
        // CLIENTE
        // ==========================================

        if (perfil == "Cliente") {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomeClienteScreen(
                usuario: usuario,
              ),
            ),
          );

        }

        // ==========================================
        // TÉCNICO
        // ==========================================

        else if (perfil == "Tecnico") {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomeTecnicoScreen(
                usuario: usuario,
              ),
            ),
          );

        }

        // ==========================================
        // ADMINISTRADOR
        // ==========================================

        else if (perfil == "Administrador") {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminScreen(),
            ),
          );
        }

        // ==========================================
        // ADMINISTRADOR / GERENTE
        // ==========================================

        else {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Perfil $perfil todavía no tiene una vista configurada",
              ),
            ),
          );

        }

      }

      // ==========================================
      // LOGIN INCORRECTO
      // ==========================================

      else {

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Correo o contraseña incorrectos",
            ),
          ),
        );

      }

    }

    // ==========================================
    // ERROR DE CONEXIÓN
    // ==========================================

    catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error de conexión: $e",
          ),
        ),
      );

    }

    // ==========================================
    // TERMINÓ LA CARGA
    // ==========================================

    finally {

      if (mounted) {

        setState(() {
          cargando = false;
        });

      }

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [
              Color.fromARGB(255, 95, 124, 255),
              Color.fromARGB(255, 153, 244, 248),
              Color(0xFFFFF5FA),
            ],

          ),

        ),

        child: Center(

          child: SingleChildScrollView(

            child: Padding(

              padding: const EdgeInsets.all(30),

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  // ==========================================
                  // ICONO
                  // ==========================================

                  const Icon(
                    Icons.home_repair_service,
                    size: 100,
                    color: Color.fromARGB(
                      255,
                      1,
                      3,
                      90,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==========================================
                  // TITULO
                  // ==========================================

                  const Text(
                    'De Una soluciones',

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Gestión de Servicios',

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ==========================================
                  // CORREO
                  // ==========================================

                  TextField(

                    controller: correoController,

                    keyboardType:
                        TextInputType.emailAddress,

                    decoration: const InputDecoration(

                      labelText: 'Correo',

                      border:
                          OutlineInputBorder(),

                      prefixIcon:
                          Icon(Icons.email),

                    ),

                  ),

                  const SizedBox(height: 20),

                  // ==========================================
                  // CONTRASEÑA
                  // ==========================================

                  TextField(

                    controller:
                        passwordController,

                    obscureText: true,

                    decoration: const InputDecoration(

                      labelText: 'Contraseña',

                      border:
                          OutlineInputBorder(),

                      prefixIcon:
                          Icon(Icons.lock),

                    ),

                  ),

                  const SizedBox(height: 30),

                  // ==========================================
                  // BOTÓN INGRESAR
                  // ==========================================

                  SizedBox(

                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(

                      onPressed:
                          cargando
                              ? null
                              : iniciarSesion,

                      child:

                          cargando

                              ? const SizedBox(

                                  width: 25,
                                  height: 25,

                                  child:
                                      CircularProgressIndicator(),

                                )

                              : const Text(

                                  'Ingresar',

                                  style:
                                      TextStyle(
                                    fontSize: 18,
                                  ),

                                ),

                    ),

                  ),

                  const SizedBox(height: 15),

                  // ==========================================
                  // REGISTRO
                  // ==========================================

                  TextButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const RegistroScreen(),

                        ),

                      );

                    },

                    child: const Text(
                      "¿No tienes una cuenta? Registrarse",
                    ),

                  ),

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }
}