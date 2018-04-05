import 'dart:async';
import 'dart:io';

import 'package:monai/configs/general_configs.dart';
import 'package:monai/data/category.dart';
import 'package:monai/data/currency.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Account {
  // TODO: There might be icon in the future
  int id;
  String name;
  double initialBalance, currentBalance;
  Currency currency;
  AccountCategory accountCategory;
  DateTime updatedDateTime, createdDateTime;

  Map toMap() {
    Map returningMap = {
      columnName: name,
      columnInitialBalance: initialBalance,
      columnCurrentBalance: currentBalance,
      columnCurrency: currency.id,
      columnAccountCategory: accountCategory.id,
      columnUpdatedDateTime: updatedDateTime.toIso8601String(),
      columnCreatedDateTime: createdDateTime.toIso8601String(),
    };

    if (id != null) returningMap[columnId] = id;
    return returningMap;
  }

  // To construct Transaction from map
  Account.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
    initialBalance = map[columnInitialBalance];
    currentBalance = map[columnCurrentBalance];
    updatedDateTime = DateTime.parse(map[columnUpdatedDateTime]);
    createdDateTime = DateTime.parse(map[columnCreatedDateTime]);

    CurrencyProvider
      .getInstance()
      .getCurrencyById(map[columnId])
      .then((value) => currency = value);

    AccountCategoryProvider
      .getInstance()
      .getCategory(map[accountCategory])
      .then((value) => accountCategory = value);
  }
}

const String tableName = "accounts";

const columnId = "_id";
const columnName = "name";
const columnInitialBalance = "i_balance";
const columnCurrentBalance = "c_balance";
const columnCurrency = "currency";
const columnAccountCategory = "category";
const columnUpdatedDateTime = "updated_date";
const columnCreatedDateTime = "created_date";

class AccountProvider {
  // Singleton pattern
  static final AccountProvider _accountProvider =
  new AccountProvider._internal();

  AccountProvider._internal();

  static AccountProvider getInstance() => _accountProvider;

  Database database;

  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    database = await openDatabase(path, version: 1,
      // We would create our db if we have never done so
      onCreate: (db, ver) async {
        await db.execute('''
      create table $tableName(
       $columnId integer primary key autoincrement,
       $columnName text not null,
       $columnInitialBalance real not null,
       $columnCurrentBalance real not null,
       $columnCurrency integer not null
       $columnAccountCategory integer not null
       $columnUpdatedDateTime text not null
       $columnCreatedDateTime text not null
      );
      ''');
      });
  }

  Future<Account> insert(Account account) async {
    await open();
    account.id = await database.insert(tableName, account.toMap());
    await close();
    return account;
  }

  Future<Account> getAccount(int id) async {
    await open();
    List<Map> maps = await database.query(tableName,
      columns: [
        columnId,
        columnName,
        columnInitialBalance,
        columnCurrentBalance,
        columnCurrency,
        columnAccountCategory,
        columnUpdatedDateTime,
        columnCreatedDateTime,
      ],
      where: "$columnId = ?",
      whereArgs: [id]);
    await close();
    return maps.length > 0 ? new Account.fromMap(maps.first) : null;
  }

  Future<List<Account>> getAllAccounts() async {
    await open();
    List<Map> maps = await database.query(
      tableName,
      columns: [
        columnId,
        columnName,
        columnInitialBalance,
        columnCurrentBalance,
        columnCurrency,
        columnAccountCategory,
        columnUpdatedDateTime,
        columnCreatedDateTime,
      ],
    );
    await close();
    return maps.map((map) => new Account.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    await open();
    var result = await database
      .delete(tableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return result;
  }

  Future<int> update(Account account) async {
    await open();
    var result = await database.update(tableName, account.toMap(),
      where: "$columnId = ?", whereArgs: [account.id]);
    await close();
    return result;
  }

  Future close() async => database.close();
}
