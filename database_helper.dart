import 'videogenero.dart';
import 'usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'video.dart';
import 'genero.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Usuarios.db";

  static Future<Database> getDB() async {
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
              id INTEGER PRIMARY KEY,
              title VARCHAR NOT NULL,  
              description VARCHAR NOT NULL,
              type INTEGER NOT NULL,
              ageRestriction VARCHAR NOT NULL,
              durationMinutes INTEGER NOT NULL,
              thumbnailImageId VARCHAR NOT NULL,
              releaseDate VARCHAR NOT NULL,
              genre VARCHAR NOT NULL,
            )""");
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
            ):""");
            },
        version: _version);
  }
  //Metodos de adicionar
  static Future<int> addUsuario(Usuario usuario) async {
    final db = await getDB();
    return await db.insert("Usuario", usuario.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> addVideo(Video video) async {
    final db = await getDB();
    return await db.insert("Video", video.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> addGenero(Genero genero) async {
    final db = await getDB();
    return await db.insert("Genero", genero.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Lembrando que ao registrar um video tem N numero de generos, 
  //entao tem que ser feita essa chamada de acordo com a quantidade de generos de um video novo
  static Future<int> addVideoGenero(VideoGenero videoGenero) async {
    final db = await getDB();
    return await db.insert("videogenero", videoGenero.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Atualiza Usuario
/*static Future<int> updateUsuario(Usuario usuario) async {
    final db = await _getDB();
    return await db.update("Usuario", usuario.toJson(),
        where: 'id = ?',
        whereArgs: [usuario.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  } */
//Nao acho que precisa atualizar usuario so os videos

  //Update do Video
  static Future<int> updateVideo(Video video) async {
    final db = await getDB();
    return await db.update("Video", video.toJson(),
        where: 'id = ?',
        whereArgs: [video.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  //Lembrando que o update dos generos do video tem mais sentido com apenas delete e add do video_genero

  //Metodos de deletar 
  static Future<int> deleteVideo(Video video) async {
    final db = await getDB();
    return await db.delete(
      "Video",
      where: 'id = ?',
      whereArgs: [video.id],
    );
  }

  static Future<int> deleteVideoGenero(VideoGenero videoGenero) async {
    final db = await getDB();
    return await db.delete(
      "video_genero",
      where: 'id = ?',
      whereArgs: [videoGenero.id],
    );
  }


  //Lista todos os videos
  static Future<List<Video>?> getAllVideos() async {
    final db = await getDB();

    final List<Map<String, dynamic>> maps = await db.query("Video");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Video.fromJson(maps[index]));
  }
  

  //Lista todos os generos
  static Future<List<Genero>?> getAllGeneros() async {
    final db = await getDB();

    final List<Map<String, dynamic>> maps = await db.query("Genero");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Genero.fromJson(maps[index]));
  }
  //Lista todos os Usuarios
  static Future<List<Usuario>?> getAllUsuarios() async {
    final db = await getDB();

    final List<Map<String, dynamic>> maps = await db.query("Usuario");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Usuario.fromJson(maps[index]));
  }
}