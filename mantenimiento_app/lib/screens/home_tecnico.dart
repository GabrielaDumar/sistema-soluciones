import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../services/api_service.dart';

import 'solicitudes_tecnico_screen.dart';
import 'perfil_tecnico_usuario_screen.dart';
import 'mis_servicios_tecnico.dart';

class HomeTecnicoScreen extends StatefulWidget {
  final Usuario usuario;

  const HomeTecnicoScreen({
    super.key,
    required this.usuario,
  });

  @override
  State<HomeTecnicoScreen> createState() => _HomeTecnicoScreenState();
}

class _HomeTecnicoScreenState extends State<HomeTecnicoScreen> {
  final ApiService apiService = ApiService();

  int? idTecnico;
  bool cargandoTecnico = true;

  @override
  void initState() {
    super.initState();
    cargarTecnico();
  }

  Future<void> cargarTecnico() async {
    try {
      final resultado = await apiService.obtenerTecnicoPorCorreo(
        widget.usuario.correoUsu,
      );

      if (!mounted) return;

      final id = resultado['idTec'];

      setState(() {
        idTecnico = id is int ? id : int.tryParse(id.toString());
        cargandoTecnico = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        cargandoTecnico = false;
        idTecnico = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "No se pudo cargar la información del técnico: $e",
          ),
        ),
      );
    }
  }

  void abrirSolicitudes() {
    if (cargandoTecnico) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Cargando información del técnico...",
          ),
        ),
      );
      return;
    }

    if (idTecnico == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "No se encontró el técnico asociado a este usuario.",
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SolicitudesTecnicoScreen(
          idTecnico: idTecnico!,
        ),
      ),
    );
  }

  void abrirServicios() {
    if (cargandoTecnico) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Cargando información del técnico...",
          ),
        ),
      );
      return;
    }

    if (idTecnico == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "No se encontró el técnico asociado a este usuario.",
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MisServiciosTecnicoScreen(
          idTecnico: idTecnico!,
        ),
      ),
    );
  }

  void abrirPerfil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PerfilTecnicoUsuarioScreen(
          usuario: widget.usuario,
        ),
      ),
    );
  }

  Widget construirOpcion({
    required IconData icono,
    required String titulo,
    required String descripcion,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(
                  icono,
                  size: 30,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      descripcion,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Panel del Técnico",
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
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

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hola, ${widget.usuario.nomUsu} 👋",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Bienvenido a tu panel de trabajo",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              construirOpcion(
                icono: Icons.assignment,
                titulo: "Mis solicitudes",
                descripcion:
                    "Revisa y responde las solicitudes de los clientes",
                onTap: abrirSolicitudes,
              ),

              const SizedBox(height: 20),

              construirOpcion(
                icono: Icons.build,
                titulo: "Mis servicios",
                descripcion:
                    "Consulta los servicios que estás realizando",
                onTap: abrirServicios,
              ),

              const SizedBox(height: 20),

              construirOpcion(
                icono: Icons.person,
                titulo: "Mi perfil",
                descripcion:
                    "Consulta tu información personal y profesional",
                onTap: abrirPerfil,
              ),
            ],
          ),
        ),
      ),
    );
  }
}