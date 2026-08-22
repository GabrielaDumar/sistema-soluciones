class Usuario {
  final int idUsu;
  final String nomUsu;
  final String apeUsu;
  final String correoUsu;
  final String contUsu;

  final int idPerfil;
  final String nombrePerfil;

  final int? idCliente;

  // Datos del técnico
  final int? idTecnico;
  final String? nombreTecnico;
  final String? apellidoTecnico;
  final String? correoTecnico;

  Usuario({
    required this.idUsu,
    required this.nomUsu,
    required this.apeUsu,
    required this.correoUsu,
    required this.contUsu,
    required this.idPerfil,
    required this.nombrePerfil,
    this.idCliente,
    this.idTecnico,
    this.nombreTecnico,
    this.apellidoTecnico,
    this.correoTecnico,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final perfil = json['perfil'];
    final cliente = json['cliente'];
    final tecnico = json['tecnico'];

    return Usuario(
      idUsu: json['idUsu'] ?? 0,

      nomUsu: json['nomUsu'] ?? '',

      apeUsu: json['apeUsu'] ?? '',

      correoUsu: json['correoUsu'] ?? '',

      contUsu: json['contUsu'] ?? '',

      // PERFIL
      idPerfil: perfil != null
          ? perfil['idPerfil'] ?? 0
          : 0,

      nombrePerfil: perfil != null
          ? perfil['nombrePerfil'] ?? ''
          : '',

      // CLIENTE
      idCliente: cliente != null
          ? cliente['idCliente']
          : null,

      // TÉCNICO
      idTecnico: tecnico != null
          ? tecnico['idTec']
          : null,

      nombreTecnico: tecnico != null
          ? tecnico['nomTec']
          : null,

      apellidoTecnico: tecnico != null
          ? tecnico['apeTec']
          : null,

      correoTecnico: tecnico != null
          ? tecnico['correoTec']
          : null,
    );
  }
}