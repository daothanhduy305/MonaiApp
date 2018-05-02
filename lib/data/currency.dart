import 'dart:async';
import 'dart:io';

import 'package:monai/configs/general_configs.dart';
import 'package:monai/data/database_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Currency {
  int id;
  String shortName, longName;

  // This would be the rate compare to US dollar
  double rate = 0.0;
  DateTime updatedDateTime;

  Currency({this.shortName, this.longName}) {
    this.updatedDateTime = new DateTime.now();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returningMap = {
      columnShortName: shortName,
      columnLongName: longName,
      columnRate: rate,
      columnUpdatedDateTime: updatedDateTime.toIso8601String(),
    };

    if (id != null) returningMap[columnId] = id;
    return returningMap;
  }

  // To construct Transaction from map
  Currency.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    shortName = map[columnShortName];
    longName = map[columnLongName];
    rate = map[columnRate];
    updatedDateTime = DateTime.parse(map[columnUpdatedDateTime]);
  }
}

class CurrencyProvider {
  // Singleton pattern
  static final CurrencyProvider _currencyProvider =
      new CurrencyProvider._internal();

  CurrencyProvider._internal();

  static CurrencyProvider getInstance() => _currencyProvider;

  Database database;

  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    database = await openDatabase(path, version: 1);
  }

  Future<Currency> insert(Currency currency) async {
    await open();
    currency.id = await database.insert(currencyTableName, currency.toMap());
    await close();
    return currency;
  }

  Future<Currency> getCurrencyById(int id) async {
    await open();
    List<Map> maps = await database
        .query(currencyTableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return maps.length > 0 ? new Currency.fromMap(maps.first) : null;
  }

  Future<Currency> getCurrencyByShortName(String shortName) async {
    await open();
    List<Map> maps = await database.query(currencyTableName,
        where: "$columnShortName like ?", whereArgs: [shortName]);
    await close();
    return maps.length > 0 ? new Currency.fromMap(maps.first) : null;
  }

  Future<List<Currency>> getAllCurrencies() async {
    await open();
    List<Map> maps = await database.query(currencyTableName);
    await close();
    return maps.map((map) => new Currency.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    await open();
    var result = await database
        .delete(currencyTableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return result;
  }

  Future<int> update(Currency currency) async {
    await open();
    var result = await database.update(currencyTableName, currency.toMap(),
        where: "$columnId = ?", whereArgs: [currency.id]);
    await close();
    return result;
  }

  Future close() async => database?.close();
}
