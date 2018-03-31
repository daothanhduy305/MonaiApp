import 'dart:async';
import 'dart:io';

import 'package:monai/configs/general_configs.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Defining data classes

class TransactionCategory {
  // Currently, we would make use of only name
  // There would be icon or something else in the future
  String name;
  int id;

  Map toMap() {
    Map returningMap = {
      columnName: name,
    };

    if (id != null) returningMap[columnId] = id;
    return returningMap;
  }

  // To construct Transaction from map
  TransactionCategory.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
  }
}

class AccountCategory {
  // Currently, we would make use of only name
  // There would be icon or something else in the future
  String name;
  int id;

  Map toMap() {
    Map returningMap = {
      columnName: name,
    };

    if (id != null) returningMap[columnId] = id;
    return returningMap;
  }

  // To construct Transaction from map
  AccountCategory.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
  }
}

// Defining providers

const String transactionCategoryTableName = "transaction_categories";
const String accountCategoryTableName = "account_categories";

const columnId = "_id";
const columnName = "name";

class TransactionCategoryProvider {
  // Singleton pattern
  static final TransactionCategoryProvider _transactionCategoryProvider =
      new TransactionCategoryProvider._internal();

  TransactionCategoryProvider._internal();

  static TransactionCategoryProvider getInstance() => _transactionCategoryProvider;

  Database database;

  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    database = await openDatabase(path, version: 1,
        // We would create our db if we have never done so
        onCreate: (db, ver) async {
      await db.execute('''
      create table $transactionCategoryTableName(
       $columnId integer primary key autoincrement,
       $columnName text not null
      );
      ''');
    });
  }

  Future<TransactionCategory> insert(TransactionCategory category) async {
    await open();
    category.id = await database.insert(transactionCategoryTableName, category.toMap());
    await close();
    return category;
  }

  Future<TransactionCategory> getCategory(int id) async {
    await open();
    List<Map> maps = await database.query(transactionCategoryTableName,
        columns: [columnId, columnName], where: "$columnId = ?", whereArgs: [id]);
    await close();
    return maps.length > 0 ? new TransactionCategory.fromMap(maps.first) : null;
  }

  Future<List<TransactionCategory>> getAllCategories() async {
    await open();
    List<Map> maps = await database.query(
      transactionCategoryTableName,
      columns: [columnId, columnName],
    );
    await close();
    return maps.map((map) => new TransactionCategory.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    await open();
    var result = await database
        .delete(transactionCategoryTableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return result;
  }

  Future<int> update(TransactionCategory category) async {
    await open();
    var result = await database.update(transactionCategoryTableName, category.toMap(),
        where: "$columnId = ?", whereArgs: [category.id]);
    await close();
    return result;
  }

  Future close() async => database.close();
}

class AccountCategoryProvider {
  // Singleton pattern
  static final AccountCategoryProvider _accountCategoryProvider =
  new AccountCategoryProvider._internal();

  AccountCategoryProvider._internal();

  static AccountCategoryProvider getInstance() => _accountCategoryProvider;

  Database database;

  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    database = await openDatabase(path, version: 1,
        // We would create our db if we have never done so
        onCreate: (db, ver) async {
          await db.execute('''
      create table $accountCategoryTableName(
       $columnId integer primary key autoincrement,
       $columnName text not null
      );
      ''');
        });
  }

  Future<AccountCategory> insert(AccountCategory category) async {
    await open();
    category.id = await database.insert(accountCategoryTableName, category.toMap());
    await close();
    return category;
  }

  Future<AccountCategory> getCategory(int id) async {
    await open();
    List<Map> maps = await database.query(accountCategoryTableName,
        columns: [columnId, columnName], where: "$columnId = ?", whereArgs: [id]);
    await close();
    return maps.length > 0 ? new AccountCategory.fromMap(maps.first) : null;
  }

  Future<List<AccountCategory>> getAllCategories() async {
    await open();
    List<Map> maps = await database.query(
      accountCategoryTableName,
      columns: [columnId, columnName],
    );
    await close();
    return maps.map((map) => new AccountCategory.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    await open();
    var result = await database
        .delete(accountCategoryTableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return result;
  }

  Future<int> update(AccountCategory category) async {
    await open();
    var result = await database.update(accountCategoryTableName, category.toMap(),
        where: "$columnId = ?", whereArgs: [category.id]);
    await close();
    return result;
  }

  Future close() async => database.close();
}
