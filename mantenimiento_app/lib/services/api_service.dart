import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/tecnico.dart';
import '../models/tipo_servicio.dart';
import '../models/servicio.dart';

class ApiService {
  static const String baseUrl =
      "http://10.0.2.2:8080/api";

  // =========================================================
  // TÉCNICOS
  // =========================================================

  Future<List<Tecnico>> obtenerTecnicos() async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/tecnicos",
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(response.body);

      return data
          .map(
            (json) => Tecnico.fromJson(json),
          )
          .toList();
    }

    throw Exception(
      "Error al cargar técnicos",
    );
  }

  // =========================================================
  // OBTENER TÉCNICO POR CORREO
  // =========================================================

  Future<Map<String, dynamic>>
      obtenerTecnicoPorCorreo(
    String correo,
  ) async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/tecnicos/correo/$correo",
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      "No se encontró el técnico",
    );
  }

  // =========================================================
  // TIPOS DE SERVICIO
  // =========================================================

  Future<List<TipoServicio>>
      obtenerTiposServicio() async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/tipos-servicio",
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(response.body);

      return data
          .map(
            (json) => TipoServicio.fromJson(json),
          )
          .toList();
    }

    throw Exception(
      "Error al cargar tipos de servicio",
    );
  }

  // =========================================================
  // CREAR SERVICIO
  // =========================================================

  Future<bool> crearServicio({
    required int idTipoServicio,
    required int idTecnico,
    required int idCliente,
    required String fecha,
    required String descripcion,
  }) async {
    final response = await http.post(
      Uri.parse(
        "$baseUrl/servicios",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "tipoServicio": {
          "idTipoSer": idTipoServicio,
        },

        "tecnico": {
          "idTec": idTecnico,
        },

        "cliente": {
          "idCliente": idCliente,
        },

        "precioSer": 0,

        "estadoSer": "Pendiente",

        "fechaSer": fecha,

        "descripcionSer": descripcion,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    }

    throw Exception(
      "Error al crear el servicio: "
      "${response.body}",
    );
  }

  // =========================================================
  // OBTENER SERVICIOS DE UN TÉCNICO
  // =========================================================

  Future<List<Servicio>>
      obtenerServiciosTecnico(
    int idTecnico,
  ) async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/servicios/tecnico/$idTecnico",
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(response.body);

      return data
          .map(
            (json) => Servicio.fromJson(json),
          )
          .toList();
    }

    throw Exception(
      "Error al cargar los servicios "
      "del técnico: ${response.body}",
    );
  }

  // =========================================================
  // ALIAS PARA OBTENER SERVICIOS POR TÉCNICO
  // =========================================================

  Future<List<Servicio>>
      obtenerServiciosPorTecnico(
    int idTecnico,
  ) async {
    return obtenerServiciosTecnico(
      idTecnico,
    );
  }

  // =========================================================
  // OBTENER SERVICIOS ACEPTADOS DE UN TÉCNICO
  // =========================================================

  Future<List<Servicio>>
      obtenerServiciosAceptadosPorTecnico(
    int idTecnico,
  ) async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/servicios/tecnico/$idTecnico/aceptados",
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(response.body);

      return data
          .map(
            (json) => Servicio.fromJson(json),
          )
          .toList();
    }

    throw Exception(
      "No se pudieron obtener los "
      "servicios aceptados: ${response.body}",
    );
  }

  // =========================================================
  // ACEPTAR SERVICIO
  // =========================================================

  Future<Servicio> aceptarServicio(
    int idSer,
  ) async {
    return actualizarEstadoServicio(
      idSer,
      "Aceptado",
    );
  }

  // =========================================================
  // RECHAZAR SERVICIO
  // =========================================================

  Future<Servicio> rechazarServicio(
    int idSer,
  ) async {
    return actualizarEstadoServicio(
      idSer,
      "Rechazado",
    );
  }

  // =========================================================
  // ACTUALIZAR ESTADO DEL SERVICIO
  // =========================================================

  Future<Servicio> actualizarEstadoServicio(
    int idSer,
    String estado,
  ) async {
    final response = await http.put(
      Uri.parse(
        "$baseUrl/servicios/$idSer/estado/$estado",
      ),
    );

    if (response.statusCode == 200) {
      return Servicio.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception(
      "No se pudo actualizar el estado "
      "del servicio: ${response.body}",
    );
  }
}