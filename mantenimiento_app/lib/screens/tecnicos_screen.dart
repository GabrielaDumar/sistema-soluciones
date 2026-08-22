import 'package:flutter/material.dart';
import '../models/tecnico.dart';
import '../services/api_service.dart';
import 'perfil_tecnico_screen.dart';

class TecnicosScreen extends StatefulWidget {
  final String especialidad;
  final int idCliente;

  const TecnicosScreen({
    super.key,
    required this.especialidad,
    required this.idCliente,
  });

  @override
  State<TecnicosScreen> createState() =>
      _TecnicosScreenState();
}

class _TecnicosScreenState
    extends State<TecnicosScreen> {

  late Future<List<Tecnico>> tecnicos;

  @override
  void initState() {
    super.initState();

    tecnicos = ApiService().obtenerTecnicos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.especialidad),
      ),

      body: FutureBuilder<List<Tecnico>>(
        future: tecnicos,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
              ),
            );
          }

          final lista = (snapshot.data ?? [])
              .where(
                (t) =>
                    t.especialidad ==
                    widget.especialidad,
              )
              .toList();

          if (lista.isEmpty) {
            return const Center(
              child: Text(
                "No hay técnicos disponibles para esta especialidad.",
              ),
            );
          }

          return ListView.builder(
            itemCount: lista.length,

            itemBuilder: (context, index) {
              final Tecnico tecnico = lista[index];

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        child: Icon(
                          Icons.person,
                          size: 35,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${tecnico.nomTec} ${tecnico.apeTec}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        tecnico.especialidad,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        tecnico.dispTec,
                        style: TextStyle(
                          color: tecnico.dispTec
                                      .toLowerCase() ==
                                  "disponible"
                              ? Colors.green
                              : Colors.red,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PerfilTecnicoScreen(
                                tecnico: tecnico,
                                idCliente:
                                    widget.idCliente,
                              ),
                            ),
                          );
                        },

                        child: const Text(
                          "Ver Perfil",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}