import 'usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Usuarios.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Usuario(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL);"),
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
