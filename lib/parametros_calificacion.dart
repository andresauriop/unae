import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownButton].

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
const List<String> listcursos = <String>['1','2','3','4','5','6','7','8','9','10',];

void main() => runApp(const Parametros());

class Parametros extends StatelessWidget {
  const Parametros({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ingreso de parametros')),
        body: const Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50, // <-- SEE HERE
                ),
                Mensaje(texto: "Ingrese los valores de consulta"),
                SizedBox(
                  height: 20, // <-- SEE HERE
                ),
                Mensaje(texto: "Entidad"),
                ListaEntidades(),
                SizedBox(
                  height: 20, // <-- SEE HERE
                ),
                Mensaje(texto: "Curso"),
                ListaCursos(),
                SizedBox(
                  height: 20, // <-- SEE HERE
                ),
                Mensaje(texto: "Paralelo"),
                ListaEntidades(),
              ],
            )

        ),
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
  String valorEntidad = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: valorEntidad,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(fontSize:20,color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          valorEntidad = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
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
      style: const TextStyle(fontSize:20,color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
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


class Mensaje extends StatelessWidget {
  final String texto;
  const Mensaje({
  required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaleFactor: 1,
      text: TextSpan(
        text: '',
        style: DefaultTextStyle
            .of(context)
            .style,
        children: <TextSpan>[
          TextSpan(
              //text: 'Ingrese los valores del curso', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)),
              //text: 'Ingrese los datos del curso', style: TextStyle(fontSize:20)),
              text: this.texto, style: TextStyle(fontSize:20)),
        ],
      ),
    );
  }
}
