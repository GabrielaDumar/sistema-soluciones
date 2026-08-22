import 'package:flutter/material.dart';
import '../models/usuario.dart';
import 'tecnicos_screen.dart';

class HomeClienteScreen extends StatelessWidget {
  final Usuario usuario;

  const HomeClienteScreen({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicios"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Cerrar sesión",
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              "Hola, ${usuario.nomUsu} 👋",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "¿Qué servicio necesitas?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [
                  // ELECTRICISTAS
                  GestureDetector(
                    onTap: () {
                      if (usuario.idCliente == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "No se encontró el cliente asociado a este usuario.",
                            ),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TecnicosScreen(
                            especialidad: "Electricidad",
                            idCliente: usuario.idCliente!,
                          ),
                        ),
                      );
                    },
                    child: categoriaCard(
                      Icons.electrical_services,
                      "Electricistas",
                    ),
                  ),

                  // PLOMEROS
                  GestureDetector(
                    onTap: () {
                      if (usuario.idCliente == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "No se encontró el cliente asociado a este usuario.",
                            ),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TecnicosScreen(
                            especialidad: "Plomería",
                            idCliente: usuario.idCliente!,
                          ),
                        ),
                      );
                    },
                    child: categoriaCard(
                      Icons.plumbing,
                      "Plomeros",
                    ),
                  ),

                  // PINTORES
                  GestureDetector(
                    onTap: () {
                      if (usuario.idCliente == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "No se encontró el cliente asociado a este usuario.",
                            ),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TecnicosScreen(
                            especialidad: "Pintura",
                            idCliente: usuario.idCliente!,
                          ),
                        ),
                      );
                    },
                    child: categoriaCard(
                      Icons.format_paint,
                      "Pintores",
                    ),
                  ),

                  // CARPINTEROS
                  GestureDetector(
                    onTap: () {
                      if (usuario.idCliente == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "No se encontró el cliente asociado a este usuario.",
                            ),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TecnicosScreen(
                            especialidad: "Carpintería",
                            idCliente: usuario.idCliente!,
                          ),
                        ),
                      );
                    },
                    child: categoriaCard(
                      Icons.carpenter,
                      "Carpinteros",
                    ),
                  ),

                  // SISTEMAS
                  GestureDetector(
                    onTap: () {
                      if (usuario.idCliente == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "No se encontró el cliente asociado a este usuario.",
                            ),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TecnicosScreen(
                            especialidad: "Sistemas",
                            idCliente: usuario.idCliente!,
                          ),
                        ),
                      );
                    },
                    child: categoriaCard(
                      Icons.computer,
                      "Sistemas",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoriaCard(
    IconData icono,
    String titulo,
  ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icono,
            size: 50,
            color: const Color.fromARGB(
              255,
              108,
              156,
              222,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}