import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unae/principal.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

//flutter build apk  -t .\lib\login.dart

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  runApp(PantallaLogin());
}

class PantallaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final controladornom = TextEditingController();
  final controladorape = TextEditingController();
  final controladorpwd = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controladorape.dispose();
    controladornom.dispose();
    controladorpwd.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Registro evaluaciones"),
        backgroundColor: Colors.blueAccent,//const Color(0xff1D4554),
        leading: BackButton(
          onPressed: () => exit(0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0)),
                    child:
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/logoapp.png',width: 50.0, height: 50.0,fit: BoxFit.fill,)),
                )

              ),
            ),
            SizedBox(
              height: 30, // <-- SEE HERE
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controladornom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                    hintText: 'Ingrese su nombre'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controladorape,
                //obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Apellido',
                    hintText: 'Ingrese su apellido'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controladorpwd,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    hintText: 'Ingrese contraseña'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.blueAccent, borderRadius: BorderRadius.circular(25)),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () async {
                  if(controladorpwd.text=="1NA3.") {
                    if (controladornom.text.isEmpty ||
                        controladorape.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Debe ingresar el nombre y apellido"),
                            duration: Duration(seconds: 2),
                          ));
                    }
                    else {
                      SharedPreferences pref = await SharedPreferences
                          .getInstance();
                      String unificado = controladorape.text.toUpperCase() +
                          " " + controladornom.text.toUpperCase();
                      pref.setString("usuario", unificado);
                      Navigator.push(
                        context,
                        //MaterialPageRoute(builder: (context) =>  IngresoParametros()),
                        MaterialPageRoute(builder: (context) =>
                            SampleCenterButton()),
                      ).then((value) {});
                    }
                  }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Clave inválida"),
                            duration: Duration(seconds: 2),
                          ));
                    }
                },
                child: Text('Iniciar'),
              )
            ),


          ],
        ),
      ),
    );
  }
}