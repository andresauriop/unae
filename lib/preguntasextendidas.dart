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

late DataBase handler = DataBase();

List<String> titles = [
  "\u00BFQué tan efectivos cree que fueron los recursos " +
      "proporcionados en las clases impartidas por los " +
      "por los practicantes para su aprendizaje? " +
      "Material brindado en las clases por los practicantes\n",
  "\u00BFCómo te sientes con la presencia y acompañamiento de los estudiantes UNAE?\n",
  "Desde tu punto de vista, \u00BFCuál crees que fue la forma más efectiva en que el los estudiante apoyaron a la práctica?\n",
  "\u00BFQué cualidades crees que se han visto reflejados en los estudiantes de la UNAE?\n"
  //,  "\n\n"
];
var calificaciones = {'0': -1.0, '1': -1.0, '2': -1.0, '3': -1.0};
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

//nota_id:
/*
              al_ins_ciclo
              al_ins_paralelo:
              al_id =
              nota_fecha =
              nota_p1 =
              nota_p2 =
              nota_p3 =
              nota_p4 =
              nota_p5 =
              nota_p6 =
              nota_p7 =
              nota_p8 =
              nota_p9 =
              nota_p10 =
              nota_adc =
                    */


/*List subtitles = [
  "Here is list 1 subtitle",
  "Here is list 2 subtitle",
  "Here is list 3 subtitle"
];
List icons = [
  Icons.sentiment_neutral_rounded,
  Icons.sentiment_neutral_rounded,
  Icons.done_outline_sharp
];*/


class pantallaPreguntasExtendidas extends StatefulWidget {

  final String par_curso;
  final String par_paralelo;
  final String par_ent_cod;
  final int par_al_id;
  final String par_nombre_completo;


  const pantallaPreguntasExtendidas({Key? key,
    required this.par_ent_cod,
    required this.par_curso,
    required this.par_paralelo,
    required this.par_al_id,
    required this.par_nombre_completo,
  })
      : super(key: key);

  @override
  _pantallaPreguntasExtendidasState createState() =>
      _pantallaPreguntasExtendidasState();
}

class _pantallaPreguntasExtendidasState
    extends State<pantallaPreguntasExtendidas> {
  /*void _show() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Hi, I am a snack bar!"),
    ));
  }*/

  Future<bool> validar(codigoentidad, codigocurso, codigoparalelo,
      codigoalumno) async {
    List<Notas> listaaux = [];
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    listaaux = await handler.retrieveNotasAlumno(
        codigoentidad, codigocurso, codigoparalelo, currentDate,
        codigoalumno);
    //mapamarcaciones[alumno.al_id]="S";
    if (listaaux.length > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "La calificacion ya fue registrada"),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop();
    }
    else {
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
      calificaciones = {'0': -1.0, '1': -1.0, '2': -1.0, '3': -1.0};
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
          body: Column(children:<Widget>[
            Expanded(child:
             ListView(
              children: <Widget>[
                  Pregunta1(context),
                  Textoprevio(context),
                  Pregunta2_1(context),
                  Pregunta2_2(context),
                  Pregunta2_3(context),
                  Pregunta2_4(context),
                  Pregunta3(context),
                  Pregunta4(context),
              ]))
          ]
        //floatingActionButton: BotonOpcion("Grabar", "btn1", context),
        /*floatingActionButton: Builder(
            builder: (context) {
              return FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Existen valores sin calificación.  No se puede grabar"),
                      duration: Duration(seconds: 5),
                    ),
                  );
                },
              );
            }
        ),*/
      )),
    );
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
      builder: (context) =>
          FloatingActionButton(
              backgroundColor: texto == "Cancelar" ? Colors.red : Color(
                  0xff4e9603),
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
                  }
                  /* //se comenta por rediseño
                  else
                  { print ("a grabar");
                    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                    String tiempocompleto = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

                    Notas objeto = Notas(//nota_id: null,//nota_id:1,
                        ins_id:parametros['ins_id'].toString(),
                        al_ins_ciclo: parametros['al_ins_ciclo'].toString(),
                        al_ins_paralelo:parametros['al_ins_paralelo'].toString(),
                        al_id:int.parse(parametros['al_id'].toString()),
                        nota_fecha:currentDate,
                        nota_p1:calificaciones['0'].toString(),
                        nota_p2:calificaciones['1'].toString(),
                        nota_p3:calificaciones['2'].toString(),
                        nota_p4:calificaciones['3'].toString(),
                        nota_p5:"0",nota_p6:"0",nota_p7:"0",nota_p8:"0",
                        nota_p9:"0",
                        //nota_p10:"0",
                        nota_p10:tiempocompleto,
                        nota_adc:"I"
                    );
                    handler.initializedDB().whenComplete(() async {
                       handler.insertNota(objeto);
                    });
                  ScaffoldMessenger.of(contexto).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Calificación guardada"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(contexto).pop();
                  };*/
                }
              }

          )
  );
}

