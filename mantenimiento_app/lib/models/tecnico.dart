class Tecnico {
  final int idTec;
  final String nomTec;
  final String apeTec;
  final String telTec;
  final String correoTec;
  final String dispTec;
  final String especialidad;

  Tecnico({
    required this.idTec,
    required this.nomTec,
    required this.apeTec,
    required this.telTec,
    required this.correoTec,
    required this.dispTec,
    required this.especialidad,
  });

  factory Tecnico.fromJson(Map<String, dynamic> json) {
    return Tecnico(
      idTec: json['idTec'],
      nomTec: json['nomTec'],
      apeTec: json['apeTec'],
      telTec: json['telTec'],
      correoTec: json['correoTec'],
      dispTec: json['dispTec'],
      especialidad: json['especialidad']['descEspTec'],
    );
  }
}