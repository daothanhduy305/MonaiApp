import 'dart:async';
import 'dart:io';

import 'package:monai/configs/general_configs.dart';
import 'package:monai/data/currency.dart';
import 'package:monai/data/database_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Account {
  // TODO: There might be icon in the future
  int id, currencyId;
  String name, accountCategory;
  double initialBalance, currentBalance;
  Currency currency;
  DateTime updatedDateTime, createdDateTime;

  Account({
    this.name,
    this.initialBalance,
    this.currentBalance,
    this.accountCategory,
    this.currency
  }) {
    var dateTime = new DateTime.now();
    this.createdDateTime = dateTime;
    this.updatedDateTime = dateTime;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returningMap = {
      columnName: name,
      columnInitialBalance: initialBalance,
      columnCurrentBalance: currentBalance,
      columnCurrency: currency.id,
      columnAccountCategory: accountCategory,
      columnUpdatedDateTime: updatedDateTime.toIso8601String(),
      columnCreatedDateTime: createdDateTime.toIso8601String(),
    };

    if (id != null) returningMap[columnId] = id;
    return returningMap;
  }

  // To construct Transaction from map
  Account.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    accountCategory = map[columnAccountCategory];
    initialBalance = map[columnInitialBalance];
    currentBalance = map[columnCurrentBalance];
    updatedDateTime = DateTime.parse(map[columnUpdatedDateTime]);
    createdDateTime = DateTime.parse(map[columnCreatedDateTime]);
    currencyId = map[columnCurrency];
  }

  Future postConstruct() async {
    currency = await CurrencyProvider
      .getInstance()
      .getCurrencyById(currencyId);
  }
}

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
    database = await openDatabase(path, version: 1);
  }

  Future<Account> insert(Account account) async {
    await open();
    account.id = await database.insert(accountTableName, account.toMap());
    await close();
    return account;
  }

  Future<Account> getAccount(int id) async {
    await open();
    List<Map> maps = await database.query(
      accountTableName,
      where: "$columnId = ?",
      whereArgs: [id]);
    await close();
    return maps.length > 0 ? new Account.fromMap(maps.first) : null;
  }

  Future<List<Account>> getAllAccounts() async {
    await open();
    List<Map> maps = await database.query(accountTableName);
    await close();
    return maps.map((map) => new Account.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    await open();
    var result = await database
      .delete(accountTableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return result;
  }

  Future<int> update(Account account) async {
    await open();
    var result = await database.update(accountTableName, account.toMap(),
      where: "$columnId = ?", whereArgs: [account.id]);
    await close();
    return result;
  }

  Future close() async => database?.close();
}
