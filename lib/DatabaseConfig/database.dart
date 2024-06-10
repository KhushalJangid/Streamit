import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/DatabaseConfig/notification_model.dart';

Future _createDB(Database db, int version) async {
  const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  const textType = 'TEXT';
  const intType = 'INTEGER';
  const notNull = 'NOT NULL';
  debugPrint('!!!!! Wishlist Table CREATED !!!!!');
  await db.execute('''
      CREATE TABLE wishlist(
        ${CourseField.id} $intType $notNull UNIQUE,
        ${CourseField.title} $textType $notNull,
        ${CourseField.description} $textType $notNull,
        ${CourseField.thumbnail} $textType $notNull,
        ${CourseField.type} $textType $notNull,
        ${CourseField.uniqueName} $textType $notNull,
        ${CourseField.price} $intType,
        ${CourseField.uploaded} $textType $notNull
      )
''');
  debugPrint('!!!!! Mycourse Table CREATED !!!!!');
  await db.execute('''
      CREATE TABLE mycourses(
        ${CourseField.id} $intType $notNull UNIQUE,
        ${CourseField.title} $textType $notNull,
        ${CourseField.description} $textType $notNull,
        ${CourseField.thumbnail} $textType $notNull,
        ${CourseField.type} $textType $notNull,
        ${CourseField.uniqueName} $textType $notNull,
        ${CourseField.price} $intType,
        ${CourseField.uploaded} $textType $notNull
      )
''');
  debugPrint('!!!!! Notification Table CREATED !!!!!');
  await db.execute('''
      CREATE TABLE notifications(
        ${NotificationField.id} $idType,
        ${NotificationField.title} $textType $notNull,
        ${NotificationField.description} $textType $notNull,
        ${NotificationField.datetime} $textType $notNull,
        ${NotificationField.media} $textType
      )
''');
}

// Future _upgradeDB(Database db, int oldVersion, int newVerion) async {
//   if (oldVersion == 1) {
//     await db.execute(
//         "ALTER TABLE $transactionTable ADD COLUMN ${TransactionField.language} TEXT NULL");
//     await db.execute(
//         "ALTER TABLE $transactionTable ADD COLUMN ${TransactionField.isTranslated} INTEGER NOT NULL DEFAULT 0");
//   } else if (oldVersion == 2) {
//     await db.execute(
//         "ALTER TABLE $transactionTable ADD COLUMN ${TransactionField.isTranslated} INTEGER NOT NULL DEFAULT 0");
//   }
// }

class NotificationDB {
  static final NotificationDB instance = NotificationDB._init();
  static Database? _database;
  final _tableName = "notifications";

  NotificationDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('datastore.db');
    return _database!;
  }

  Future<Database> _initDB(String transactionPath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, transactionPath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future insert(Notification media) async {
    final db = await instance.database;
    final id = await db.insert(_tableName, media.toJson());
    return media.copy(id: id);
  }

  Future get(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      _tableName,
      where: '${NotificationField.id} = ?',
      columns: [],
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Notification.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List> all() async {
    final db = await instance.database;
    const orderBy = NotificationField.datetime;
    final result = await db.query(_tableName, orderBy: orderBy);
    return result.map((json) => Notification.fromJson(json)).toList();
  }

  // Future<int> update(dynamic media) async {
  //   if (media.runtimeType == TransactionMedia) {
  //     final db = await instance.database;
  //     return db.update(
  //       transactionTable,
  //       media.toJson(),
  //       where: '${TransactionField.id} = ?',
  //       whereArgs: [media.id],
  //     );
  //   } else if (media.runtimeType == RecurringField) {
  //     final db = await instance.database;
  //     return db.update(
  //       recurringTable,
  //       media.toJson(),
  //       where: '${RecurringField.id} = ?',
  //       whereArgs: [media.id],
  //     );
  //   } else if (media.runtimeType == CategoryMedia) {
  //     final db = await instance.database;
  //     return db.update(
  //       categoryTable,
  //       media.toJson(),
  //       where: '${CategoryField.id} = ?',
  //       whereArgs: [media.id],
  //     );
  //   } else {
  //     throw Exception('Table does not exists');
  //   }
  // }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      _tableName,
      where: '${NotificationField.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllNotes() async {
    final db = await instance.database;
    await db.delete(
      _tableName,
    );
    return;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class Wishlist {
  static final Wishlist instance = Wishlist._init();
  static Database? _database;
  final String _tableName = "wishlist";

  Wishlist._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('datastore.db');
    return _database!;
  }

  Future<Database> _initDB(String transactionPath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, transactionPath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future insert(CourseMedia media) async {
    final db = await instance.database;
    await db.insert(_tableName, media.toJson());
    return media;
  }

  Future<CourseMedia> get(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      _tableName,
      where: '${CourseField.id} = ?',
      columns: [],
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CourseMedia.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<CourseMedia>> all() async {
    final db = await instance.database;
    const orderBy = CourseField.uploaded;
    final result = await db.query(_tableName, orderBy: orderBy);
    return result.map((json) => CourseMedia.fromJson(json)).toList();
  }

  Future<int> delete(CourseMedia course) async {
    final db = await instance.database;
    return await db.delete(
      _tableName,
      where: '${CourseField.id} = ?',
      whereArgs: [course.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class MycourseDB {
  static final MycourseDB instance = MycourseDB._init();
  static Database? _database;
  final String _tableName = "mycourses";

  MycourseDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('datastore.db');
    return _database!;
  }

  Future<Database> _initDB(String transactionPath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, transactionPath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future insert(CourseMedia media) async {
    final db = await instance.database;
    await db.insert(_tableName, media.toJson());
    return media;
  }

  Future<CourseMedia> get(int id, String table) async {
    final db = await instance.database;
    final maps = await db.query(
      _tableName,
      where: '${CourseField.id} = ?',
      columns: [],
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CourseMedia.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<CourseMedia>> all() async {
    final db = await instance.database;
    const orderBy = CourseField.uploaded;
    final result = await db.query(_tableName, orderBy: orderBy);
    return result.map((json) => CourseMedia.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
