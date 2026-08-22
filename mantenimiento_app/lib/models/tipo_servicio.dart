class TipoServicio {
  final int idTipoSer;
  final String descTipoSer;

  TipoServicio({
    required this.idTipoSer,
    required this.descTipoSer,
  });

  factory TipoServicio.fromJson(Map<String, dynamic> json) {
    return TipoServicio(
      idTipoSer: json['idTipoSer'],
      descTipoSer: json['descTipoSer'],
    );
  }
}