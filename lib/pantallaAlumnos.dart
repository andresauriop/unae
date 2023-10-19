import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unae/alumnocalificado.dart';
import 'package:unae/alumnos.dart';
import 'package:unae/preguntasextendidas.dart';
import 'package:unae/preguntasextendidasfinal.dart';
import 'package:unae/preguntasextendidasninos.dart';
import 'database.dart';
import 'instituciones.dart';
import 'preguntas.dart';
import 'preguntasalter.dart';
import 'notas.dart';
late DataBase handler = DataBase();
List<String> titles = [];
List<Alumnos> listaalumnos = [];
List<Map> listaalumnos2 = [];
List subtitles = [
  "Here is list 1 subtitle",
  "Here is list 2 subtitle",
  "Here is list 3 subtitle"
];
/*List icons = [
  Icons.sentiment_neutral_rounded,
  Icons.sentiment_neutral_rounded,
  Icons.done_outline_sharp
];*/

List icons = [];
var mapamarcaciones = {'-1': "null"};

class pantallaAlumnos extends StatefulWidget {
  final String par_entidad;
  final String par_curso;
  final String par_paralelo;
  final String par_ent_cod;

  const pantallaAlumnos(
      {Key? key,
      required this.par_entidad,
      required this.par_ent_cod,
      required this.par_curso,
      required this.par_paralelo})
      : super(key: key);

  @override
  _pantallaAlumnosState createState() => _pantallaAlumnosState();
}

class _pantallaAlumnosState extends State<pantallaAlumnos> {
  //Cargar desde la base de datos

  Future<List<AlumnosCalificados>> loadListaAlumnos(codigoentidad,codigocurso,codigoparalelo) async {
    List<AlumnosCalificados> datosAlumnos = [];
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    handler.initializedDB().whenComplete(() async {
      listaalumnos2 = await handler.getAlumnoNotaDia(codigoentidad,codigocurso,codigoparalelo,currentDate);
      for (var instanciamapa in listaalumnos2) {
        AlumnosCalificados alumno = new AlumnosCalificados(al_id: instanciamapa["al_id"], al_apellidos: instanciamapa["al_apellidos"], al_nombres: instanciamapa["al_nombres"], ins_id: instanciamapa["ins_id"], al_ins_ciclo: instanciamapa["al_ins_ciclo"], al_ins_paralelo: instanciamapa["al_ins_paralelo"],nota_fecha: instanciamapa["nota_fecha"].toString());
        datosAlumnos.add(alumno);
      }
    });
    await Future.delayed(Duration(seconds: 1));
    return Future.value(datosAlumnos);
    //return datosAlumnos;
  }




  /*Future<List<Alumnos>> cargaconvalidacion(codigoentidad,codigocurso,codigoparalelo) async {
  {
    List<Alumnos> datosAlumnos = await loadListaAlumnos(codigoentidad,codigocurso,codigoparalelo);
    print(datosAlumnos);
    await validar(codigoentidad,codigocurso,codigoparalelo,datosAlumnos);
    return datosAlumnos;
  }}*/


  /*
  Future<List<Alumnos>> loadListaAlumnosOriginal(codigoentidad,codigocurso,codigoparalelo) async {
    List<Alumnos> datosAlumnos = [];
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("Ingresa");
    handler.initializedDB().whenComplete(() async {
      listaalumnos = await handler.retrieveAlumnosAula(codigoentidad,codigocurso,codigoparalelo);
      for (var alumno in listaalumnos) {
        datosAlumnos.add(alumno);
        List<Notas> listaaux = [];
        listaaux = await handler.retrieveNotasAlumno(
            codigoentidad, codigocurso, codigoparalelo, currentDate,
            alumno.al_id);
        //mapamarcaciones[alumno.al_id]="S";
        mapamarcaciones["hola"]="S";
      }
    });


    for (var alumno in listaalumnos) {
      //verifica si ya se marco
      List<Notas> listaaux = [];
      listaaux = await handler.retrieveNotasAlumno(
          codigoentidad, codigocurso, codigoparalelo, currentDate,
          alumno.al_id);
      print("respuesta notas " + listaaux.toString());
      //print(currentDate);
      print(codigoentidad  + " "+ codigocurso+ " "+codigoparalelo+ " "+currentDate+ " "+alumno.al_id.toString());
      if (listaaux.length > 0) {
        mapamarcaciones[alumno.al_id.toString()] = "S";
      }
      else {
        mapamarcaciones[alumno.al_id.toString()] = "N";
      }
    }
    return datosAlumnos;

  }
*/

