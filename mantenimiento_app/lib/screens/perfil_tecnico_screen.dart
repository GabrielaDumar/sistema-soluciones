import 'package:flutter/material.dart';
import '../models/tecnico.dart';
import 'solicitar_servicio_screen.dart';

class PerfilTecnicoScreen extends StatelessWidget {
  final Tecnico tecnico;
  final int idCliente;

  const PerfilTecnicoScreen({
    super.key,
    required this.tecnico,
    required this.idCliente,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perfil del técnico",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // FOTO / AVATAR
            const CircleAvatar(
              radius: 55,
              child: Icon(
                Icons.person,
                size: 60,
              ),
            ),

            const SizedBox(height: 20),

            // NOMBRE
            Text(
              "${tecnico.nomTec} ${tecnico.apeTec}",
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // ESPECIALIDAD
            Text(
              tecnico.especialidad,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // INFORMACIÓN
            Card(
              elevation: 4,

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    _dato(
                      Icons.phone,
                      "Teléfono",
                      tecnico.telTec,
                    ),

                    const Divider(),

                    _dato(
                      Icons.email,
                      "Correo",
                      tecnico.correoTec,
                    ),

                    const Divider(),

                    _dato(
                      Icons.work,
                      "Especialidad",
                      tecnico.especialidad,
                    ),

                    const Divider(),

                    _dato(
                      Icons.circle,
                      "Disponibilidad",
                      tecnico.dispTec,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // BOTÓN
            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          SolicitarServicioScreen(
                        tecnico: tecnico,
                        idCliente: idCliente,
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.build,
                ),

                label: const Text(
                  "Solicitar servicio",

                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dato(
    IconData icono,
    String titulo,
    String valor,
  ) {
    return Row(
      children: [
        Icon(
          icono,
          size: 28,
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                titulo,

                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                valor,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}