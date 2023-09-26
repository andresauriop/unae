import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unae/alumnos.dart';
import 'database.dart';
import 'instituciones.dart';
import 'preguntas.dart';
import 'notas.dart';
late DataBase handler = DataBase();
List<String> titles = [];
List<Alumnos> listaalumnos = [];

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

  /*Future cargarAlumnos(codigoentidad) async {
    handler.initializedDB().whenComplete(() async {
      listaalumnos = await handler.retrieveAlumnosAula(codigoentidad);

      for (final e in listaalumnos) {
        titles.add(e.al_apellidos );
        icons.add(Icons.done_outline_sharp);
      }
      ;
    });
    return titles;
  }*/

  /*Future<List<String>> loadAlumnos(codigoentidad) async {
    List<String> data = [];
    handler.initializedDB().whenComplete(() async {
      listaalumnos = await handler.retrieveAlumnosAula(codigoentidad);

      for (var alumno in listaalumnos) {
        data.add(alumno.al_apellidos + " " + alumno.al_nombres);
        print("nombre " + alumno.al_apellidos);
      }
    });
    //await Future.delayed(const Duration(seconds: 2), () {});
    return data;
  }*/

  Future<List<Alumnos>> loadListaAlumnos(codigoentidad,codigocurso,codigoparalelo) async {
    List<Alumnos> datosAlumnos = [];
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    handler.initializedDB().whenComplete(() async {
      listaalumnos = await handler.retrieveAlumnosAula(codigoentidad,codigocurso,codigoparalelo);
      for (var alumno in listaalumnos) {
        datosAlumnos.add(alumno);
        List<Notas> listaaux = [];
        listaaux = await handler.retrieveNotasAlumno(
            codigoentidad, codigocurso, codigoparalelo, currentDate,
            alumno.al_id);
        //mapamarcaciones[alumno.al_id]="S";
            if (listaaux.length > 0) {
              mapamarcaciones[alumno.al_id.toString()] = "S";
            }
            else {
              mapamarcaciones[alumno.al_id.toString()] = "N";
            }
      }
    });
    print(mapamarcaciones.toString());
    return datosAlumnos;

  }

  Future<List<Notas>> verificarnota(institucion,curso,paralelo,fecha,alumno) async {
    List<Notas> datosNotas = [];
    handler.initializedDB().whenComplete(() async {
      List<Notas> listanotas = await handler.retrieveNotasAlumno(institucion,curso,paralelo,fecha,alumno);
      for (var nota in listanotas) {
        datosNotas.add(nota);
      }
    });
    return datosNotas;
  }
  /*llamacargarAlumnos(codigoentidad) async {
    return await cargarAlumnos(codigoentidad);
  }*/

  @override
  void initState() {
    super.initState();
    /*print(widget.par_entidad);
    print(widget.par_curso);
    print(widget.par_paralelo);*/

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
          backgroundColor: const Color(0xff1D4554),
        ),

        body: FutureBuilder<List>(
            //future: llamacargarAlumnos(widget.par_ent_cod),
            future: loadListaAlumnos(widget.par_ent_cod,widget.par_curso,widget.par_paralelo),
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
                            child: ListTile(
                          onTap: () {

                            setState(()  {
                               //if (listaaux.length>0) {
                                print("mapa " + mapamarcaciones.toString());

                                String completo = snapshot.data?[index]
                                    .al_apellidos + " " +
                                    snapshot.data?[index].al_nombres ?? " ";
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          pantallaPreguntas(
                                              par_ent_cod: widget.par_ent_cod,
                                              par_curso: widget.par_curso,
                                              par_paralelo: widget.par_paralelo,
                                              par_al_id: snapshot.data?[index]
                                                  .al_id ?? 0,
                                              par_nombre_completo: completo)),
                                ).then((value) => setState(() {}));

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                    Text('Presionado ' + index.toString()),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              /*}
                              else
                              { */
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                    Text('La marcación ya está registrada'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              //}
                            });
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
                          trailing: Icon(Icons.done_outline_sharp),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                        ));
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
