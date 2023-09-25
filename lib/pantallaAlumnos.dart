import 'package:flutter/material.dart';
import 'package:unae/alumnos.dart';
import 'database.dart';
import 'instituciones.dart';
import 'preguntas.dart';

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

class pantallaAlumnos extends StatefulWidget {
  final String par_entidad;
  final String par_curso;
  final String par_paralelo;
  final String par_ent_cod;

  const pantallaAlumnos({ Key? key, required this.par_entidad,
    required this.par_ent_cod,
    required this.par_curso, required this.par_paralelo}) : super(key: key);

  @override
  _pantallaAlumnosState createState() => _pantallaAlumnosState();
}

class _pantallaAlumnosState extends State<pantallaAlumnos> {
  //Cargar desde la base de datos

  Future cargarAlumnos(codigoentidad) async {
    handler.initializedDB().whenComplete(() async {
      listaalumnos = await handler.retrieveAlumnosAula(codigoentidad
      );
      print(listaalumnos);
      for (final e in listaalumnos) {
        titles.add(e.al_apellidos);
        icons.add(Icons.done_outline_sharp);
      };
    });
    return titles;
  }

  Future<List<String>> loadAlumnos(codigoentidad) async {
    List<String> data = [];
    handler.initializedDB().whenComplete(() async {
      listaalumnos = await handler.retrieveAlumnosAula(codigoentidad);


    for (var alumno in listaalumnos) {
      data.add(alumno.al_apellidos);
      print("nombre " + alumno.al_apellidos);
    }

    });
    //await Future.delayed(const Duration(seconds: 2), () {});
    return data;
  }

  /*llamacargarAlumnos(codigoentidad) async {
    return await cargarAlumnos(codigoentidad);
  }*/


  @override
  void initState() {
    super.initState();
    print(widget.par_entidad);
    print(widget.par_curso);
    print(widget.par_paralelo);

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
        /*body: Builder(
          builder: (BuildContext context1) {
            return ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  double screenWidth = MediaQuery.of(context).size.width;
                  return /*Container(
                      height: screenWidth / 3,
                      child:  */ Card(
                          child: ListTile(
                              onTap: () {
                                setState(() {
                                  /*titles.add('List' + (titles.length + 1).toString());
                        subtitles.add(
                            'Here is list' + (titles.length + 1).toString() +
                                ' subtitle');*/
                                  //icons.add(Icons.zoom_out_sharp);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              pantallaPreguntas()), ).then((value) => setState(() {}));

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Presionado ' + index.toString()),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                });
                              },
                              title: Text(titles[index]),
                              //subtitle: Text(subtitles[index]),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                              trailing: Icon(icons[index])));//);
                });
          },
        ),*/
        body: FutureBuilder<List>(
          //future: llamacargarAlumnos(widget.par_ent_cod),
          future: loadAlumnos(widget.par_ent_cod),
          //initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData ?
            new ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  //return Text(snapshot.data?[index] ?? "got null");
                  double screenWidth = MediaQuery
                      .of(context)
                      .size
                      .width;
                  child:
                  return
                    Card(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        pantallaPreguntas()), ).then((value) => setState(() {}));

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Presionado ' + index.toString()),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            });
                          },
                          title: Text(snapshot.data?[index] ?? "got null"),
                        )
                    );
                }
              //itemBuilder: (context, index) {
                //return _buildRow(snapshot.data?[i]?? "got null");
                //return Text(snapshot.data?[i]?? "got null");
                //return Text(snapshot.data?[index] ?? "got null");
            )

             : Center(
                child: CircularProgressIndicator(),
              );
          }
        ),

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
