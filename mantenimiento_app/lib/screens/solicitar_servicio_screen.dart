import 'package:flutter/material.dart';
import '../models/tecnico.dart';
import '../models/tipo_servicio.dart';
import '../services/api_service.dart';

class SolicitarServicioScreen extends StatefulWidget {
  final Tecnico tecnico;
  final int idCliente;

  const SolicitarServicioScreen({
    super.key,
    required this.tecnico,
    required this.idCliente,
  });

  @override
  State<SolicitarServicioScreen> createState() =>
      _SolicitarServicioScreenState();
}

class _SolicitarServicioScreenState
    extends State<SolicitarServicioScreen> {

  final ApiService apiService = ApiService();

  late Future<List<TipoServicio>> tiposServicio;

  TipoServicio? tipoSeleccionado;

  DateTime? fechaSeleccionada;

  final TextEditingController descripcionController =
      TextEditingController();

  bool enviando = false;

  @override
  void initState() {
    super.initState();

    tiposServicio = apiService.obtenerTiposServicio();
  }

  @override
  void dispose() {
    descripcionController.dispose();
    super.dispose();
  }

  // =========================================================
  // SELECCIONAR FECHA
  // =========================================================

  Future<void> seleccionarFecha() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (fecha != null) {
      setState(() {
        fechaSeleccionada = fecha;
      });
    }
  }

  // =========================================================
  // CREAR SERVICIO
  // =========================================================

  Future<void> confirmarSolicitud() async {

    if (tipoSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Selecciona el tipo de servicio",
          ),
        ),
      );
      return;
    }

    if (fechaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Selecciona una fecha",
          ),
        ),
      );
      return;
    }

    if (descripcionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Describe el problema o servicio que necesitas",
          ),
        ),
      );
      return;
    }

    setState(() {
      enviando = true;
    });

    try {

      final fecha =
          "${fechaSeleccionada!.year}-"
          "${fechaSeleccionada!.month.toString().padLeft(2, '0')}-"
          "${fechaSeleccionada!.day.toString().padLeft(2, '0')}";

      await apiService.crearServicio(
        idTipoServicio: tipoSeleccionado!.idTipoSer,
        idTecnico: widget.tecnico.idTec,
        idCliente: widget.idCliente,
        fecha: fecha,
        descripcion: descripcionController.text.trim(),
      );

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Solicitud enviada",
            ),

            content: const Text(
              "Tu solicitud de servicio fue registrada correctamente.",
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },

                child: const Text(
                  "Aceptar",
                ),
              ),
            ],
          );
        },
      );

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "No se pudo crear la solicitud: $e",
          ),
        ),
      );

    } finally {

      if (mounted) {
        setState(() {
          enviando = false;
        });
      }
    }
  }

  // =========================================================
  // INTERFAZ
  // =========================================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Solicitar servicio",
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // =================================================
            // TÉCNICO SELECCIONADO
            // =================================================

            const Text(
              "Técnico seleccionado",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              elevation: 3,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: ListTile(

                leading: const CircleAvatar(
                  child: Icon(
                    Icons.person,
                  ),
                ),

                title: Text(
                  "${widget.tecnico.nomTec} "
                  "${widget.tecnico.apeTec}",

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                subtitle: Text(
                  widget.tecnico.especialidad,

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // TIPO DE SERVICIO
            // =================================================

            const Text(
              "Tipo de servicio",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            FutureBuilder<List<TipoServicio>>(
              future: tiposServicio,

              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {

                  return Text(
                    "Error: ${snapshot.error}",
                  );
                }

                final tipos = snapshot.data ?? [];

                if (tipos.isEmpty) {
                  return const Text(
                    "No hay tipos de servicio disponibles.",
                  );
                }

                return DropdownButtonFormField<TipoServicio>(

                  // IMPORTANTE:
                  // Permite que el Dropdown utilice todo
                  // el ancho disponible.
                  isExpanded: true,

                  value: tipoSeleccionado,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    prefixIcon: const Icon(
                      Icons.build,
                    ),

                    hintText: "Selecciona un servicio",
                  ),

                  items: tipos.map((tipo) {

                    return DropdownMenuItem<TipoServicio>(
                      value: tipo,

                      child: SizedBox(
                        width: double.infinity,

                        child: Text(
                          tipo.descTipoSer,

                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );

                  }).toList(),

                  onChanged: (valor) {

                    setState(() {
                      tipoSeleccionado = valor;
                    });

                  },
                );
              },
            ),

            const SizedBox(height: 25),

            // =================================================
            // FECHA
            // =================================================

            const Text(
              "Fecha del servicio",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            InkWell(
              onTap: seleccionarFecha,

              child: InputDecorator(

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  prefixIcon: const Icon(
                    Icons.calendar_today,
                  ),
                ),

                child: Text(
                  fechaSeleccionada == null
                      ? "Selecciona una fecha"
                      : "${fechaSeleccionada!.day}/"
                        "${fechaSeleccionada!.month}/"
                        "${fechaSeleccionada!.year}",

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // DESCRIPCIÓN
            // =================================================

            const Text(
              "Descripción del servicio",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(

              controller: descripcionController,

              maxLines: 5,

              decoration: InputDecoration(

                hintText:
                    "Describe el problema o el servicio que necesitas...",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                prefixIcon: const Padding(
                  padding: EdgeInsets.only(
                    bottom: 80,
                  ),

                  child: Icon(
                    Icons.description,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // ESTADO
            // =================================================

            Card(
              elevation: 2,

              child: ListTile(

                leading: const Icon(
                  Icons.pending,
                  color: Colors.orange,
                ),

                title: const Text(
                  "Estado de la solicitud",
                ),

                subtitle: const Text(
                  "Pendiente",
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // BOTÓN CONFIRMAR
            // =================================================

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton.icon(

                onPressed:
                    enviando
                        ? null
                        : confirmarSolicitud,

                icon: enviando

                    ? const SizedBox(
                        width: 20,
                        height: 20,

                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )

                    : const Icon(
                        Icons.check,
                      ),

                label: Text(
                  enviando
                      ? "Enviando..."
                      : "Confirmar solicitud",

                  style: const TextStyle(
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
}