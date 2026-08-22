import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {

  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final correoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmarPasswordController = TextEditingController();

  bool cargando = false;

  Future<void> registrarUsuario() async {

    final nombre = nombreController.text.trim();
    final apellido = apellidoController.text.trim();
    final correo = correoController.text.trim();
    final password = passwordController.text.trim();
    final confirmarPassword =
        confirmarPasswordController.text.trim();

    // Validar campos
    if (nombre.isEmpty ||
        apellido.isEmpty ||
        correo.isEmpty ||
        password.isEmpty ||
        confirmarPassword.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Completa todos los campos",
          ),
        ),
      );

      return;
    }

    // Validar contraseñas
    if (password != confirmarPassword) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Las contraseñas no coinciden",
          ),
        ),
      );

      return;
    }

    setState(() {
      cargando = true;
    });

    try {

      final response = await http.post(
        Uri.parse(
          "http://10.0.2.2:8080/api/clientes",
        ),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({

          "nomCli": nombre,

          "apeCli": apellido,

          "correoCli": correo,

          "password": password,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Cuenta creada correctamente",
            ),
          ),
        );

        // Regresar al Login
        Navigator.pop(context);

      } else {

        String mensaje =
            "No se pudo crear la cuenta";

        try {

          final data =
              jsonDecode(response.body);

          if (data is String) {
            mensaje = data;
          }

        } catch (_) {}

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensaje),
          ),
        );
      }

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error de conexión: $e",
          ),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {
          cargando = false;
        });

      }
    }
  }

  @override
  void dispose() {

    nombreController.dispose();
    apellidoController.dispose();
    correoController.dispose();
    passwordController.dispose();
    confirmarPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Crear cuenta",
        ),
      ),

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

            padding: const EdgeInsets.all(30),

            child: Column(

              children: [

                const Icon(
                  Icons.person_add,
                  size: 80,
                  color: Color.fromARGB(
                    255,
                    1,
                    3,
                    90,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Crear cuenta",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: apellidoController,
                  decoration: const InputDecoration(
                    labelText: "Apellido",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person_outline,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: correoController,
                  keyboardType:
                      TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Correo",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller:
                      confirmarPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText:
                        "Confirmar contraseña",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(

                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(

                    onPressed:
                        cargando
                            ? null
                            : registrarUsuario,

                    child: cargando

                        ? const SizedBox(
                            width: 25,
                            height: 25,
                            child:
                                CircularProgressIndicator(),
                          )

                        : const Text(
                            "REGISTRARME",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 15),

                TextButton(

                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: const Text(
                    "¿Ya tienes una cuenta? "
                    "Iniciar sesión",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}