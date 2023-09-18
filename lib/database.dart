

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unae/instituciones.dart';
import 'planets.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'planets.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE planets(id INTEGER PRIMARY KEY , name TEXT NOT NULL,age INTEGER NOT NULL,distancefromsun INTEGER NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE instituciones(ins_id INTEGER PRIMARY KEY , ins_nombre TEXT NOT NULL,ins_tipo TEXT NOT NULL,ins_estado)",
        );

      },
    );
  }

  // insert data
  Future<int> insertPlanets(List<Planets> planets) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var planet in planets) {
      result = await db.insert('planets', planet.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }



  // retrieve Instituciones
  Future<List<Instituciones>> retrieveInstituciones() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('instituciones');
    return queryResult.map((e) => Instituciones.fromMap(e)).toList();
  }

  // retrieve data
  Future<List<Planets>> retrievePlanets() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('planets');
    return queryResult.map((e) => Planets.fromMap(e)).toList();
  }

  // delete user
  Future<void> deletePlanet(int id) async {
    final db = await initializedDB();
    await db.delete(
      'planets',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> insertInstituciones(List<Instituciones> instituciones) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var institucion in instituciones) {
      result = await db.insert('instituciones', institucion.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  Future<void> deleteInstituciones() async {
    final db = await initializedDB();
    await db.delete(
      'instituciones',
    );
  }

  Future<void> cargardatos() async {
    final db = await initializedDB();
    //cargar datos desde http
    List<Instituciones> lista_instituciones = [];
    lista_instituciones.add(new Instituciones(ins_id:1,ins_nombre: "Catalinas", ins_tipo: "U", ins_estado: "A"));
    lista_instituciones.add(new Instituciones(ins_id:2,ins_nombre: "Borja7", ins_tipo: "U", ins_estado: "A"));

    for (var institucion in lista_instituciones) {
      insertInstituciones(lista_instituciones);
    }
  }
}