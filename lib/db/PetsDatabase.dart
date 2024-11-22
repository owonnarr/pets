import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pets/models/Pet.dart';

class PetsDatabase {
  static final PetsDatabase instance = PetsDatabase._init();
  static Database? _database;

  static const petsTable = 'pets';

  PetsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('pets.db');
    return _database!;
  }

  Future<Database> _initDb(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE,
        type TEXT,
        height REAL,
        weight REAL
      )
    ''');
  }

  Future<int> addPet(Pet pet) async {
    final db = await instance.database;
    return await db.insert(petsTable, pet.toDb());
  }

  Future<int> deletePet(String name) async {
    final db = await instance.database;
    return await db.delete(petsTable, where: 'name = ?', whereArgs: [name]);
  }

  Future<List<Pet>> getPetByName(String name) async {
    final db = await instance.database;
    final result = await db.query(petsTable, where: 'name = ?', whereArgs: [name]);

    return result.map((e) => Pet.fromDb(e)).toList();
  }

  Future<List<Pet>> getPetsByType(String type) async {
    final db = await instance.database;
    final result = await db.query(petsTable, where: 'type = ?', whereArgs: [type]);

    return result.map((e) => Pet.fromDb(e)).toList();
  }
}