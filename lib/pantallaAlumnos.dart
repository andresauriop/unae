import 'package:flutter/material.dart';
import 'package:unae/alumnos.dart';
import 'database.dart';
import 'instituciones.dart';
import 'preguntas.dart';

late DataBase handler = DataBase();
List<String> titles = ["Ninguno"];
List<Alumnos> listaalumnos = [];

List subtitles = [
  "Here is list 1 subtitle",
  "Here is list 2 subtitle",
  "Here is list 3 subtitle"
];
List icons = [
  Icons.sentiment_neutral_rounded,
  Icons.sentiment_neutral_rounded,
  Icons.done_outline_sharp
];

class pantallaAlumnos extends StatefulWidget {
  @override
  _pantallaAlumnosState createState() => _pantallaAlumnosState();
}

class _pantallaAlumnosState extends State<pantallaAlumnos> {
  //Cargar desde la base de datos

  Future cargarAlumnos(codigoentidad) async {
    handler.initializedDB().whenComplete(() async {
      listaalumnos = await handler.retrieveAlumnosAula(codigoentidad
      );
      for (final e in listaalumnos) {
        titles.add(e.al_apellidos);
      };
    });
    return titles;
  }

  llamacargarAlumnos(codigoentidad) async {
    return await cargarAlumnos(codigoentidad);
  }



  @override
  void initState() {
    super.initState();

    setState(() {llamacargarAlumnos("CAT");});
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista alumnos'),
          backgroundColor: const Color(0xff1D4554),
        ),
        body: Builder(
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
        ),
        floatingActionButton: BotonOpcion("Cancelar", "btn1", context),
      ),
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
