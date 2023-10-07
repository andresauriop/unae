import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unae/alumnos.dart';
import 'package:unae/instituciones.dart';
import 'planets.dart';
import 'notas.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'planets.db'),
      version: 4,
      onCreate: (Database db, int version) async {
        print("Creando base de datos");
        await db.execute(
          "CREATE TABLE planets(id INTEGER PRIMARY KEY , name TEXT NOT NULL,age INTEGER NOT NULL,distancefromsun INTEGER NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE instituciones(ins_id TEXT PRIMARY KEY , ins_nombre TEXT NOT NULL,ins_tipo TEXT NOT NULL,ins_estado)",
        );
        await db.execute(
            "CREATE TABLE alumnos(al_id INTEGER PRIMARY KEY, al_apellidos TEXT NOT NULL," +
                "al_nombres TEXT NOT NULL,ins_id TEXT NOT NULL,al_ins_ciclo TEXT NOT NULL," +
                "al_ins_paralelo TEXT NOT NULL)");

        await db.execute(
            "CREATE TABLE notas(nota_id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "ins_id TEXT," +
            "al_ins_ciclo TEXT NOT NULL,"+
            "al_ins_paralelo TEXT NOT NULL," +
            "al_id INTEGER,  "+
            "nota_fecha TEXT NOT NULL,  "+
            "nota_p1  TEXT, nota_p2  TEXT,nota_p3  TEXT," +
            "nota_p4  TEXT,nota_p5  TEXT,nota_p6  TEXT,nota_p7  TEXT," +
            "nota_p8  TEXT,nota_p9  TEXT,nota_p10  TEXT, "
            "nota_p11  TEXT, nota_p12  TEXT,nota_p13  TEXT," +
            "nota_p14  TEXT,nota_p15  TEXT,nota_p16  TEXT,nota_p17  TEXT," +
            "nota_p18  TEXT,nota_p19  TEXT,nota_p20  TEXT, nota_estado TEXT," +
            "nota_adc TEXT)");
      },

      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print("Actualizando base de datos");
        await db.execute("DROP TABLE IF EXISTS planets");
        await db.execute(
          "CREATE TABLE planets(id INTEGER PRIMARY KEY , name TEXT NOT NULL,age INTEGER NOT NULL,distancefromsun INTEGER NOT NULL)",
        );
        await db.execute("DROP TABLE IF EXISTS instituciones");
        await db.execute(
          "CREATE TABLE instituciones(ins_id TEXT PRIMARY KEY , ins_nombre TEXT NOT NULL,ins_tipo TEXT NOT NULL,ins_estado)",
        );
        await db.execute("DROP TABLE IF EXISTS alumnos");
        await db.execute(
            "CREATE TABLE alumnos(al_id INTEGER PRIMARY KEY, al_apellidos TEXT NOT NULL," +
                "al_nombres TEXT NOT NULL,ins_id TEXT NOT NULL,al_ins_ciclo TEXT NOT NULL," +
                "al_ins_paralelo TEXT NOT NULL)");

        await db.execute("DROP TABLE IF EXISTS notas");
        await db.execute(
            "CREATE TABLE notas(nota_id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "ins_id TEXT," +
                "al_ins_ciclo TEXT NOT NULL,"+
                "al_ins_paralelo TEXT NOT NULL," +
                "al_id INTEGER,  "+
                "nota_fecha TEXT NOT NULL,  "+
                "nota_p1  TEXT, nota_p2  TEXT,nota_p3  TEXT," +
                "nota_p4  TEXT,nota_p5  TEXT,nota_p6  TEXT,nota_p7  TEXT," +
                "nota_p8  TEXT,nota_p9  TEXT,nota_p10  TEXT, "
                "nota_p11  TEXT, nota_p12  TEXT,nota_p13  TEXT," +
                "nota_p14  TEXT,nota_p15  TEXT,nota_p16  TEXT,nota_p17  TEXT," +
                "nota_p18  TEXT,nota_p19  TEXT,nota_p20  TEXT, nota_estado TEXT," +
                    "nota_adc TEXT)");
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
    await db.delete(
      'alumnos',
    );
    await db.delete(
      'notas',
    );

  }

  Future<void> cargardatos() async {
    final db = await initializedDB();
    //cargar datos desde http
    List<Instituciones> lista_instituciones = [];
    lista_instituciones.add(new Instituciones(
        ins_id: "CAT", ins_nombre: "Catalinas", ins_tipo: "U", ins_estado: "A"));
    lista_instituciones.add(new Instituciones(
        ins_id: "BOR", ins_nombre: "Borja", ins_tipo: "U", ins_estado: "A"));

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

  Future<List<Alumnos>> retrieveAlumnosAula(institucion,curso,paralelo) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('alumnos',
        where: "ins_id = ? AND al_ins_ciclo = ? AND al_ins_paralelo = ?",
        whereArgs: [institucion,curso,paralelo]
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


  Future<int> insertNota(Notas nota) async {
    int result = 0;
    final Database db = await initializedDB();
      result = await db.insert('notas', nota.toMap2(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  //coloca la nota en procesado

  Future<void> updateNota(int nota_id) async {
    final Database db = await initializedDB();
    await db.rawUpdate('update notas set nota_estado = "P" where nota_id = ${nota_id.toString()}');
    //await database
      //  .rawUpdate('UPDATE SQFLITE SET last_name = "${user.lastName}" WHERE first_name = "${user.firstName}"');
  }


  // retrieve Notas
  Future<List<Notas>> retrieveNotas(institucion,curso,paralelo,fecha) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =  await db.query('notas',
        where: "ins_id = ? AND al_ins_ciclo = ? AND al_ins_paralelo = ?",
        whereArgs: [institucion,curso,paralelo]
    );
    return queryResult.map((e) => Notas.fromMap(e)).toList();
  }

  // retrieve Notas
  Future<List<Notas>> retrieveNotasAlumno(institucion,curso,paralelo,fecha,alumno) async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =  await db.query('notas',
        where: "ins_id = ? AND al_ins_ciclo = ? AND al_ins_paralelo = ? AND "+
               "nota_fecha = ? AND al_id = ?",
        whereArgs: [institucion,curso,paralelo,fecha,alumno]
    );
    //print(queryResult.toString());
    return queryResult.map((e) => Notas.fromMap(e)).toList();
  }

  // retrieve Notas Pendientes
  Future<List<Notas>> retrieveNotasPendientes() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =  await db.query('notas',
        //where: "nota_adc = ?",
        where: "nota_estado = ?",
        whereArgs: ["I"]  //I:ingresado P:procesado
    );

    return queryResult.map((e) => Notas.fromMap(e)).toList();
  }

  // retrieve Notas
  Future<List<Map>> getAlumnoNotaDia(institucion,curso,paralelo,fecha) async {
    final Database db = await initializedDB();
    //final List<Map<String, Object?>> queryResult 
    String sql = "select distinct al_id,al_apellidos,al_nombres,ins_id,al_ins_ciclo,al_ins_paralelo,nota_fecha from ( " +
        'select '+
        'alumnos.al_id al_id, '+
        'alumnos.al_apellidos al_apellidos ,'+
        'alumnos.al_nombres al_nombres,'+
        'alumnos.ins_id ins_id,'+
        'alumnos.al_ins_ciclo al_ins_ciclo,'+
        'alumnos.al_ins_paralelo,'+
        'nota_fecha '+
        'from alumnos ' +
        'left join notas on alumnos.al_id = notas.al_id '+
        'AND notas.nota_fecha = "$fecha" '
        'where '+
        //'alumnos.al_id = ? AND '+
        'alumnos.ins_id = "$institucion" AND '+
        'alumnos.al_ins_ciclo = $curso AND '+
        'alumnos.al_ins_paralelo = "$paralelo" '+
        ')';
        //print(sql);
        List<Map> result = await db.rawQuery(sql);


        //[alumno,"'" +institucion + "'",curso,"'" + paralelo +"'","'"+fecha+"'"]);

    //print("CONSULTA " + result.toString());
    //print(queryResult.toString());
    return result;
  }


}
