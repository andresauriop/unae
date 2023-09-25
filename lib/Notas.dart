class Notas {
  late int nota_id;
  late final String ins_id;
  late final String al_ins_ciclo;
  late final String al_ins_paralelo;
  late final int al_id;
  late final String nota_p1;
  late final String nota_p2;
  late final String nota_p3;
  late final String nota_p4;
  late final String nota_p5;
  late final String nota_p6;
  late final String nota_p7;
  late final String nota_p8;
  late final String nota_p9;
  late final String nota_p10;



  Notas ({
    required this.nota_id,
    required this.ins_id,
    required this.al_ins_ciclo,
    required this.al_ins_paralelo,
    required this.al_id,
    required this.nota_p1,
    required this.nota_p2,
    required this.nota_p3,
    required this.nota_p4,
    required this.nota_p5,
    required this.nota_p6,
    required this.nota_p7,
    required this.nota_p8,
    required this.nota_p9,
    required this.nota_p10,
  });

  Notas.fromMap(Map<String, dynamic> result)
      : nota_id = result["nota_id"],
        ins_id = result["ins_id"],
        al_ins_ciclo = result["al_ins_ciclo"],
        al_ins_paralelo = result["al_ins_paralelo"],
        al_id = result["al_id"],
        nota_p1 = result["nota_p1"],
        nota_p2 = result["nota_p2"],
        nota_p3 = result["nota_p3"],
        nota_p4 = result["nota_p4"],
        nota_p5 = result["nota_p5"],
        nota_p6 = result["nota_p6"],
        nota_p7 = result["nota_p7"],
        nota_p8 = result["nota_p8"],
        nota_p9 = result["nota_p9"],
        nota_p10 = result["nota_p10"];

  Map<String, Object> toMap() {
    return {
      'al_id': al_id,
      'ins_id': ins_id,
      'al_ins_ciclo': al_ins_ciclo,
      'al_ins_paralelo': al_ins_paralelo
    };
  }

  Map<String, Object> toMap2() {
    return {
      'nota_id': nota_id,
      'ins_id': ins_id,
      'al_ins_ciclo': al_ins_ciclo,
      'al_ins_paralelo': al_ins_paralelo,
      'al_id': al_id,
      'nota_p1': nota_p1,
      'nota_p2': nota_p2,
      'nota_p3': nota_p3,
      'nota_p4': nota_p4,
      'nota_p5': nota_p5,
      'nota_p6': nota_p6,
      'nota_p7': nota_p7,
      'nota_p8': nota_p8,
      'nota_p9': nota_p9,
      'nota_p10': nota_p10,
    };
  }

}