  @override
  void initState() {
    super.initState();
    //print(widget.par_entidad);

    setState(() {
      //llamacargarAlumnos(widget.par_ent_cod);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista alumnos'),
          backgroundColor: Colors.blueAccent,//const Color(0xff1D4554),
        ),

        body: FutureBuilder<List>(
            //future: llamacargarAlumnos(widget.par_ent_cod),
            future: //loadListaAlumnos(widget.par_ent_cod,widget.par_curso,widget.par_paralelo),
            loadListaAlumnos(widget.par_ent_cod,widget.par_curso,widget.par_paralelo),
            //initialData: List(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? new ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        //return Text(snapshot.data?[index] ?? "got null");
                        double screenWidth = MediaQuery.of(context).size.width;
                        child:
                        return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                          onTap: () {

                            setState(()  {
                             if (snapshot.data?[index].nota_fecha == "null")
                             {
                                String completo = snapshot.data?[index]
                                    .al_nombres + " " +
                                    snapshot.data?[index].al_apellidos ?? " ";
                                if (int.parse(widget.par_curso) > 3) { //mayor a tercero
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            //pantallaPreguntasExtendidas(
                                        pantallaPreguntasExtendidasFinal(
                                                par_ent_cod: widget.par_ent_cod,
                                                par_curso: widget.par_curso,
                                                par_paralelo: widget
                                                    .par_paralelo,
                                                par_al_id: snapshot.data?[index]
                                                    .al_id ?? 0,
                                                par_nombre_completo: completo)),
                                  ).then((value) => setState(() {}));
                                }
                                else
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            pantallaPreguntasExtendidasNinos(
                                                par_ent_cod: widget.par_ent_cod,
                                                par_curso: widget.par_curso,
                                                par_paralelo: widget
                                                    .par_paralelo,
                                                par_al_id: snapshot.data?[index]
                                                    .al_id ?? 0,
                                                par_nombre_completo: completo)),
                                  ).then((value) => setState(() {}));
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                    Text('Presionado ' + index.toString()),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                    Text('La calificación ya está registrada'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              //}
                            }});
                          },
                          title: //Text(snapshot.data?[index] ?? "Null"),
                              RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                      text: snapshot.data?[index].al_apellidos + " " +
                                            snapshot.data?[index].al_nombres ?? " ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                      /*children: [
                                        TextSpan(
                                          text: 'Sign Up !',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        )
                                      ]*/)),
                          trailing: Icon(snapshot.data?[index].nota_fecha != "null"?Icons.verified_user_rounded :Icons.dangerous,
                              color: snapshot.data?[index].nota_fecha != "null"?Colors.green:Colors.red,
                              size: 30.0),


                              leading: CircleAvatar(
                                  backgroundImage: //NetworkImage(
                                      //"https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                                        AssetImage("assets/images/person.png"),
                        ))
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
        floatingActionButton: BotonOpcion("Cancelar", "btn1", context),
      ),
    );
  }

  Widget _buildRow(String texto) {
    return new ListTile(
      title: new Text(texto),
    );
  }
}

Widget BotonOpcion(String texto, String etiqueta, BuildContext contexto) {
  return FloatingActionButton.large(
    backgroundColor: texto == "Cancelar" ? Colors.red : Color(0xff4e9603),
    heroTag: etiqueta,
    child: FittedBox(child: Text(texto)),
    onPressed: () {
      if (texto == "Cancelar") {
        Navigator.of(contexto).pop();
      }
    },
  );
}


class EnterExitRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  EnterExitRoute({required this.exitPage, required this.enterPage})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    enterPage,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        Stack(
          children: <Widget>[
            SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(animation),
              child: exitPage,
            ),
            SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: enterPage,
            )
          ],
        ),
  );
}
