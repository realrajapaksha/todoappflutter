import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {

  Future<Database> setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'todoapp');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async{
    var sql = "CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, date TEXT, description TEXT);";
    await database.execute(sql);
  }
}
