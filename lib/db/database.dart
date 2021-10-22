import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user_modes.dart';

class LocalDb {
  static final LocalDb instance = LocalDb._init();
  static Database? _database;

  LocalDb._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeNull = 'TEXT NULL';
    // const boolType = 'BOOLEAN NOT NULL';
    // const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableUser ( 
  ${UsersFields.id} $idType, 
  ${UsersFields.name} $textType,
  ${UsersFields.address} $textType,
  ${UsersFields.phone1} $textType,
  ${UsersFields.phone2} $textTypeNull,
  ${UsersFields.time} $textType
  )
''');
  }

  // ******** User Operations ******** //

  Future<Users> createUser(Users user) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableUser, user.toJson());
    return user.copy(id: id);
  }

  Future<Users> getUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: UsersFields.values,
      where: '${UsersFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Users.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Users>> getAllUsers() async {
    final db = await instance.database;
    final orderBy = '${UsersFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableUser, orderBy: orderBy);
    return result.map((json) => Users.fromJson(json)).toList();
  }

  Future<int> updateUser(Users user) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      user.toJson(),
      where: '${UsersFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${UsersFields.id} = ?',
      whereArgs: [id],
    );
  }

// ************************************************* //

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
