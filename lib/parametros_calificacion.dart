import 'package:flutter/material.dart';
import 'database.dart';
import 'instituciones.dart';
import 'pantallaAlumnos.dart';

List<String> list = ['One', 'Two', 'Three', 'Four'];
List<String> list2 = ['Ninguno'];
var mapa = new Map();

List<Instituciones> listainst = [];
late DataBase handler = DataBase();

const List<String> listcursos = <String>[
  '',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
];
const List<String> listaparalelos = <String>[
  '',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
];

String entidadseleccionada = "";
String cursoseleccionado = "";
String paraleloseleccionado = "";
var mapainstituciones = {"XYZ": "XYZ"};

void main() => runApp(Parametros());

class Parametros extends StatefulWidget {
  @override
  _ParametrosState createState() => _ParametrosState();
}

class _ParametrosState extends State<Parametros> {
  Future cargarEntidades() async {
    handler.initializedDB().whenComplete(() async {
      listainst = await handler.retrieveInstitucionesCombo();
      for (final e in listainst) {
        list2.add(e.ins_nombre);
        mapainstituciones[e.ins_nombre] = e.ins_id;
      }
      ;
      print(mapainstituciones);
    });
    return list2;
  }

  llamacargarEntidades() async {
    return await cargarEntidades();
  }

  @override
  void initState() {
    mapainstituciones.clear();
    llamacargarEntidades();
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ingreso de parametros'),
          backgroundColor: const Color(0xff1D4554),
        ),
        body: Builder(builder: (contextolocal) {
          return Container(
            color: const Color(0xffffffff),
            child: Center(
                child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50, // <-- SEE HERE
                ),
                Mensaje(texto: "Ingrese los valores de consulta"),
                SizedBox(
                  height: 20, // <-- SEE HERE
                ),
                Mensaje(texto: "Entidad"),
                //ListaEntidades(),
                ListaFutura(
                  onChanged: (String value) {
                    setState(() {
                      entidadseleccionada = value;
                      //print(entidadseleccionada);
                    });
                  },
                ),

                SizedBox(
                  height: 20, // <-- SEE HERE
                ),
                Mensaje(texto: "Curso"),
                ListaCursos(
                  onChanged: (String value) {
                    setState(() {
                      cursoseleccionado = value;
                    });
                  },
                ),

                SizedBox(
                  height: 20, // <-- SEE HERE
                ),
                Mensaje(texto: "Paralelo"),
                ListaParalelos(
                  onChanged: (String value) {
                    setState(() {
                      paraleloseleccionado = value;
                    });
                  },
                ),
                SizedBox(
                  height: 30, // <-- SEE HERE
                ),
                //Expanded(child: <Widget>[BotonOpcion(texto:"Consultar")]),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: BotonOpcion2("Cancelar", "btn1", context,contextolocal),
                    ),
                    Expanded(
                      child: BotonOpcion2("Consultar", "btn2", context,contextolocal),
                    ),
                  ],
                )
              ],
            )),
          );
        }),
      ),
    );
  }

  Widget BotonOpcion2(String texto, String etiqueta, BuildContext contexto,BuildContext contextolocal) {
    //, String cursoactual,String paraleloactual) {
    return FloatingActionButton.large(
      backgroundColor: texto == "Cancelar" ? Colors.red : Color(0xff4e9603),
      heroTag: etiqueta,
      child: FittedBox(child: Text(texto)),
      onPressed: () {
        if (texto == "Cancelar") {
          Navigator.of(contexto).pop();
        }
        if (texto == "Consultar") {
          /*print(entidadseleccionada);
          print(cursoseleccionado);
          print(paraleloseleccionado);*/
          //print(mapainstituciones[entidadseleccionada]);

          if (cursoseleccionado == "" || paraleloseleccionado == "") {
            print("Error");
            ScaffoldMessenger.of(contextolocal).showSnackBar(
              SnackBar(
                content: Text("Debe ingresar el curso y paralelo"),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            Navigator.push(
              contexto,
              MaterialPageRoute(
                  builder: (context) => pantallaAlumnos(
                        par_entidad: entidadseleccionada,
                        par_ent_cod:
                            mapainstituciones[entidadseleccionada] ?? "",
                        par_curso: cursoseleccionado,
                        par_paralelo: paraleloseleccionado,
                      )),
            );
          }
        }
      },
      /*child: Icon(
        Icons.train,
        size: 35,
        color: Colors.black,
      ),*/
    );
  }
}

//**************************************
// Lista cursos
//***************************************
class ListaCursos extends StatefulWidget {
  final Function onChanged;

  const ListaCursos({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<ListaCursos> createState() => _ListaCursos();
}

class _ListaCursos extends State<ListaCursos> {
  String valorCursos = listcursos.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: valorCursos,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(fontSize: 20, color: Color(0xff1D4554)),
      underline: Container(
        height: 2,
        color: Color(0xff1D4554),
      ),
      onChanged: (String? value) {
        setState(() => valorCursos = value ?? "");
        // 2. Call your callback passing the selected value
        widget.onChanged(value);
      },
      items: listcursos.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
//********************************
// Paralelos
//********************************

class ListaParalelos extends StatefulWidget {
  final Function onChanged;

  const ListaParalelos({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<ListaParalelos> createState() => _ListaParalelos();
}

class _ListaParalelos extends State<ListaParalelos> {
  String valorParalelos = listaparalelos.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: valorParalelos,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(fontSize: 20, color: Color(0xff1D4554)),
      underline: Container(
        height: 2,
        color: const Color(0xff1D4554),
      ),
      /*onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          valorParalelos = value!;
        });
      },*/

      onChanged: (String? value) {
        setState(() => valorParalelos = value ?? "");
        // 2. Call your callback passing the selected value
        widget.onChanged(value);
      },
      items: listaparalelos.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
//********************************

class Mensaje extends StatelessWidget {
  final String texto;

  const Mensaje({
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaleFactor: 1,
      selectionColor: const Color(0xaff30858),
      text: TextSpan(
        text: '',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: this.texto,
              style: TextStyle(fontSize: 20, color: Colors.black)),
        ],
      ),
    );
  }
}
//********************************
// Lista entidades
//********************************

class ListaFutura extends StatefulWidget {
  final Function onChanged;

  const ListaFutura({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<ListaFutura> createState() => _ListaFutura();
}

class _ListaFutura extends State<ListaFutura> {
  String dropDownValue = "";

  Future<List<Instituciones>> cargarEntidades2() async {
    List<Instituciones> listainstituciones = [];
    await handler.initializedDB().whenComplete(() async {
      listainstituciones = await handler.retrieveInstituciones();
    });
    /*for (final e in listainstituciones) {
      print(e.ins_nombre);
    }*/
    return Future.value(listainstituciones);
  }

  llamacargarEntidades2() async {
    return await cargarEntidades2();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cargarEntidades2(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Container(
                child: DropdownButton<String>(
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xff1D4554)),
                  underline: Container(
                    height: 2,
                    color: Color(0xff1D4554),
                  ),
                  hint: Text(dropDownValue ?? 'Seleccionar'),
                  items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.ins_nombre,
                      child: Text(item.ins_nombre),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => dropDownValue = value ?? "");
                    // 2. Call your callback passing the selected value
                    widget.onChanged(value);
                  },
                ),
              )
            : Container(
                child: const Center(
                  child: Text('Cargando...'),
                ),
              );
      },
    );
  }
}
