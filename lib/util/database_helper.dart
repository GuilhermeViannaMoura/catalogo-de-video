import 'usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Usuarios.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async { 
            await db.execute( 
            """CREATE TABLE Usuario(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name VARCHAR NOT NULL,
              email VARCHAR NOT NULL,
              password VARCHAR NOT NULL
            );""");
            await db.execute(
            """CREATE TABLE Video(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title VARCHAR(2) NOT NULL,
              description TEXT NOT NULL,
              type INTEGER NOT NULL,
              ageRestriction VARCHAR NOT NULL,
              durationMinutes INTEGER NOT NULL,
              thumbnailImageId VARCHAR NOT NULL,
              releaseDate TEXT NOT NULL,
              idUsuario INTEGER NOT NULL,
              FOREIGN KEY(idUsuario) REFERENCES Usuario.id
            );""");
            await db.execute(
            """CREATE TABLE Genero(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name VARCHAR NOT NULL
            );""");
            await db.execute(
            """CREATE TABLE video_genero(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              videoId INTEGER NOT NULL,
              genreId INTEGER NOT NULL,
              FOREIGN KEY(videoId) REFERENCES Video.id,
              FOREIGN KEY(genreId) REFERENCES Genero.id
            ):""");},
        version: _version);
  }
  //Adiciona usuario
  static Future<int> addUsuario(Usuario usuario) async {
    final db = await _getDB();
    return await db.insert("Usuario", usuario.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  //Atualiza Usuario
  static Future<int> updateUsuario(Usuario usuario) async {
    final db = await _getDB();
    return await db.update("Usuario", usuario.toJson(),
        where: 'id = ?',
        whereArgs: [usuario.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  //Deleta Usuario
  static Future<int> deleteUsuario(Usuario usuario) async {
    final db = await _getDB();
    return await db.delete(
      "Usuario",
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }
  //Lista todos os Usuarios
  static Future<List<Usuario>?> getAllUsuarios() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Usuario");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Usuario.fromJson(maps[index]));
  }
}
