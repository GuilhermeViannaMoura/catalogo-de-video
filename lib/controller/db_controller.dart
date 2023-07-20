import '../util/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../classes/genero.dart';
import '../classes/usuario.dart';
import '../classes/video.dart';
import '../classes/video_genero.dart';

class DataBaseController {
  DatabaseHelper con = DatabaseHelper();
  
  //Metodos de adicionar
  Future<int> addUsuario(Usuario usuario) async {
    final db = await con.db;
    return await db.insert("Usuario", usuario.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> addVideo(Video video) async {
    var db = await con.db;
    return await db.insert("Video", video.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> addGenero(Genero genero) async {
    final db = await con.db;
    return await db.insert("Genero", genero.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Lembrando que ao registrar um video tem N numero de generos, 
  //entao tem que ser feita essa chamada de acordo com a quantidade de generos de um video novo
  Future<int> addVideoGenero(VideoGenero videoGenero) async {
    final db = await con.db;
    return await db.insert("video_genero", videoGenero.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Atualiza Usuario
/*static Future<int> updateUsuario(Usuario usuario) async {
    final db = await con.db;
    return await db.update("Usuario", usuario.toJson(),
        where: 'id = ?',
        whereArgs: [usuario.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  } */
//Nao acho que precisa atualizar usuario so os videos

  //Update do Video
   Future<int> updateVideo(Video video) async {
    final db = await con.db;
    return await db.update("Video", video.toJson(),
        where: 'id = ?',
        whereArgs: [video.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  //Lembrando que o update dos generos do video tem mais sentido com apenas delete e add do video_genero

  //Metodos de deletar 
  Future<int> deleteVideo(Video video) async {
    final db = await con.db;
    return await db.delete(
      "Video",
      where: 'id = ?',
      whereArgs: [video.id],
    );
  }

  Future<int> deleteVideoGenero(VideoGenero videoGenero) async {
    final db = await con.db;
    return await db.delete(
      "video_genero",
      where: 'id = ?',
      whereArgs: [videoGenero.id],
    );
  }


  //Lista todos os videos
  Future<List<Video>?> getAllVideos() async {
    final db = await con.db;

    final List<Map<String, dynamic>> maps = await db.query("Video");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Video.fromJson(maps[index]));
  }
  

  //Lista todos os generos
  Future<List<Genero>?> getAllGeneros() async {
    final db = await con.db;

    final List<Map<String, dynamic>> maps = await db.query("Genero");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Genero.fromJson(maps[index]));
  }
}