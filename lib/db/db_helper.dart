import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE appointment (id INTEGER PRIMARY KEY,fromLocation TEXT, toLocation TEXT);";
    await database.execute(sql);
  }
}

class DatabseHelper {
  create(Map<String, String> json) async {
    final database = await DatabaseConnection().setDatabase();
    database.insert('locations', json);
  }

  read() async {
    final database = await DatabaseConnection().setDatabase();
    return database.query('locations', orderBy: 'id DESC');
  }

  update(data) async {
    var database = await DatabaseConnection().setDatabase();
    return await database
        ?.update('locations', data, where: 'id=?', whereArgs: [data['id']]);
  }

  delete(String id) async {
    var database = await DatabaseConnection().setDatabase();
    return await database?.rawDelete("delete from locations where id=$id");
  }
}
