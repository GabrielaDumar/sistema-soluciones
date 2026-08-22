import 'package:flutter/material.dart';
import '../models/servicio.dart';
import '../services/api_service.dart';

class SolicitudesTecnicoScreen extends StatefulWidget {
  final int idTecnico;

  const SolicitudesTecnicoScreen({
    super.key,
    required this.idTecnico,
  });

  @override
  State<SolicitudesTecnicoScreen> createState() =>
      _SolicitudesTecnicoScreenState();
}

class _SolicitudesTecnicoScreenState
    extends State<SolicitudesTecnicoScreen> {
  final ApiService apiService = ApiService();

  late Future<List<Servicio>> serviciosFuture;

  @override
  void initState() {
    super.initState();

    serviciosFuture =
        apiService.obtenerServiciosTecnico(widget.idTecnico);
  }

  // ==========================================================
  // RECARGAR SOLICITUDES
  // ==========================================================

  void _cargarServicios() {
    setState(() {
      serviciosFuture =
          apiService.obtenerServiciosTecnico(widget.idTecnico);
    });
  }

  // ==========================================================
  // CAMBIAR ESTADO DE LA SOLICITUD
  // ==========================================================

  Future<void> _cambiarEstado(
    int idSer,
    String estado,
  ) async {
    try {
      await apiService.actualizarEstadoServicio(
        idSer,
        estado,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            estado == "Aceptado"
                ? "Solicitud aceptada correctamente"
                : "Solicitud rechazada correctamente",
          ),
          backgroundColor:
              estado == "Aceptado"
                  ? Colors.green
                  : Colors.red,
        ),
      );

      _cargarServicios();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error al actualizar la solicitud: $e",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ==========================================================
  // CONFIRMAR ACEPTACIÓN
  // ==========================================================

  void _confirmarAceptar(Servicio servicio) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Aceptar solicitud",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "¿Deseas aceptar la solicitud #${servicio.idSer}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                _cambiarEstado(
                  servicio.idSer,
                  "Aceptado",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // CONFIRMAR RECHAZO
  // ==========================================================

  void _confirmarRechazar(Servicio servicio) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Rechazar solicitud",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "¿Deseas rechazar la solicitud #${servicio.idSer}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                _cambiarEstado(
                  servicio.idSer,
                  "Rechazado",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Rechazar"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // TARJETA DE SOLICITUD
  // ==========================================================

  Widget _crearSolicitud(
    Servicio servicio,
  ) {
    final String estado =
    servicio.estadoSer.trim().toLowerCase();

final bool pendiente =
    estado.isEmpty ||
    estado == "pendiente";

final bool aceptado =
    estado == "aceptado";

final bool rechazado =
    estado == "rechazado";

    Color colorEstado;
    Color fondoEstado;

    if (aceptado) {
      colorEstado = Colors.green.shade700;
      fondoEstado = Colors.green.shade100;
    } else if (rechazado) {
      colorEstado = Colors.red.shade700;
      fondoEstado = Colors.red.shade100;
    } else {
      colorEstado = Colors.orange.shade700;
      fondoEstado = Colors.orange.shade100;
    }

    final String textoEstado =
        servicio.estadoSer.isEmpty
            ? "Pendiente"
            : servicio.estadoSer;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // ==================================================
            // ENCABEZADO
            // ==================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Solicitud #${servicio.idSer}",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: fondoEstado,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: Text(
                    textoEstado,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorEstado,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(
              height: 28,
            ),

            // ==================================================
            // CLIENTE
            // ==================================================

            Text(
              "Cliente",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(
                  Icons.person,
                  size: 22,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    "${servicio.nombreCliente} "
                    "${servicio.apellidoCliente}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Padding(
              padding:
                  const EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                servicio.correoCliente,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ==================================================
            // FECHA
            // ==================================================

            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                ),

                const SizedBox(width: 8),

                Text(
                  "Fecha: ${servicio.fechaSer}",
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ==================================================
            // DESCRIPCIÓN
            // ==================================================

            const Text(
              "Descripción",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              servicio.descripcionSer,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),

            // ==================================================
            // BOTONES
            // ==================================================

            if (pendiente) ...[
              const SizedBox(height: 20),

              const Divider(),

              const SizedBox(height: 10),

              Row(
                children: [
                  // ================================
                  // ACEPTAR
                  // ================================

                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _confirmarAceptar(
                            servicio,
                          );
                        },
                        icon: const Icon(
                          Icons.check,
                          size: 20,
                        ),
                        label: const Text(
                          "Aceptar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green,
                          foregroundColor:
                              Colors.white,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ================================
                  // RECHAZAR
                  // ================================

                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _confirmarRechazar(
                            servicio,
                          );
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                        label: const Text(
                          "Rechazar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red,
                          foregroundColor:
                              Colors.white,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // ==================================================
            // MENSAJE PARA SOLICITUD YA GESTIONADA
            // ==================================================

            if (aceptado) ...[
              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),

                    SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        "Esta solicitud fue aceptada.",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            if (rechazado) ...[
              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),

                    SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        "Esta solicitud fue rechazada.",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mis solicitudes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            tooltip: "Actualizar solicitudes",
            onPressed: _cargarServicios,
          ),
        ],
      ),

      body: FutureBuilder<List<Servicio>>(
        future: serviciosFuture,
        builder: (
          context,
          snapshot,
        ) {
          // ==================================================
          // CARGANDO
          // ==================================================

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ==================================================
          // ERROR
          // ==================================================

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "No se pudieron cargar las solicitudes.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${snapshot.error}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed: _cargarServicios,
                      icon: const Icon(
                        Icons.refresh,
                      ),
                      label: const Text(
                        "Reintentar",
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // ==================================================
          // DATOS
          // ==================================================

          final servicios =
              snapshot.data ?? [];

          // ==================================================
          // SIN SOLICITUDES
          // ==================================================

          if (servicios.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                _cargarServicios();
              },
              child: ListView(
                physics:
                    const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 180,
                  ),

                  Icon(
                    Icons.inbox_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 15),

                  Center(
                    child: Text(
                      "No hay solicitudes.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // ==================================================
          // LISTA DE SOLICITUDES
          // ==================================================

          return RefreshIndicator(
            onRefresh: () async {
              _cargarServicios();
            },
            child: ListView.builder(
              padding:
                  const EdgeInsets.all(16),
              itemCount:
                  servicios.length,
              itemBuilder: (
                context,
                index,
              ) {
                return _crearSolicitud(
                  servicios[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}