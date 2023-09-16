import 'package:flutter/material.dart';
import 'planets.dart';
import 'instituciones.dart';
import 'database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Home());
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DataBase handler;

  Future<int> addInstituciones() async {
    Instituciones inst1 =
    Instituciones(ins_id:1, ins_nombre: "Catalinas", ins_tipo: "U", ins_estado:"A");
    Instituciones inst2 =
    Instituciones(ins_id:2, ins_nombre: "Borja", ins_tipo: "U", ins_estado:"A");
    List<Instituciones> instituciones = [inst1, inst2];
    return await handler.insertInstituciones(instituciones);
  }
  @override
  void initState() {
    super.initState();
    handler = DataBase();
    handler.initializedDB().whenComplete(() async {
      await addInstituciones();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: handler.retrieveInstituciones(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Instituciones>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      title: Text(snapshot.data![index].ins_nombre),
                      subtitle: Text(snapshot.data![index].ins_id.toString()),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}