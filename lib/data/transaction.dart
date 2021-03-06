import 'dart:async';
import 'dart:io';

import 'package:monai/configs/general_configs.dart';
import 'package:monai/data/account.dart';
import 'package:monai/data/category.dart';
import 'package:monai/data/database_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Transaction {
  int id, categoryId, accountId;
  Account account;
  DateTime dateTime;
  String note;
  double amount;
  bool isIncome;
  TransactionCategory category;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returningMap = {
      columnNote: note,
      columnAmount: amount,
      columnCreatedDateTime: dateTime.toIso8601String(),
      columnCategory: category.id,
      columnAccount: account.id,
      columnIsIncome: isIncome
    };

    if (id != null) returningMap[columnId] = id;
    return returningMap;
  }

  // To construct Transaction from map
  Transaction.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    note = map[columnNote];
    amount = map[columnAmount];
    dateTime = DateTime.parse(map[columnCreatedDateTime]);
    accountId = map[columnAccount];
    categoryId = map[columnCategory];
    isIncome = map[columnIsIncome];
  }

  Future postConstruct() async {
    category =
        await TransactionCategoryProvider.getInstance().getCategory(categoryId);

    account = await AccountProvider.getInstance().getAccount(accountId);
  }
}

class TransactionProvider {
  // Singleton pattern
  static final TransactionProvider _transactionProvider =
      new TransactionProvider._internal();

  TransactionProvider._internal();

  static TransactionProvider getInstance() => _transactionProvider;

  Database database;

  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    database = await openDatabase(path, version: 1);
  }

  Future<Transaction> insert(Transaction transaction) async {
    await open();
    transaction.id =
        await database.insert(transactionTableName, transaction.toMap());
    await close();
    return transaction;
  }

  Future<Transaction> getTransaction(int id) async {
    await open();
    List<Map> maps = await database
        .query(transactionTableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return maps.length > 0 ? new Transaction.fromMap(maps.first) : null;
  }

  Future<List<Transaction>> getAllTransactions() async {
    await open();
    List<Map> maps = await database.query(
      transactionTableName,
    );
    await close();
    return maps.map((map) => new Transaction.fromMap(map)).toList();
  }

  Future<List<Transaction>> getIncomeTransactions() async {
    await open();
    List<Map> maps = await database.query(
      transactionTableName,
      where: "$columnIsIncome = ?",
      whereArgs: [1]
    );
    await close();
    return maps.map((map) => new Transaction.fromMap(map)).toList();
  }

  Future<List<Transaction>> getOutcomeTransactions() async {
    await open();
    List<Map> maps = await database.query(
        transactionTableName,
        where: "$columnIsIncome = ?",
        whereArgs: [0]
    );
    await close();
    return maps.map((map) => new Transaction.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    await open();
    var result = await database
        .delete(transactionTableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return result;
  }

  Future<int> update(Transaction transaction) async {
    await open();
    var result = await database.update(
        transactionTableName, transaction.toMap(),
        where: "$columnId = ?", whereArgs: [transaction.id]);
    await close();
    return result;
  }

  Future close() async => database.close();
}
