class Instituciones {
  late final String ins_id;
  late final String ins_nombre;
  late final String ins_tipo;  //Urbano - Rural
  late final String ins_estado; //Activo _ Inactivo

  Instituciones ({
    required this.ins_id,
    required this.ins_nombre,
    required this.ins_tipo,
    required this.ins_estado,
  });

  Instituciones.fromMap(Map<String, dynamic> result)
      : ins_id = result["ins_id"],
        ins_nombre = result["ins_nombre"],
        ins_tipo = result["ins_tipo"],
        ins_estado = result["ins_estado"];
  Map<String, Object> toMap() {
    return {
      'ins_id': ins_id,
      'ins_nombre': ins_nombre,
      'ins_tipo': ins_tipo,
      'ins_estado': ins_estado
    };
  }

  Instituciones.fromMap2(Map<String, dynamic> result)
      : ins_id = result["ins_id"],
        ins_nombre = result["ins_nombre"];
  Map<String, Object> toMap2() {
    return {
      'ins_id': ins_id,
      'ins_nombre': ins_nombre,
    };
  }
}
