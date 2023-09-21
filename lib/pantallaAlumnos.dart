import 'package:flutter/material.dart';
import 'database.dart';
import 'instituciones.dart';

List<String> titles = ["Juan Perez", "Jose Prieto", "Luisa Lima"];
List subtitles = [
  "Here is list 1 subtitle",
  "Here is list 2 subtitle",
  "Here is list 3 subtitle"
];
List icons = [Icons.sentiment_neutral_rounded , Icons.sentiment_neutral_rounded , Icons.done_outline_sharp  ];

class pantallaAlumnos extends StatefulWidget {
  @override
  _pantallaAlumnosState createState() => _pantallaAlumnosState();
}
class _pantallaAlumnosState extends State<pantallaAlumnos> {

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
        title: const Text('Lista alumnos'),
    backgroundColor: const Color(0xff1D4554),
    ),
    body: Builder(builder: (context1) {
      return ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card(
                child: ListTile(
                    onTap: () {
                      setState(() {
                        /*titles.add('List' + (titles.length + 1).toString());
                        subtitles.add(
                            'Here is list' + (titles.length + 1).toString() +
                                ' subtitle');*/
                        //icons.add(Icons.zoom_out_sharp);
                      });

                      /*Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(titles[index] + ' pressed!'),
                    ));*/

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'BEIM LADEN DER POST-DATEN IST EIN FEHLER AUFGETRETEN!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    title: Text(titles[index]),
                    //subtitle: Text(subtitles[index]),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                    trailing: Icon(icons[index])));
          });
    }
    ),
    ),
    );
    }
}


