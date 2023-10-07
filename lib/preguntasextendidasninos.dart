import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unae/notas.dart';
import 'database.dart';
import 'instituciones.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'notas.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

late DataBase handler = DataBase();

var calificaciones = {
  '1': -1.0,
  '2': -1.0,
  '3': -1.0,

};
var parametros = {
  'ins_id': '',
  'al_ins_ciclo': '',
  'al_ins_paralelo': '',
  'al_id': 0,
  'nota_fecha': '',
  'nota_p1': '',
  'nota_p2': '',
  'nota_p3': '',
  'nota_p4': '',
  'nota_p5': '',
  'nota_p6': '',
  'nota_p7': '',
  'nota_p8': '',
  'nota_p9': '',
  'nota_p10': '',
  'nota_adc': '',
};



class pantallaPreguntasExtendidasNinos extends StatefulWidget {
  final String par_curso;
  final String par_paralelo;
  final String par_ent_cod;
  final int par_al_id;
  final String par_nombre_completo;

  const pantallaPreguntasExtendidasNinos({
    Key? key,
    required this.par_ent_cod,
    required this.par_curso,
    required this.par_paralelo,
    required this.par_al_id,
    required this.par_nombre_completo,
  }) : super(key: key);

  @override
  _pantallaPreguntasExtendidasNinosState createState() =>
      _pantallaPreguntasExtendidasNinosState();
}

class _pantallaPreguntasExtendidasNinosState
    extends State<pantallaPreguntasExtendidasNinos> {
  /*void _show() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Hi, I am a snack bar!"),
    ));
  }*/

  Future<bool> validar(
      codigoentidad, codigocurso, codigoparalelo, codigoalumno) async {
    List<Notas> listaaux = [];
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    listaaux = await handler.retrieveNotasAlumno(
        codigoentidad, codigocurso, codigoparalelo, currentDate, codigoalumno);
    //mapamarcaciones[alumno.al_id]="S";
    if (listaaux.length > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("La calificacion ya fue registrada"),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop();
    } else {
      print("No Marcado");
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    print(widget.par_ent_cod);
    print(widget.par_curso);
    print(widget.par_paralelo);
    print(widget.par_al_id);
    print(widget.par_nombre_completo);
    setState(() {
      calificaciones = {
        '1': -1.0,
        '2': -1.0,
        '3': -1.0,
      };
      parametros['ins_id'] = widget.par_ent_cod;
      parametros['al_ins_ciclo'] = widget.par_curso;
      parametros['al_ins_paralelo'] = widget.par_paralelo;
      parametros['al_id'] = widget.par_al_id;
      //validar(widget.par_ent_cod,widget.par_curso,widget.par_paralelo,widget.par_al_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double? _ratingValue;
    String _radioValue1 = "grupo1";
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(widget.par_nombre_completo),
        backgroundColor: const Color(0xff1D4554),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: ListView(children: <Widget>[
          Pregunta1(context),

          Pregunta2(context),
          Pregunta3(context),
        ]))
      ]),
      floatingActionButton: BotonOpcion("Grabar", "btn1", context),
    ));
  }
}

Widget _image(String asset) {
  return Image.asset(
    asset,
    height: 30.0,
    width: 30.0,
    color: Colors.amber,
  );
}

Widget BotonOpcion(String texto, String etiqueta, BuildContext contexto) {
  return Builder(
      builder: (context) => FloatingActionButton(
          backgroundColor: texto == "Cancelar" ? Colors.red : Color(0xff4e9603),
          heroTag: etiqueta,
          child: FittedBox(child: Text(texto)),
          onPressed: () {
            if (texto == "Cancelar") {
              Navigator.of(contexto).pop();
            }
            if (texto == "Grabar") {
              var valido = true;
              calificaciones.forEach((key, value) {
                if (double.parse(value.toString()) < 0.0) {
                  valido = false;
                }
              });

              if (valido == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Existen valores sin calificación.  No se puede grabar"),
                    duration: Duration(seconds: 5),
                  ),
                );
              } else {
                print(calificaciones.toString());
                print("a grabar");
                String currentDate =
                    DateFormat('yyyy-MM-dd').format(DateTime.now());
                String tiempocompleto =
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

                Notas objeto = Notas(
                  //nota_id: null,//nota_id:1,
                  ins_id: parametros['ins_id'].toString(),
                  al_ins_ciclo: parametros['al_ins_ciclo'].toString(),
                  al_ins_paralelo: parametros['al_ins_paralelo'].toString(),
                  al_id: int.parse(parametros['al_id'].toString()),
                  nota_fecha: currentDate,
                  nota_p1: calificaciones['1'].toString(),
                  nota_p2: calificaciones['2'].toString(),
                  nota_p3: calificaciones['3'].toString(),
                  nota_p4: "0",
                  nota_p5: "0",
                  nota_p6: "0",
                  nota_p7: "0",
                  nota_p8: "0",
                  nota_p9: "0",
                  nota_p10: "0",
                  nota_p11: "0",
                  nota_p12: "0",
                  //las preguntas validas son mayores o iguales a 1
                  nota_p13: "0",
                  nota_p14: "0",
                  nota_p15: "0",
                  nota_p16: "0",
                  nota_p17: "0",
                  nota_p18: "0",
                  nota_p19: "0",
                  nota_p20: "0",
                  nota_estado: "I",
                  nota_adc: tiempocompleto,
                );
                handler.initializedDB().whenComplete(() async {
                  handler.insertNota(objeto);
                });
                ScaffoldMessenger.of(contexto).showSnackBar(
                  SnackBar(
                    content: Text("Calificación guardada"),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.of(contexto).pop();
              }
              ;
            }
          }));
}

