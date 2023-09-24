import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unae/alumnos.dart';
import 'package:unae/instituciones.dart';
import 'planets.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'planets.db'),
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE planets(id INTEGER PRIMARY KEY , name TEXT NOT NULL,age INTEGER NOT NULL,distancefromsun INTEGER NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE instituciones(ins_id TEXT PRIMARY KEY , ins_nombre TEXT NOT NULL,ins_tipo TEXT NOT NULL,ins_estado)",
        );
        await db.execute(
            "CREATE TABLE alumnos(al_id INTEGER PRIMARY KEY, al_apellidos TEXT NOT NULL," +
                "al_nombres TEXT NOT NULL,ins_id TEXT NOT NULL,al_ins_ciclo TEXT NOT NULL," +
                "al_ins_paralelo TEXT NOT NULL");

        await db.execute(
            "CREATE TABLE notas(nota_id INTEGER PRIMARY KEY, ins_id TEXT" +
                "al_ins_ciclo TEXT NOT NULL,al_ins_paralelo TEXT NOT NULL" +
                "al_id INTEGER,  nota_p1 as TEXT, nota_p2 as TEXT,nota_p3 as TEXT," +
                "nota_p4 as TEXT,nota_p5 as TEXT,nota_p6 as TEXT,nota_7 as TEXT," +
                "nota_p8 as TEXT,nota_p9 as TEXT,nota_p10 as TEXT");
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

//**************************************************************************************
  //Instituciones

  // retrieve Instituciones
  Future<List<Instituciones>> retrieveInstituciones() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('instituciones');
    return queryResult.map((e) => Instituciones.fromMap(e)).toList();
  }

  // retrieve Instituciones
  Future<List<Instituciones>> retrieveInstitucionesCombo() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query(
      'instituciones',
      columns: ['ins_id', 'ins_nombre'],
    );
    /*
    for (var ent in queryResult) {
      for(var ent1 in ent.entries) {
        print(ent);
      }
    }*/
    return queryResult.map((e) => Instituciones.fromMap2(e)).toList();
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
    lista_instituciones.add(new Instituciones(
        ins_id: 1, ins_nombre: "Catalinas", ins_tipo: "U", ins_estado: "A"));
    lista_instituciones.add(new Instituciones(
        ins_id: 2, ins_nombre: "Borja7", ins_tipo: "U", ins_estado: "A"));

    //for (var institucion in lista_instituciones) {
      insertInstituciones(lista_instituciones);
    //}
  }

//**************************************************************************************
  Future<int> insertAlumnos(List<Alumnos> alumnos) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var alumno in alumnos) {
      result = await db.insert('alumnos', alumno.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }


  // retrieve Alumnos
  Future<List<Alumnos>> retrieveAlumnos() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('alumnos');
    return queryResult.map((e) => Alumnos.fromMap(e)).toList();
  }
  // retrieve Alumnos por aula
  //whereArgs: ['%$title']

  Future<List<Alumnos>> retrieveAlumnosAula(institucion) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('alumnos',
        where: "ins_id = ?",
        whereArgs: [institucion]
    );
    return queryResult.map((e) => Alumnos.fromMap(e)).toList();
  }


  Future<void> cargaralumnos() async {
    final db = await initializedDB();
    //cargar datos desde http
    List<Alumnos> lista_alumnos = [];
    lista_alumnos.add(new Alumnos(
        al_id: 1, al_apellidos: "Prieto", al_nombres: "Jaime", ins_id: "BOR",al_ins_ciclo: "1",al_ins_paralelo: "A"));
    lista_alumnos.add(new Alumnos(
        al_id: 2, al_apellidos: "Rojas", al_nombres: "Juan", ins_id: "BOR",al_ins_ciclo: "1",al_ins_paralelo: "A"));
    lista_alumnos.add(new Alumnos(
        al_id: 3, al_apellidos: "Riquelme", al_nombres: "Julia", ins_id: "CAT",al_ins_ciclo: "1",al_ins_paralelo: "A"));

    insertAlumnos(lista_alumnos);
  }

}
