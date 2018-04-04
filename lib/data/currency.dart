import 'dart:async';
import 'dart:io';

import 'package:monai/configs/general_configs.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Currency {
  int id;
  String shortName, longName;

  // This would be the rate compare to US dollar
  double rate;
  DateTime updatedDateTime;

  Map toMap() {
    Map returningMap = {
      columnShortName: shortName,
      columnLongName: longName,
      columnRate: rate,
      columnUpdatedDateTime: updatedDateTime.toIso8601String(),
    };

    if (id != null) returningMap[columnId] = id;
    return returningMap;
  }

  // To construct Transaction from map
  Currency.fromMap(Map map) {
    id = map[columnId];
    shortName = map[columnShortName];
    longName = map[columnLongName];
    rate = map[columnRate];
    updatedDateTime = DateTime.parse(map[columnUpdatedDateTime]);
  }
}

const String tableName = "currencies";

const columnId = "_id";
const columnShortName = "s_name";
const columnLongName = "l_name";
const columnRate = "rate";
const columnUpdatedDateTime = "updated_date";

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
    database = await openDatabase(path, version: 1,
        // We would create our db if we have never done so
        onCreate: (db, ver) async {
      await db.execute('''
      create table $tableName(
       $columnId integer primary key autoincrement,
       $columnShortName text not null,
       $columnLongName text not null,
       $columnRate real not null,
       $columnUpdatedDateTime text not null
      );
      ''');
    });
  }

  Future<Currency> insert(Currency currency) async {
    await open();
    currency.id = await database.insert(tableName, currency.toMap());
    await close();
    return currency;
  }

  Future<Currency> getCurrency(int id) async {
    await open();
    List<Map> maps = await database.query(tableName,
        columns: [
          columnId,
          columnShortName,
          columnLongName,
          columnRate,
          columnUpdatedDateTime
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    await close();
    return maps.length > 0 ? new Currency.fromMap(maps.first) : null;
  }

  Future<List<Currency>> getAllCurrencies() async {
    await open();
    List<Map> maps = await database.query(
      tableName,
      columns: [
        columnId,
        columnShortName,
        columnLongName,
        columnRate,
        columnUpdatedDateTime
      ],
    );
    await close();
    return maps.map((map) => new Currency.fromMap(map)).toList();
  }

  Future<int> delete(int id) async {
    await open();
    var result = await database
        .delete(tableName, where: "$columnId = ?", whereArgs: [id]);
    await close();
    return result;
  }

  Future<int> update(Currency currency) async {
    await open();
    var result = await database.update(tableName, currency.toMap(),
        where: "$columnId = ?", whereArgs: [currency.id]);
    await close();
    return result;
  }

  Future close() async => database.close();
}
