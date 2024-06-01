import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/DatabaseConfig/notification_model.dart';

class MasterDB {
  static final MasterDB instance = MasterDB._init();
  static Database? _database;

  MasterDB._init();

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

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const intType = 'INTEGER';
    const notNull = 'NOT NULL';
//     debugPrint('!!!!!Transaction Table CREATED !!!!!');
//     await db.execute('''
//       CREATE TABLE $transactionTable(
//         ${TransactionField.id} $idType,
//         ${TransactionField.category} $textType $notNull,
//         ${TransactionField.recurring} INTEGER $notNull,
//         ${TransactionField.type} $textType $notNull,
//         ${TransactionField.mode} $textType $notNull,
//         ${TransactionField.amount} $numType $notNull,
//         ${TransactionField.time} $textType $notNull,
//         ${TransactionField.media} $textType,
//         ${TransactionField.note} $textType
//       )
// ''');
//     debugPrint('!!!!!Recurring Transaction Table CREATED !!!!!');
//     await db.execute('''
//       CREATE TABLE $recurringTable(
//         ${RecurringField.id} $idType,
//         ${RecurringField.name} $textType $notNull,
//         ${RecurringField.lastTransaction} INTEGER $notNull,
//         ${RecurringField.frequency} $textType $notNull,
//         ${RecurringField.created} $textType $notNull
//       )
// ''');
    debugPrint('!!!!!Category Table CREATED !!!!!');
    await db.execute('''
      CREATE TABLE $wishlist_table_name(
        ${CourseField.id} $intType $notNull UNIQUE,
        ${CourseField.title} $textType $notNull,
        ${CourseField.thumbnail} $textType $notNull,
        ${CourseField.type} $textType $notNull,
        ${CourseField.uniqueName} $textType $notNull,
        ${CourseField.price} $intType,
        ${CourseField.uploaded} $textType $notNull
      )
''');
    debugPrint('!!!!!Notification Table CREATED !!!!!');
    await db.execute('''
      CREATE TABLE $notificationTableName(
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

  Future create(dynamic media, String tableName) async {
    if (tableName == wishlist_table_name) {
      final db = await instance.database;
      await db.insert(wishlist_table_name, media.toJson());
      return media;
    } else if (media.runtimeType == Notification) {
      final db = await instance.database;
      final id = await db.insert(notificationTableName, media.toJson());
      return media.copy(id: id);
    } else {
      throw Exception('Table does not exists');
    }
  }

  Future readMedia(int id, String table) async {
    if (table == notificationTableName) {
      final db = await instance.database;
      final maps = await db.query(
        notificationTableName,
        where: '${NotificationField.id} = ?',
        columns: [],
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Notification.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } else {
      throw Exception('Table $table does not exists');
    }
  }

  Future<List> readAllNotes(String table) async {
    if (table == wishlist_table_name) {
      final db = await instance.database;
      const orderBy = CourseField.uploaded;
      final result = await db.query(wishlist_table_name, orderBy: orderBy);
      return result.map((json) => CourseMedia.fromJson(json)).toList();
    } else if (table == notificationTableName) {
      final db = await instance.database;
      const orderBy = NotificationField.datetime;
      final result = await db.query(notificationTableName, orderBy: orderBy);
      return result.map((json) => Notification.fromJson(json)).toList();
    } else {
      throw Exception('Table $table does not exists');
    }
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

  Future<int> delete(int id, String table) async {
    if (table == notificationTableName) {
      final db = await instance.database;
      return await db.delete(
        notificationTableName,
        where: '${NotificationField.id} = ?',
        whereArgs: [id],
      );
    } else {
      throw Exception('Table $table does not exists');
    }
  }

  Future<void> deleteAllNotes(String? table) async {
    final db = await instance.database;
    if (table != null && table == notificationTableName) {
      await db.delete(
        notificationTableName,
      );
      return;
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
