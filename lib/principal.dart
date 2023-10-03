import 'package:flutter/material.dart';
import 'package:unae/recuperardatos.dart';
import 'package:unae/institucionestest.dart';
import 'package:unae/parametros_calificacion.dart';
import 'package:unae/enviarnotas.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
//flutter build apk  -t .\lib\principal.dart


void main() async {
  /*SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.green,
  ));*/
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();

  runApp(SampleCenterButton());
}

class SampleCenterButton extends StatelessWidget {
  //const SampleCenterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(builder: (context1) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _myScreenOptions(context1),
                _playButton(context),
              ],
            ),
          );
        }),
      ),
    );
  }

  _playButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Container(
          // defining one dimension works as well, as Flutter knows how to render a circle.
//        width: MediaQuery.of(context).size.width/2,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "PLAY",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  _myScreenOptions(BuildContext context) {
    return Column(
      children: <Widget>[
        buildRow([
          buildOption(Color(0xff1D4554), Icons.person, "Calificar", context),
          buildOption(
              Color(0xff229B8D), Icons.folder_open, "Enviar notas", context),
        ]),
        buildRow([
          buildOption(
              Color(0xffE7C16A), Icons.videogame_asset, "Sincronizar", context),
          buildOption(Color(0xffF2A061), Icons.settings, "Options", context),
        ]),
      ],
    );
  }

  Widget buildOption(Color bgColor, IconData iconData, String title,
      BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          acciones(title, context);
        },
        child: Container(
          color: bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                color: Colors.white,
                iconData,

                size: 80,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 30, color: Colors.white,),
              ),
            ],
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
    if (titulo == "Sincronizar") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RecuperarDatos()),
      );
    }

    if (titulo == "Calificar") {
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) =>  IngresoParametros()),
        MaterialPageRoute(builder: (context) => Parametros()),
      );
    }

    if (titulo == "Enviar notas") {
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) =>  IngresoParametros()),
        MaterialPageRoute(builder: (context) => pantallaNotas()),
      ).then((value) {});
    };
  }


}
