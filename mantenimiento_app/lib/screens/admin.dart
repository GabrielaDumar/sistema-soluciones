import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/api_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Usuario>> usuariosFuture;

  @override
  void initState() {
    super.initState();
    usuariosFuture = apiService.obtenerUsuarios();
  }

  void recargarUsuarios() {
    setState(() {
      usuariosFuture = apiService.obtenerUsuarios();
    });
  }

  int contarPerfil(List<Usuario> usuarios, String perfil) {
    return usuarios.where((usuario) => usuario.nombrePerfil == perfil).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel administrativo"),
        actions: [
          IconButton(
            onPressed: recargarUsuarios,
            icon: const Icon(Icons.refresh),
            tooltip: "Actualizar usuarios",
          ),
        ],
      ),
      body: FutureBuilder<List<Usuario>>(
        future: usuariosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    const Text("No se pudieron cargar los usuarios"),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: recargarUsuarios,
                      child: const Text("Reintentar"),
                    ),
                  ],
                ),
              ),
            );
          }

          final usuarios = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: () async => recargarUsuarios(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "Resumen del sistema",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _MetricCard(
                      label: "Usuarios",
                      value: usuarios.length,
                      icon: Icons.people,
                      color: Colors.indigo,
                    ),
                    _MetricCard(
                      label: "Clientes",
                      value: contarPerfil(usuarios, "Cliente"),
                      icon: Icons.person,
                      color: Colors.teal,
                    ),
                    _MetricCard(
                      label: "Técnicos",
                      value: contarPerfil(usuarios, "Tecnico"),
                      icon: Icons.build,
                      color: Colors.orange,
                    ),
                    _MetricCard(
                      label: "Administradores",
                      value: contarPerfil(usuarios, "Administrador"),
                      icon: Icons.admin_panel_settings,
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Text(
                  "Usuarios registrados",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (usuarios.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("No hay usuarios registrados."),
                    ),
                  )
                else
                  ...usuarios.map(
                    (usuario) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            usuario.nomUsu.isEmpty
                                ? "?"
                                : usuario.nomUsu[0].toUpperCase(),
                          ),
                        ),
                        title: Text(
                          "${usuario.nomUsu} ${usuario.apeUsu}",
                        ),
                        subtitle: Text(usuario.correoUsu),
                        trailing: Chip(
                          label: Text(usuario.nombrePerfil),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}