import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:controlaai/adicionar_boletos/boleto.dart';

class DatabaseHelper {
  static late Database _database;
 static final DatabaseHelper instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  static Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;

    _database = await _initDatabase();
    return _database;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final dbPath = path.join(databasePath, 'app_db.db');

    return await openDatabase(dbPath, version: 1, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT,
        senha TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE boletos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeBoleto TEXT,
        valorBoleto TEXT,
        parcelas TEXT,
        dataVencimento TEXT,
        diasAntesAlerta INTEGER
      )
    ''');
  }
static Future<void> salvarUsuario(String nome, String email, String senha) async {
  final db = await database;
  await db.insert(
    'usuarios',
    {'nome': nome, 'email': email, 'senha': senha},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}



  Future<void> salvarBoleto(Boleto boleto) async {
    final db = await database;
    await db.insert(
      'boletos',
      boleto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Boleto>> getBoletos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('boletos');
    return List.generate(maps.length, (index) {
      return Boleto(
        id: maps[index]['id'],
        nome: maps[index]['nomeBoleto'],
        valor: maps[index]['valorBoleto'],
        valorTotal: maps[index]['valorTotal'],
        parcelas: maps[index]['parcelas'],
        dataVencimento: maps[index]['dataVencimento'],
        diasAntesAlerta: maps[index]['diasAntesAlerta'],
        parcelasRestantes: maps[index]['parcelasRestantes'],  
        parcelasPagas: maps[index]['parcelasPagas'],  

      );
    });
  }

}