//nota_id:
/*
              al_ins_ciclo
              al_ins_paralelo
              al_id =
              nota_fecha =
              nota_p1 =
              nota_p2 =
              nota_p3 =
              nota_p4 =
              nota_p5 =
              nota_p6 =
              nota_p7 =
              nota_p8 =
              nota_p9 =
              nota_p10 =
              nota_adc =
                    */

Widget Pregunta1(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder( //<-- 1. SEE HERE
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
          text: "\nPregunta 1. ¿Te sientes cómodo pidiendo ayuda a los practicantes?",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 3,
            radiusStyle: true,
            cornerRadius: 20.0,
            minWidth: MediaQuery
                .of(context)
                .size
                .width / 4,
            activeBgColors: [
              [Colors.red],
              [Colors.yellow],
              [Colors.lightGreenAccent],
            ],
            multiLineText: true,
            customTextStyles: [
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,)
            ],
            labels: ['Nunca', 'A veces', 'Siempre'],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
        ],
      ),
    ),
  );
}
Widget Textoprevio(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder( //<-- 1. SEE HERE
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
          text: "\nPregunta 2. En una escala del 1 al 10, donde 1 representa ninguna ayuda y 10 representa ayuda excepcional, ¿Cómo calificarías la ayuda que has recibido de los practicantes en los siguientes aspectos?\n",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    ),
  );
}
Widget Pregunta2_1(BuildContext context) {
  var minimo = MediaQuery
      .of(context)
      .size
      .width / 14;
  return Card(
    shape: RoundedRectangleBorder( //<-- 1. SEE HERE
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
          text: "\nPregunta 2.1. Apoyo con los estudiantes con necesidades educativas específicas asociadas o no a la discapacidad",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 10,
            radiusStyle: true,
            cornerRadius: 10.0,
            minWidth: minimo,
            /*activeBgColors: [
              [Colors.red],
              [Colors.yellow],
              [Colors.lightGreenAccent],
            ],*/
            activeBgColor: [Colors.lightGreenAccent],
            activeFgColor: Colors.white,
            multiLineText: true,
            customWidths: [minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo*2],
            customTextStyles: [
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
            ],
            labels: ['1', '2', '3','4', '5', '6','7', '8', '9','10'],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
        ],
      ),
    ),
  );
}
Widget Pregunta2_2(BuildContext context) {
  var minimo = MediaQuery
      .of(context)
      .size
      .width / 14;
  return Card(
    shape: RoundedRectangleBorder( //<-- 1. SEE HERE
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
          text: "\nPregunta 2.2. Retroalimentación a los estudiantes",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 10,
            radiusStyle: true,
            cornerRadius: 10.0,
            minWidth: minimo,
            /*activeBgColors: [
              [Colors.red],
              [Colors.yellow],
              [Colors.lightGreenAccent],
            ],*/
            activeBgColor: [Colors.lightGreenAccent],
            activeFgColor: Colors.white,
            multiLineText: true,
            customWidths: [minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo*2],
            customTextStyles: [
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
            ],
            labels: ['1', '2', '3','4', '5', '6','7', '8', '9','10'],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
        ],
      ),
    ),
  );
}
Widget Pregunta2_3(BuildContext context) {
  var minimo = MediaQuery
      .of(context)
      .size
      .width / 14;
  return Card(
    shape: RoundedRectangleBorder( //<-- 1. SEE HERE
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
          text: "\nPregunta 2.3. Acompañamiento durante el recreo",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 10,
            radiusStyle: true,
            cornerRadius: 10.0,
            minWidth: minimo,
            /*activeBgColors: [
              [Colors.red],
              [Colors.yellow],
              [Colors.lightGreenAccent],
            ],*/
            activeBgColor: [Colors.lightGreenAccent],
            activeFgColor: Colors.white,
            multiLineText: true,
            customWidths: [minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo*2],
            customTextStyles: [
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
            ],
            labels: ['1', '2', '3','4', '5', '6','7', '8', '9','10'],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
        ],
      ),
    ),
  );
}
Widget Pregunta2_4(BuildContext context) {
  var minimo = MediaQuery
      .of(context)
      .size
      .width / 14;
  return Card(
    shape: RoundedRectangleBorder( //<-- 1. SEE HERE
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
          text: "\nPregunta 2.4. Revisión de tareas",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 10,
            radiusStyle: true,
            cornerRadius: 10.0,
            minWidth: minimo,
            /*activeBgColors: [
              [Colors.red],
              [Colors.yellow],
              [Colors.lightGreenAccent],
            ],*/
            activeBgColor: [Colors.lightGreenAccent],
            activeFgColor: Colors.white,
            multiLineText: true,
            customWidths: [minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo,minimo*2],
            customTextStyles: [
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
              TextStyle(fontSize: 14.0, color: Colors.black,),
            ],
            labels: ['1', '2', '3','4', '5', '6','7', '8', '9','10'],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
        ],
      ),
    ),
  );
}
Widget Pregunta3(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder( //<-- 1. SEE HERE
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
          text: "\nPregunta 3. ¿Te sientes satisfecho con la ayuda que recibes de los practicantes?",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          ToggleSwitch(
            isVertical: true,
            initialLabelIndex: 0,
            totalSwitches: 5,
            radiusStyle: true,
            cornerRadius: 20.0,
            //inactiveBgColor: Colors.white,
            //borderColor: [Colors.blueGrey, Colors.blueGrey, Colors.blueGrey, Colors.blueGrey, Colors.blueGrey, Colors.blueGrey],
            //dividerColor: Colors.blueGrey,
            minWidth: MediaQuery
                .of(context)
                .size
                .width / 2,

            activeBgColors: [
              [Colors.red],
              [Colors.orange],
              [Colors.yellow],
              [Colors.lightGreenAccent],
              [Colors.green],
            ],
            multiLineText: true,
            customTextStyles: [
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,)
            ],
            labels: ['Muy insatisfecho', 'Insatisfecho', 'Neutral', 'Satisfecho', 'Muy satisfecho',],
              onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
        ],
      ),
    ),
  );
}


Widget Pregunta4(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder( //<-- 1. SEE HERE
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
          text: "\nPregunta 4. ¿Cómo te sientes con la presencia y acompañamiento de los estudiantes UNAE?",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
          ToggleSwitch(
            isVertical: true,
            initialLabelIndex: 0,
            totalSwitches: 4,
            radiusStyle: true,
            cornerRadius: 20.0,
            //inactiveBgColor: Colors.white,
            //borderColor: [Colors.blueGrey, Colors.blueGrey, Colors.blueGrey, Colors.blueGrey, Colors.blueGrey, Colors.blueGrey],
            //dividerColor: Colors.blueGrey,
            minWidth: MediaQuery
                .of(context)
                .size
                .width / 2,

            activeBgColors: [
              [Colors.red],
              [Colors.orange],
              [Colors.yellow],
              [Colors.lightGreenAccent],
              [Colors.green],
            ],
            multiLineText: true,
            customTextStyles: [
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,),
              TextStyle(fontSize: 16.0, color: Colors.black,),

            ],
            labels: ['Felicidad', 'Tristeza', 'Indiferencia', 'Miedo', ],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(
            height: 20, // <-- SEE HERE
          ),
        ],
      ),
    ),
  );
}