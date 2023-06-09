import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  get database async{
    if(_database != null) return _database;
    return await _initDatabase();
  }

  _initDatabase() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'teste.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao)async{
    await db.execute(_cadastro);
  }

  String get _cadastro => '''
  CREATE TABLE cadastro(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    ra TEXT,
    curso TEXT,
    email TEXT,
    senha TEXT,
    imagem TEXT
  );
''';

}