class Notas {
  late final int nota_id;
  late final String ins_id;
  late final String al_ins_ciclo;
  late final String al_ins_paralelo;
  late final int al_id;
  late final String nota_fecha;
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
  late final String nota_p11;
  late final String nota_p12;
  late final String nota_p13;
  late final String nota_p14;
  late final String nota_p15;
  late final String nota_p16;
  late final String nota_p17;
  late final String nota_p18;
  late final String nota_p19;
  late final String nota_p20;

  late final String nota_adc;
  late final String nota_estado;
  //estado A:Activo P:Procesado

  Notas ({
    //required this.nota_id,
    required this.ins_id,
    required this.al_ins_ciclo,
    required this.al_ins_paralelo,
    required this.al_id,
    required this.nota_fecha,
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

    required this.nota_p11,
    required this.nota_p12,
    required this.nota_p13,
    required this.nota_p14,
    required this.nota_p15,
    required this.nota_p16,
    required this.nota_p17,
    required this.nota_p18,
    required this.nota_p19,
    required this.nota_p20,

    required this.nota_estado,
    required this.nota_adc,
  });

  Notas.fromMap(Map<String, dynamic> result)
      : nota_id = result["nota_id"],
        ins_id = result["ins_id"],
        al_ins_ciclo = result["al_ins_ciclo"],
        al_ins_paralelo = result["al_ins_paralelo"],
        al_id = result["al_id"],
        nota_fecha = result["nota_fecha"],
        nota_p1 = result["nota_p1"],
        nota_p2 = result["nota_p2"],
        nota_p3 = result["nota_p3"],
        nota_p4 = result["nota_p4"],
        nota_p5 = result["nota_p5"],
        nota_p6 = result["nota_p6"],
        nota_p7 = result["nota_p7"],
        nota_p8 = result["nota_p8"],
        nota_p9 = result["nota_p9"],
        nota_p10 = result["nota_p10"],

        nota_p11 = result["nota_p11"],
        nota_p12 = result["nota_p12"],
        nota_p13 = result["nota_p13"],
        nota_p14 = result["nota_p14"],
        nota_p15 = result["nota_p15"],
        nota_p16 = result["nota_p16"],
        nota_p17 = result["nota_p17"],
        nota_p18 = result["nota_p18"],
        nota_p19 = result["nota_p19"],
        nota_p20 = result["nota_p20"],

        nota_adc = result["nota_adc"],
        nota_estado = result["nota_estado"];

  /*Map<String, Object> toMap() {
    return {
      'al_id': al_id,
      'ins_id': ins_id,
      'al_ins_ciclo': al_ins_ciclo,
      'al_ins_paralelo': al_ins_paralelo
    };
  }*/

  Map<String, Object> toMap2() {
    return {
      //'nota_id': nota_id,
      'ins_id': ins_id,
      'al_ins_ciclo': al_ins_ciclo,
      'al_ins_paralelo': al_ins_paralelo,
      'al_id': al_id,
      'nota_fecha' : nota_fecha,
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

      'nota_p11': nota_p11,
      'nota_p12': nota_p12,
      'nota_p13': nota_p13,
      'nota_p14': nota_p14,
      'nota_p15': nota_p15,
      'nota_p16': nota_p16,
      'nota_p17': nota_p17,
      'nota_p18': nota_p18,
      'nota_p19': nota_p19,
      'nota_p20': nota_p20,
      'nota_estado' : nota_estado,
      'nota_adc' : nota_adc,
    };
  }

}
