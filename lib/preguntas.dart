import 'package:flutter/material.dart';
import 'database.dart';
import 'instituciones.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    double? _ratingValue;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Preguntas'),
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
                  double screenWidth = MediaQuery.of(context).size.width;
                  return Container(
                    //height: screenWidth / 3,
                    child: Card(
                      child: ListTile(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          pantallaPreguntas()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Presionado ' + index.toString()),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            });
                          },
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
                              style: DefaultTextStyle.of(context).style,
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
  return FloatingActionButton(
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
