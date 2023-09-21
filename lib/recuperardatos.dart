import 'package:flutter/material.dart';
import 'database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecuperarDatos extends StatelessWidget {

  const RecuperarDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Sincronizar'),backgroundColor:  Color(0xff1D4554),),
        body:
        Builder(
            builder: (context1) {
              return Container(color: Color(0xffffff),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  //alignment: Alignment.center,
                    children: <Widget>[
                      _opciones(context),
                    ]
                ),
              );
            }
        ),
      ),

    );

  }

  _opciones(BuildContext  context) {
    return Column(
      children: <Widget>[
        buildRow([
          buildOption(Color(0xffffff),
              "La operación eliminará los datos de las calificaciones.  No puede revertirse. \n¿Desea continuar?"),

        ]),
        buildRow([
          buildOption2(Colors.red, "No",context),
          buildOption2(Color(0xff4e9603), "Si",context),

        ]),
      ],
    );
  }


  Widget buildOption(Color bgColor, String title) {
    return Expanded(
      child: InkWell(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Container(
            // defining one dimension works as well, as Flutter knows how to render a circle.
//        width: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 30, color: Color(0xff1D4554)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOption2(Color bgColor, String title,BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          acciones(title, context);
        },
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            // defining one dimension works as well, as Flutter knows how to render a circle.
//        width: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildRow(List<Widget> buttons) {
    return Expanded(

      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buttons,

      ),
    );
  }

  acciones(String titulo, BuildContext context) {
    if (titulo == "No")
      {//print("cancelar");
      Navigator.of(context).pop();
      }
    if (titulo == "Si")
    {
      actualizartablas(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Tablas actualizadas'),
      ));
      Navigator.of(context).pop();
    }
  }

  actualizartablas(BuildContext context)
  { late DataBase handler; //late non-nullable variable will be initialized later
    handler = DataBase();
    handler.initializedDB().whenComplete(() async {
      await handler.deleteInstituciones();
      await handler.cargardatos();



    });
  }
}