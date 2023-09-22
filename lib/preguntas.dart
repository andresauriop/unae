import 'package:flutter/material.dart';
import 'database.dart';
import 'instituciones.dart';

List<String> titles = ["Juan Perez", "Jose Prieto", "Luisa Lima"];
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

class pantallaPreguntas extends StatefulWidget {
  @override
  _pantallaPreguntasState createState() => _pantallaPreguntasState();
}

class _pantallaPreguntasState extends State<pantallaPreguntas> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Preguntas'),
          backgroundColor: const Color(0xff1D4554),
        ),
        body: Builder(
          builder: (BuildContext context1) {
            return ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  double screenWidth = MediaQuery.of(context).size.width;
                  return Container(
                    height: screenWidth / 3,
                    child: Card(child:
                      ListTile(

                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => pantallaPreguntas()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Presionado ' + index.toString()),
                                  duration: Duration(seconds: 2),),
                              );
                            });
                          },
                          title: Text(titles[index]),
                          //subtitle: Text(subtitles[index]),
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                          trailing: Icon(icons[index])),

                    ),
                  );
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
