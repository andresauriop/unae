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
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
];

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
      };
    });
    return list2;
  }

  llamacargarEntidades() async {
    return await cargarEntidades();
  }

  @override
  void initState() {
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
        body: Builder(builder: (context1) {
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
                    ListaFutura(),
                    SizedBox(
                      height: 20, // <-- SEE HERE
                    ),
                    Mensaje(texto: "Curso"),
                    ListaCursos(),
                    SizedBox(
                      height: 20, // <-- SEE HERE
                    ),
                    Mensaje(texto: "Paralelo"),
                    ListaParalelos(),
                    SizedBox(
                      height: 30, // <-- SEE HERE
                    ),
                    //Expanded(child: <Widget>[BotonOpcion(texto:"Consultar")]),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: BotonOpcion("Cancelar","btn1", context),

                        ),
                        Expanded(
                          child: BotonOpcion("Consultar","btn2",context),
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
}



class ListaEntidades extends StatefulWidget {
  const ListaEntidades({super.key});

  @override
  State<ListaEntidades> createState() => _ListaEntidadesState();
}

class _ListaEntidadesState extends State<ListaEntidades> {


  String valorEntidad = list2.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: valorEntidad,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(fontSize: 20, color: Color(0xff1D4554)),
      underline: Container(
        height: 2,
        color: Color(0xff1D4554),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          //valorEntidad = value!;
          valorEntidad = value!;
        });
      },
      items: list2.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),

    );
  }
}

class ListaCursos extends StatefulWidget {
  const ListaCursos({super.key});

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
        // This is called when the user selects an item.
        setState(() {
          valorCursos = value!;
        });
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

class ListaParalelos extends StatefulWidget {
  const ListaParalelos({super.key});

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
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          valorParalelos = value!;
        });
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
        style: DefaultTextStyle
            .of(context)
            .style,
        children: <TextSpan>[
          TextSpan(
            //text: 'Ingrese los valores del curso', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)),
            //text: 'Ingrese los datos del curso', style: TextStyle(fontSize:20)),
              text: this.texto,
              style: TextStyle(fontSize: 20, color: Colors.black)),
        ],
      ),
    );
  }
}


class ListaFutura extends StatefulWidget {
  const ListaFutura({super.key});

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
            style: const TextStyle(fontSize: 20, color: Color(0xff1D4554)),
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
              setState(() {
                dropDownValue = value ?? "";
                //print(value);
              });
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




/*
class BotonOpcion extends StatefulWidget {
  final String texto;
  final String etiqueta;
  final BuildContext contexto;
  //heroTag: "btn1",
  const BotonOpcion({
    required this.texto,required this.etiqueta,required this.contexto
  });

  @override*/

  Widget BotonOpcion(String texto, String etiqueta, BuildContext contexto) {
    return FloatingActionButton.large(
      backgroundColor: texto == "Cancelar"  ? Colors.red: Color(0xff4e9603),
      heroTag: etiqueta,
      child: FittedBox(
          child: Text(texto)
      ),
      onPressed: () {
        if (texto == "Cancelar")
          { Navigator.of(contexto).pop();
          }
        if (texto == "Consultar")
        { Navigator.push(
          contexto,
          MaterialPageRoute(builder: (context) =>  pantallaAlumnos()),
          );
        }

      },
      /*child: Icon(
        Icons.train,
        size: 35,
        color: Colors.black,
      ),*/

    );
  }
//}