import 'package:flutter/material.dart';
import 'database.dart';
import 'notas.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

late DataBase handler = DataBase();
List<String> titles = [];
List<Notas> listanotas = [];
Future<List<Notas>> hope = [] as Future<List<Notas>>;

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

class pantallaNotas extends StatefulWidget {
  @override
  _pantallaNotasState createState() => _pantallaNotasState();
}

class _pantallaNotasState extends State<pantallaNotas> {
  @override
  void initState() {
    super.initState();
    //print(widget.par_entidad);
    setState(() {
      //loadListaNotas();
      //llamacargarAlumnos(widget.par_ent_cod);
    });
  }

  //Cargar desde la base de datos

  /*llamacargarnotas() async {
    return await loadListaNotas();
  }*/

  /*Future<List<Notas>> cargar(lista) async
  { List<Notas> datosNotas = [];
    for (var instanciamapa in lista) {
      datosNotas.add(instanciamapa);
    }
    return datosNotas;
  }*/

  pregrabacion() async {
    List<Notas> datosnotas = [];
    await loadListaNotasSinEspera();
    for(Notas elemento in listanotas)
      {
        grabarNotas(elemento.nota_id,
            elemento.ins_id,
            elemento.al_ins_ciclo,
            elemento.al_ins_paralelo,
            elemento.al_id,
            elemento.nota_fecha,
            elemento.nota_p1,elemento.nota_p2,
            elemento.nota_p3,elemento.nota_p4,
            elemento.nota_p5,elemento.nota_p6,
            elemento.nota_p7,elemento.nota_p8,
            elemento.nota_p9,elemento.nota_p10,
            elemento.nota_adc);

      }
      print("actualizado");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
          Text("Proceso finalizado"),
          duration: Duration(seconds: 2),
        ));
        Navigator.of(context).pop();

    //print("A grabar " + listanotas.toString());

  }

  Future<void> loadListaNotasSinEspera() async  {
    List<Notas> datosnotas = [];
    handler.initializedDB().whenComplete(() async {
      listanotas = await handler.retrieveNotasPendientes();
    });
    // Es void porque afecta a una variable global
    // No requiere espera porque no afecta interfaz
  }

  Future<List<Notas>> loadListaNotas() async  {
    List<Notas> datosnotas = [];
    handler.initializedDB().whenComplete(() async {
      listanotas = await handler.retrieveNotasPendientes();
      for (var instanciamapa in listanotas) {
        //Notas nota = new Notas(ins_id: instanciamapa["ins_id"], al_ins_ciclo: instanciamapa["al_ins_ciclo"], al_ins_paralelo: instanciamapa["al_ins_paralelo"], al_id: instanciamapa["al_id"], nota_fecha: instanciamapa["nota_fecha"], nota_p1: instanciamapa["nota_p1"], nota_p2: instanciamapa["nota_p2"], nota_p3: instanciamapa["nota_p3"], nota_p4: instanciamapa["nota_p4"], nota_p5: instanciamapa["nota_p5"], nota_p6: instanciamapa["nota_p6"], nota_p7: instanciamapa["nota_p7"], nota_p8: instanciamapa["nota_p8"], nota_p9: instanciamapa["nota_p9"], nota_p10: instanciamapa["nota_p10"], nota_adc: instanciamapa["nota_adc"]);
        datosnotas.add(instanciamapa);
      }
      //print(listanotas2);
    });
    await Future.delayed(Duration(seconds: 2));
    return Future.value(datosnotas);

  }

  Future<void> grabarNotas(nota_id,
      ins_id,
      al_ins_ciclo,
      al_ins_paralelo,
      al_id,
      nota_fecha,
      nota_p1,nota_p2,nota_p3,nota_p4,
      nota_p5,nota_p6,nota_p7,nota_p8,
      nota_p9,nota_p10,nota_adc) async {
    final url = Uri.parse(
        "http://panemia.uazuay.edu.ec:8090/pruebasmed/procedimientosnot/wsnot.php");
    http.Response response = await http.get(url);
    response = await http.post(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        /*body: jsonEncode({
          "title": titleController.text,
          "body": bodyController.text,
          "userId": 1,
        }));*/
        body: {
         "ins_id": ins_id,
          "al_ins_ciclo": al_ins_ciclo.toString(),
          "al_ins_paralelo": al_ins_paralelo,
          "al_id": al_id.toString(),
          "nota_fecha": nota_fecha,
          "nota_p1": nota_p1.toString(),
          "nota_p2": nota_p2.toString(),
          "nota_p3": nota_p3.toString(),
          "nota_p4": nota_p4.toString(),
          "nota_p5": nota_p5.toString(),
          "nota_p6": nota_p6.toString(),
          "nota_p7": nota_p7.toString(),
          "nota_p8": nota_p8.toString(),
          "nota_p9": nota_p9.toString(),
          "nota_p10": nota_p10.toString(),
          "nota_adc": nota_adc,
        });
        //print("Respuesta " + response.body);
        if (response.body=="res:1")
        {   handler.initializedDB().whenComplete(() async {
            await handler.updateNota(nota_id);
          });
        }

    /*if (response.statusCode == 201) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Post created successfully!"),
        ));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Failed to create post!"),
        ));
      }*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Notas '),
            backgroundColor: const Color(0xff1D4554),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),

          ),
          body: Column(children: [
            Expanded(
              child: FutureBuilder<List>(
                  //future: llamacargarAlumnos(widget.par_ent_cod),
                  future: loadListaNotas(),
                  //initialData: listanotas,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? new ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              //return Text(snapshot.data?[index] ?? "got null");
                              double screenWidth =
                                  MediaQuery.of(context).size.width;
                              child:
                              return Card(
                                  margin: const EdgeInsets.all(10),
                                  child: ListTile(

                                      //title: Text(snapshot.data?[index].ins_id ?? "Null"),//Text(snapshot.data?[index] ?? "Null"),
                                      title: RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(
                                            text: snapshot.data?[index].ins_id,
                                            /*+ " "+
                                      snapshot.data?[index].al_ins_ciclo.toString()  + " "+
                                      snapshot.data?[index].al_ins_paralelo  + " "+
                                      snapshot.data?[index].al_id.toString()  + " "+
                                      snapshot.data?[index].nota_fecha ?? " " ,*/
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          )),
                                      trailing: Icon(Icons.dangerous,
                                          color: Colors.red, size: 30.0),
                                      leading: CircleAvatar(
                                        backgroundImage: //NetworkImage(
                                            AssetImage(
                                                "assets/images/person.png"),
                                      )));
                            })
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
              //floatingActionButton: BotonOpcion("Cancelar", "btn1", context),
            ),
            Container(
              color: Color(0xffffff),
              //width: double.infinity,
              height: 90,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BotonOpcion("Consulta", "btn1", context,context),
                  ),
                  Expanded(
                    child: BotonOpcion("Grabar", "btn2", context,context),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20, // <-- SEE HERE
            ),
          ])),
    );
  }

  Widget BotonOpcion(String texto, String etiqueta, BuildContext contexto,BuildContext contextolocal) {
    //, String cursoactual,String paraleloactual) {
    return FloatingActionButton.large(
        backgroundColor: texto == "Consulta" ? Colors.red : Color(0xff4e9603),
        heroTag: etiqueta,
        child: FittedBox(child: Text(texto)),
        onPressed: () {
          if (texto == "Consulta") {
            //Navigator.of(contexto).pop();
            setState(() {

            });
          }
          if (texto == "Grabar") {
            pregrabacion();
          }
        }
    );}

}

/*Widget BotonOpcion(String texto, String etiqueta, BuildContext contexto) {
  return FloatingActionButton.large(
    backgroundColor: texto == "Cancelar" ? Colors.red : Color(0xff4e9603),
    heroTag: etiqueta,
    child: FittedBox(child: Text(texto)),
    onPressed: () {
      if (texto == "Cancelar") {
        Navigator.of(contexto).pop();
      }
    },
  );*/



