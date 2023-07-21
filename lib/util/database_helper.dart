import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database? _db;
  
  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<Database> get db async {
    return _db ??= await initDb();
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, "catalogo.db");
    
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        String sql = """
            CREATE TABLE Usuario( 
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name VARCHAR NOT NULL, 
              email VARCHAR NOT NULL,
              password VARCHAR NOT NULL
            );""";
         await db.execute(sql);
        String sql2 = """CREATE TABLE Video(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title VARCHAR NOT NULL UNIQUE,
              description TEXT NOT NULL,
              type INTEGER NOT NULL,
              ageRestriction VARCHAR NOT NULL,
              durationMinutes INTEGER NOT NULL,
              releaseDate TEXT NOT NULL,
              idUsuario INTEGER NOT NULL,
              FOREIGN KEY(idUsuario) REFERENCES Usuario(id)
            );""";
         await db.execute(sql2);
         await db.execute(
            """CREATE TABLE Genero(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name VARCHAR UNIQUE
            );""");
            await db.execute(
            """CREATE TABLE video_genero(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              videoId INTEGER NOT NULL,
              genreId INTEGER NOT NULL,
              FOREIGN KEY(videoId) REFERENCES Video(id),
              FOREIGN KEY(genreId) REFERENCES Genero(id)
            );""");
      }
    );

    return db;
  }

}