Widget Pregunta1(BuildContext context) {
  //IconData icono = FontAwesomeIcons.faceLaughBeam;
  return Card(
    shape: RoundedRectangleBorder(
      //<-- 1. SEE HERE
      side: BorderSide(
        color: Colors.lightBlue,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    margin: const EdgeInsets.all(20),
    child: ListTile(
      onTap: () {},
      title: RichText(
        overflow: TextOverflow.clip,
        textAlign: TextAlign.justify,
        softWrap: true,
        maxLines: 10,
        textScaleFactor: 1,
        text: TextSpan(
          text:
              "\nPregunta 1. ¿Cuánto te gusto la clase?",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
      Row(
        children: [
          RatingBar.builder(
            initialRating: -1,
            itemCount: 5,
            itemSize: 50.0,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  );
                case 1:
                  return Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );
                case 2:
                  return Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );
                case 3:
                  return Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );
                case 4:
                  return Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
              }
              return Container();
            },
            onRatingUpdate: (rating) {
              if (rating != null) {
                calificaciones["1"] = rating.toDouble() ; //rating no necesita sumar porque empieza en 1
              }
              print(calificaciones.toString());
            },
          ),
          SizedBox(
            width: 20, // <-- SEE HERE
          ),

          SizedBox(
            height: 30, // <-- SEE HERE
          ),
        ])],
      ),
      ),
    );
}
Widget Pregunta2(BuildContext context) {
  //IconData icono = FontAwesomeIcons.faceLaughBeam;
  return Card(
    shape: RoundedRectangleBorder(
      //<-- 1. SEE HERE
      side: BorderSide(
        color: Colors.lightBlue,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    margin: const EdgeInsets.all(20),
    child: ListTile(
      onTap: () {},
      title: RichText(
        overflow: TextOverflow.clip,
        textAlign: TextAlign.justify,
        softWrap: true,
        maxLines: 10,
        textScaleFactor: 1,
        text: TextSpan(
          text:
          "\nPregunta 2. ¿Cómo te sentiste con la presencia de los practicantes?",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          Row(
              children: [
                RatingBar.builder(
                  initialRating: -1,
                  itemCount: 5,
                  itemSize: 50.0,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                    }
                    return Container();
                  },
                  onRatingUpdate: (rating) {
                    if (rating != null) {
                      calificaciones["2"] = rating.toDouble(); //rating no necesita sumar porque empieza en 1
                    }
                    print(calificaciones.toString());
                  },
                ),
                SizedBox(
                  width: 20, // <-- SEE HERE
                ),

                SizedBox(
                  height: 30, // <-- SEE HERE
                ),
              ])],
      ),
    ),
  );
}

Widget Pregunta3(BuildContext context) {
  //IconData icono = FontAwesomeIcons.faceLaughBeam;
  return Card(
    shape: RoundedRectangleBorder(
      //<-- 1. SEE HERE
      side: BorderSide(
        color: Colors.lightBlue,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    margin: const EdgeInsets.all(20),
    child: ListTile(
      onTap: () {},
      title: RichText(
        overflow: TextOverflow.clip,
        textAlign: TextAlign.justify,
        softWrap: true,
        maxLines: 10,
        textScaleFactor: 1,
        text: TextSpan(
          text:
          "\nPregunta 3. ¿Quieres que regresen los profes?",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          Row(
              children: [
                ToggleSwitch(
                  minWidth: 90.0,
                  minHeight: 70.0,
                  initialLabelIndex: -1,
                  cornerRadius: 30.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.blueGrey.shade50,
                  inactiveFgColor: Colors.grey,
                  totalSwitches: 2,
                  icons: [
                    FontAwesomeIcons.thumbsDown,
                    FontAwesomeIcons.thumbsUp
                  ],
                  iconSize: 30.0,
                  borderWidth: 0.0,
                  borderColor: [Colors.blueGrey],
                  activeBgColors: [[Colors.red], [Colors.lightGreen]],
                  onToggle: (index) {
                    if (index != null) {
                      calificaciones["3"] = index.toDouble() + 1;
                    }
                    print(calificaciones.toString());
                  },
                ),
                SizedBox(
                  height: 40, // <-- SEE HERE
                ),
              ])],
      ),
    ),
  );
}
