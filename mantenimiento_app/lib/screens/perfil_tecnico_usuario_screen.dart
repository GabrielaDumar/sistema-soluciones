import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../services/api_service.dart';

class PerfilTecnicoUsuarioScreen
    extends StatefulWidget {

  final Usuario usuario;

  const PerfilTecnicoUsuarioScreen({
    super.key,
    required this.usuario,
  });

  @override
  State<PerfilTecnicoUsuarioScreen>
      createState() =>
          _PerfilTecnicoUsuarioScreenState();
}

class _PerfilTecnicoUsuarioScreenState
    extends State<PerfilTecnicoUsuarioScreen> {

  final ApiService apiService =
      ApiService();

  Map<String, dynamic>? tecnico;

  bool cargando = true;

  @override
  void initState() {
    super.initState();

    cargarTecnico();
  }

  Future<void> cargarTecnico() async {
    try {
      final resultado =
          await apiService.obtenerTecnicoPorCorreo(
        widget.usuario.correoUsu,
      );

      if (!mounted) return;

      setState(() {
        tecnico = resultado;
        cargando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        cargando = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "No se pudo cargar el perfil: $e",
          ),
        ),
      );
    }
  }

  String obtenerEspecialidad() {
    if (tecnico == null) {
      return "Sin especialidad";
    }

    final especialidad =
        tecnico!['especialidad'];

    if (especialidad == null) {
      return "Sin especialidad";
    }

    return especialidad['descEspTec'] ??
        "Sin especialidad";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mi perfil",
        ),
      ),

      body: cargando
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : tecnico == null
              ? const Center(
                  child: Text(
                    "No se encontró la información del técnico.",
                  ),
                )

              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,

                        child: Icon(
                          Icons.person,
                          size: 65,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        "${tecnico!['nomTec'] ?? ''} "
                        "${tecnico!['apeTec'] ?? ''}",

                        style:
                            const TextStyle(
                          fontSize: 26,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        obtenerEspecialidad(),

                        style:
                            const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Card(
                        elevation: 4,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),

                        child: Padding(
                          padding:
                              const EdgeInsets.all(
                            20,
                          ),

                          child: Column(
                            children: [
                              _dato(
                                Icons.badge,
                                "ID del técnico",
                                "${tecnico!['idTec'] ?? ''}",
                              ),

                              const Divider(),

                              _dato(
                                Icons.person,
                                "Nombre",
                                "${tecnico!['nomTec'] ?? ''} "
                                "${tecnico!['apeTec'] ?? ''}",
                              ),

                              const Divider(),

                              _dato(
                                Icons.phone,
                                "Teléfono",
                                "${tecnico!['telTec'] ?? ''}",
                              ),

                              const Divider(),

                              _dato(
                                Icons.email,
                                "Correo",
                                "${tecnico!['correoTec'] ?? ''}",
                              ),

                              const Divider(),

                              _dato(
                                Icons.work,
                                "Especialidad",
                                obtenerEspecialidad(),
                              ),

                              const Divider(),

                              _dato(
                                Icons.circle,
                                "Disponibilidad",
                                "${tecnico!['dispTec'] ?? ''}",
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      Card(
                        child: ListTile(
                          leading:
                              const Icon(
                            Icons.verified_user,
                          ),

                          title: const Text(
                            "Tipo de usuario",
                          ),

                          subtitle: Text(
                            widget.usuario
                                .nombrePerfil,
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

        const SizedBox(
          width: 15,
        ),

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

              const SizedBox(
                height: 3,
              ),

              Text(
                valor,

                style:
                    const TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}