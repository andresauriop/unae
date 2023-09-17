import 'package:flutter/material.dart';
import 'package:unae/recuperardatos.dart';

void main() {

  runApp(SampleCenterButton());
}

class SampleCenterButton extends StatelessWidget {
  //const SampleCenterButton({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

      body:
      Builder(
          builder: (context)
    {
      return Container(

        width: double.infinity,
        height: double.infinity,

        child: Stack(
          alignment: Alignment.center,

          children: <Widget>[
            _myScreenOptions(),
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
      onTap: ()  {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RecuperarDatos()),
      );
    },
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

  _myScreenOptions() {
    return Column(
      children: <Widget>[
        buildRow([
          buildOption(Color(0xff1D4554), Icons.person, "Teams"),
          buildOption(Color(0xff229B8D), Icons.folder_open, "Pets"),
        ]),
        buildRow([
          buildOption(Color(0xffE7C16A), Icons.videogame_asset, "Actualizar"),
          buildOption(Color(0xffF2A061), Icons.settings, "Options"),
        ]),
      ],
    );
  }

  Widget buildOption(Color bgColor, IconData iconData, String title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          acciones(title);
       },
      child: Container(
        color: bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Icon(
              iconData,
              size: 80,

            ),
            Text(
              title,
              style: TextStyle(fontSize: 30),
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
  acciones(String titulo)
  {
    print(titulo);
  }
}