import 'package:flutter/material.dart';

import '../models/servicio.dart';
import '../services/api_service.dart';

class MisServiciosTecnicoScreen extends StatefulWidget {
  final int idTecnico;

  const MisServiciosTecnicoScreen({
    super.key,
    required this.idTecnico,
  });

  @override
  State<MisServiciosTecnicoScreen> createState() =>
      _MisServiciosTecnicoScreenState();
}

class _MisServiciosTecnicoScreenState
    extends State<MisServiciosTecnicoScreen> {

  final ApiService apiService = ApiService();

  List<Servicio> servicios = [];

  bool cargando = true;

  @override
  void initState() {
    super.initState();

    cargarServicios();
  }

  // =====================================================
  // CARGAR SERVICIOS ACEPTADOS
  // =====================================================

  Future<void> cargarServicios() async {
    try {
      final resultado =
          await apiService
              .obtenerServiciosAceptadosPorTecnico(
        widget.idTecnico,
      );

      if (!mounted) return;

      setState(() {
        servicios = resultado;
        cargando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        cargando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error al cargar tus servicios: $e",
          ),
        ),
      );
    }
  }

  // =====================================================
  // ACTUALIZAR
  // =====================================================

  Future<void> actualizar() async {
    setState(() {
      cargando = true;
    });

    await cargarServicios();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mis servicios",
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: actualizar,
          ),
        ],
      ),

      body: cargando

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : servicios.isEmpty

              ? RefreshIndicator(
                  onRefresh: actualizar,

                  child: ListView(
                    children: [

                      SizedBox(
                        height:
                            MediaQuery.of(context)
                                .size
                                .height *
                            0.30,
                      ),

                      const Icon(
                        Icons.build_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Center(
                        child: Text(
                          "No tienes servicios activos",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      const Center(
                        child: Text(
                          "Los servicios que aceptes\n"
                          "aparecerán aquí.",
                          textAlign:
                              TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )

              : RefreshIndicator(
                  onRefresh: actualizar,

                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(15),

                    itemCount:
                        servicios.length,

                    itemBuilder:
                        (context, index) {

                      final servicio =
                          servicios[index];

                      return Card(
                        elevation: 4,

                        margin:
                            const EdgeInsets.only(
                          bottom: 15,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        child: Padding(
                          padding:
                              const EdgeInsets.all(18),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              // =================================
                              // ENCABEZADO
                              // =================================

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,

                                children: [

                                  Expanded(
                                    child: Text(
                                      "Servicio #"
                                      "${servicio.idSer}",

                                      style:
                                          const TextStyle(
                                        fontSize: 19,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Chip(
                                    avatar:
                                        const Icon(
                                      Icons.check_circle,
                                      size: 18,
                                    ),

                                    label:
                                        const Text(
                                      "Aceptado",
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(
                                height: 25,
                              ),

                              // =================================
                              // CLIENTE
                              // =================================

                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  const Icon(
                                    Icons.person,
                                    size: 28,
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        const Text(
                                          "Cliente",

                                          style:
                                              TextStyle(
                                            color:
                                                Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),

                                        Text(
                                          "${servicio.nombreCliente} "
                                          "${servicio.apellidoCliente}",

                                          style:
                                              const TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          servicio
                                              .correoCliente,

                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 18,
                              ),

                              // =================================
                              // FECHA
                              // =================================

                              Row(
                                children: [

                                  const Icon(
                                    Icons.calendar_today,
                                    size: 22,
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Text(
                                    "Fecha: "
                                    "${servicio.fechaSer}",
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 18,
                              ),

                              // =================================
                              // DESCRIPCIÓN
                              // =================================

                              const Text(
                                "Descripción",

                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                servicio
                                    .descripcionSer
                                    .isEmpty
                                    ? "Sin descripción"
                                    : servicio
                                        .descripcionSer,

                                style:
                                    const TextStyle(
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(
                                height: 18,
                              ),

                              // =================================
                              // PRECIO
                              // =================================

                              if (servicio.precioSer != null)
                                Row(
                                  children: [

                                    const Icon(
                                      Icons
                                          .attach_money,
                                      size: 22,
                                    ),

                                    const SizedBox(
                                      width: 5,
                                    ),

                                    Text(
                                      servicio
                                          .precioSer
                                          .toString(),

                                      style:
                                          const TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}