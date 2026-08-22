class Servicio {
  final int idSer;

  final int idTipoServicio;

  final int idTecnico;

  final int idCliente;

  final String nombreCliente;

  final String apellidoCliente;

  final String correoCliente;

  final double? precioSer;

  final String estadoSer;

  final String fechaSer;

  final String descripcionSer;

  Servicio({
    required this.idSer,
    required this.idTipoServicio,
    required this.idTecnico,
    required this.idCliente,
    required this.nombreCliente,
    required this.apellidoCliente,
    required this.correoCliente,
    this.precioSer,
    required this.estadoSer,
    required this.fechaSer,
    required this.descripcionSer,
  });

  factory Servicio.fromJson(
    Map<String, dynamic> json,
  ) {
    final Map<String, dynamic>? cliente =
        json['cliente'] != null
            ? Map<String, dynamic>.from(
                json['cliente'],
              )
            : null;

    final Map<String, dynamic>? tecnico =
        json['tecnico'] != null
            ? Map<String, dynamic>.from(
                json['tecnico'],
              )
            : null;

    final Map<String, dynamic>? tipoServicio =
        json['tipoServicio'] != null
            ? Map<String, dynamic>.from(
                json['tipoServicio'],
              )
            : null;

    return Servicio(
      // ==========================================
      // SERVICIO
      // ==========================================

      idSer: json['idSer'] ?? 0,

      precioSer: json['precioSer'] != null
          ? double.tryParse(
              json['precioSer'].toString(),
            )
          : null,

      estadoSer:
          json['estadoSer']?.toString() ?? '',

      fechaSer:
          json['fechaSer']?.toString() ?? '',

      descripcionSer:
          json['descripcionSer']?.toString() ?? '',

      // ==========================================
      // TIPO DE SERVICIO
      // ==========================================

      idTipoServicio:
          tipoServicio?['idTipoSer'] ?? 0,

      // ==========================================
      // TÉCNICO
      // ==========================================

      idTecnico:
          tecnico?['idTec'] ?? 0,

      // ==========================================
      // CLIENTE
      // ==========================================

      idCliente:
          cliente?['idCliente'] ?? 0,

      nombreCliente:
          cliente?['nomCli']?.toString() ?? '',

      apellidoCliente:
          cliente?['apeCli']?.toString() ?? '',

      correoCliente:
          cliente?['correoCli']?.toString() ?? '',
    );
  }
}