class Personal {
  int id;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String telefono;
  String ci;
  String genero;
  String estadoCivil;
  String direccion;
  String urlImg;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Personal({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.telefono,
    required this.ci,
    required this.genero,
    required this.estadoCivil,
    required this.direccion,
    required this.urlImg,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
      id: json['id'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      telefono: json['telefono'],
      ci: json['ci'],
      genero: json['genero'],
      estadoCivil: json['estado_civil'],
      direccion: json['direccion'],
      urlImg: json['url_img'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}
