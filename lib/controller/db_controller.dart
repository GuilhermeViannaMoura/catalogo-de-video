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

  Future<int> addVideo(Video video, List<int> generos) async {
    var db = await con.db;
    int videoId = await db.insert("Video", video.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    int lastGenero = 0;
    if(generos.isNotEmpty){
      for(int i = 0; i < generos.length; i ++){
      lastGenero = await addVideoGenero(VideoGenero(videoId: videoId, genreId: generos[i]));
    }
    }
    return lastGenero;
  }

  Future<int> addGenero(Genero genero) async {
    final db = await con.db;
    return await db.insert("Genero", genero.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> addVideoGenero(VideoGenero videoGenero) async {
    final db = await con.db;
    return await db.insert("video_genero", videoGenero.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Update do Video
   Future<int> updateVideo(Video video, List<int> generos) async {
    final db = await con.db;

    int n = await db.update("Video", video.toJson(),
        where: 'id = ?',
        whereArgs: [video.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    int d = await db.delete(
      "video_genero",
      where: 'videoId = ?',
      whereArgs: [video.id],
    );
    int lastGenero = 0;
    if(generos.isNotEmpty){
      for(int i = 0; i < generos.length; i ++){
      lastGenero = await addVideoGenero(VideoGenero(videoId: video.id!, genreId: generos[i]));
    }
    }
    return lastGenero;
  }
 

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

  //Lista todos os videos generos
  Future<List<VideoGenero>?> getAllVideosGeneros() async {
    final db = await con.db;

    final List<Map<String, dynamic>> maps = await db.query("video_genero");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => VideoGenero.fromJson(maps[index]));
  }


  //Login do usuario
  Future<Usuario> getLogin(String email, String password) async {
    var db = await con.db;
    String sql = """
      SELECT * FROM Usuario WHERE email = '${email}' AND password = '${password}' 
    """;
   
    var res = await db.rawQuery(sql);
   
    if (res.length > 0) {
      return Usuario.fromJson(res.first);
    }
    
    return Usuario(id: -1, name: "", password: "", email: "");
  }

  //Check se existe cadastrado
  Future<bool> checkCadastro(String email) async {
    var db = await con.db;
    String sql = """
      SELECT * FROM Usuario WHERE email = '${email}'
    """;

    var res = await db.rawQuery(sql);

    if (res.length > 0) {
      return false; 
    }

    return true;
  }

  //Check se ja existe um video com msm titulo
  Future<bool> checkVideo(String title) async{
    var db = await con.db;
    String sql = """
      SELECT * FROM Video WHERE title = '${title}'
    """;

    var res = await db.rawQuery(sql);

    if (res.length > 0) {
      return false; 
    }

    return true;
  }
}