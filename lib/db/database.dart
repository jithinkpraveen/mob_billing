import 'package:mob_billing/model/brand_model.dart';
import 'package:mob_billing/model/record_model.dart';
import 'package:mob_billing/model/services_model.dart';
import 'package:mob_billing/model/status_model.dart';
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
    await db.execute('''
CREATE TABLE $tableServices ( 
  ${ServicesFields.id} $idType, 
  ${ServicesFields.name} $textType,
  ${ServicesFields.discretion} $textType,
  ${ServicesFields.time} $textType
  )
''');
    await db.execute('''
CREATE TABLE $tableStatus ( 
  ${StatusFields.id} $idType, 
  ${StatusFields.name} $textType,
  ${StatusFields.discretion} $textType,
  ${StatusFields.time} $textType
  )
''');
    await db.execute('''
CREATE TABLE $tableBrand ( 
  ${BrandFields.id} $idType, 
  ${BrandFields.name} $textType,
  ${BrandFields.discretion} $textType,
  ${BrandFields.time} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableRecord ( 
  ${RecordFields.id} $idType, 
  ${RecordFields.service} $textType,
  ${RecordFields.model} $textType,
  ${RecordFields.user} $textType,
  ${RecordFields.status} $textType,
  ${RecordFields.time} $textType,
  ${RecordFields.timeOfServices} $textType
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

// ******** Services Operations ******** //

  Future<Services> addServices(Services service) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableServices, service.toJson());
    return service.copy(id: id);
  }

  Future<Services> getServices(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableServices,
      columns: ServicesFields.values,
      where: '${ServicesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Services.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Services>> getAllServices() async {
    final db = await instance.database;
    final orderBy = '${ServicesFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableServices, orderBy: orderBy);
    return result.map((json) => Services.fromJson(json)).toList();
  }

  Future<int> updateServices(Services service) async {
    final db = await instance.database;

    return db.update(
      tableServices,
      service.toJson(),
      where: '${ServicesFields.id} = ?',
      whereArgs: [service.id],
    );
  }

  Future<int> deleteService(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableServices,
      where: '${ServicesFields.id} = ?',
      whereArgs: [id],
    );
  }

// ************************************************* //

// ******** Status Operations ******** //

  Future<Status> addStatus(Status service) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableStatus, service.toJson());
    return service.copy(id: id);
  }

  Future<Status> getStatus(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableStatus,
      columns: StatusFields.values,
      where: '${StatusFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Status.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Status>> getAllStatus() async {
    final db = await instance.database;
    final orderBy = '${StatusFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableStatus, orderBy: orderBy);
    return result.map((json) => Status.fromJson(json)).toList();
  }

  Future<int> updateStatus(Status service) async {
    final db = await instance.database;

    return db.update(
      tableStatus,
      service.toJson(),
      where: '${StatusFields.id} = ?',
      whereArgs: [service.id],
    );
  }

  Future<int> deleteStatus(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableStatus,
      where: '${StatusFields.id} = ?',
      whereArgs: [id],
    );
  }

// ************************************************* //

// ******** Brand Operations ******** //

  Future<Brand> addBrand(Brand brand) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableBrand, brand.toJson());
    return brand.copy(id: id);
  }

  Future<Brand> getBrand(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBrand,
      columns: BrandFields.values,
      where: '${BrandFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Brand.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Brand>> getAllBrands() async {
    final db = await instance.database;
    final orderBy = '${BrandFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableBrand, orderBy: orderBy);
    return result.map((json) => Brand.fromJson(json)).toList();
  }

  Future<int> updateBrand(Brand brand) async {
    final db = await instance.database;

    return db.update(
      tableBrand,
      brand.toJson(),
      where: '${StatusFields.id} = ?',
      whereArgs: [brand.id],
    );
  }

  Future<int> deleteBrand(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBrand,
      where: '${StatusFields.id} = ?',
      whereArgs: [id],
    );
  }

// ************************************************* //

// ******** Record Operations ******** //

  Future<Record> addRecord(Record record) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableRecord, record.toJson());
    return record.copy(id: id);
  }

  Future<Record> getRecord(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRecord,
      columns: RecordFields.values,
      where: '${RecordFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Record.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Record>> getAllRecords() async {
    final db = await instance.database;
    final orderBy = '${RecordFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableRecord, orderBy: orderBy);
    return result.map((json) => Record.fromJson(json)).toList();
  }

  Future<int> updateRecord(Record record) async {
    final db = await instance.database;

    return db.update(
      tableRecord,
      record.toJson(),
      where: '${RecordFields.id} = ?',
      whereArgs: [record.id],
    );
  }

  Future<int> deleteRecord(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRecord,
      where: '${RecordFields.id} = ?',
      whereArgs: [id],
    );
  }

// ************************************************* //

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
