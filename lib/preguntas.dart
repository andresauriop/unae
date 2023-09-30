import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unae/notas.dart';
import 'database.dart';
import 'instituciones.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'notas.dart';

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
var parametros = {'ins_id':'','al_ins_ciclo':'','al_ins_paralelo':'','al_id':0,
  'nota_fecha':'','nota_p1':'','nota_p2':'','nota_p3':'','nota_p4':'','nota_p5':'',
  'nota_p6':'','nota_p7':'','nota_p8':'','nota_p9':'','nota_p10':'','nota_adc':'',
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


class pantallaPreguntas extends StatefulWidget {

  final String par_curso;
  final String par_paralelo;
  final String par_ent_cod;
  final int par_al_id;
  final String par_nombre_completo;


  const pantallaPreguntas(
      {Key? key,
        required this.par_ent_cod,
        required this.par_curso,
        required this.par_paralelo,
        required this.par_al_id,
        required this.par_nombre_completo,
      })
      : super(key: key);

  @override
  _pantallaPreguntasState createState() => _pantallaPreguntasState();
}

class _pantallaPreguntasState extends State<pantallaPreguntas> {
  /*void _show() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Hi, I am a snack bar!"),
    ));
  }*/

  Future<bool> validar(codigoentidad,codigocurso,codigoparalelo,codigoalumno) async {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  Text(widget.par_nombre_completo),
          backgroundColor: const Color(0xff1D4554),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Builder(
          builder: (BuildContext context1) {
            return ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  double screenWidth = MediaQuery
                      .of(context)
                      .size
                      .width;
                  return Container(
                    //height: screenWidth / 3,
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: RichText(
                          // Controls visual overflow
                          overflow: TextOverflow.clip,

                          // Controls how the text should be aligned horizontally
                          textAlign: TextAlign.justify,

                          // Control the text direction
                          //textDirection: TextDirection.rtl,

                          // Whether the text should break at soft line breaks
                          softWrap: true,

                          // Maximum number of lines for the text to span
                          maxLines: 10,

                          // The number of font pixels for each logical pixel
                          textScaleFactor: 1.5,
                          text: TextSpan(
                            text: titles[index],
                            style: DefaultTextStyle
                                .of(context)
                                .style,
                            /*children: const <TextSpan>[
                                TextSpan(
                                    text: 'Geeks',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],*/
                          ),
                        ),

                        //Text(titles[index]),
                        subtitle: Column(
                          children: <Widget>[
                            Container(
                                child: Row(
                                  children: <Widget>[
                                    /*FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    heroTag: "Cancelar",
                                    child: FittedBox(child: Text("Cancelar")),
                                    onPressed: () {
                                    },
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    heroTag: "Cancelar",
                                    child: FittedBox(child: Text("Cancelar")),
                                    onPressed: () {
                                    },
                                  ),*/
                                    RatingBar(
                                        initialRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        ratingWidget: RatingWidget(
                                            full: const Icon(Icons.star,
                                                color: Colors.orange),
                                            half: const Icon(
                                              Icons.star_half,
                                              color: Colors.orange,
                                            ),
                                            empty: const Icon(
                                              Icons.star_outline,
                                              color: Colors.orange,
                                            )),
                                        onRatingUpdate: (value) {
                                          setState(() {
                                            _ratingValue = value;
                                            //calificaciones["'"+ index.toString() +"'"] = value.toString();
                                            calificaciones[index.toString()] =
                                                value.toDouble();
                                            print(calificaciones);
                                          });
                                        }),
                                    SizedBox(
                                      height: 30, // <-- SEE HERE
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        /*leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),*/
                        //trailing: Icon(icons[index])
                      ),

                    ),
                  );
                });
          },
        ),
        floatingActionButton: BotonOpcion("Grabar", "btn1", context),
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
      ),
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
      builder: (context) => FloatingActionButton(
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
                else
                  { print ("a grabar");
                    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

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
                        nota_p5:"0",
                        nota_p6:"0",nota_p7:"0",nota_p8:"0",
                        nota_p9:"0",nota_p10:"0",nota_adc:"A"
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
                  };
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
