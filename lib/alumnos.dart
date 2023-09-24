class Alumnos {
  late final int al_id;
  late final String al_apellidos;
  late final String al_nombres;
  late final String ins_id;
  late final String al_ins_ciclo;
  late final String al_ins_paralelo;

  Alumnos ({
    required this.al_id,
    required this.al_apellidos,
    required this.al_nombres,
    required this.ins_id,
    required this.al_ins_ciclo,
    required this.al_ins_paralelo,

  });

  Alumnos.fromMap(Map<String, dynamic> result)
      : al_id = result["al_id"],
        al_apellidos = result["al_apellidos"],
        al_nombres = result["al_nombres"],
        ins_id = result["ins_id"],
        al_ins_ciclo = result["al_ins_ciclo"],
        al_ins_paralelo = result["al_ins_paralelo"];


  Map<String, Object> toMap() {
    return {
      'al_id': al_id,
      'al_apellidos': al_apellidos,
      'al_nombres': al_nombres,
      'ins_id': ins_id,
      'al_ins_ciclo': al_ins_ciclo,
      'al_ins_paralelo': al_ins_paralelo
    };
  }

  Alumnos.fromMap2(Map<String, dynamic> result)
      : al_apellidos = result["al_apellidos"],
        al_nombres = result["al_nombres"];
  Map<String, Object> toMap2() {
    return {
      'al_apellidos': al_apellidos,
      'al_nombres': al_nombres
    };
  }
}
