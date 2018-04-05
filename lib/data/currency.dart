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
  double rate = 0.0;
  DateTime updatedDateTime;

  Currency({this.shortName, this.longName}) {
    this.updatedDateTime = new DateTime.now();
  }

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
        db.insert(tableName, (new Currency(
          shortName: 'AED', longName: 'United Arab Emirates Dirham'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'AFN', longName: 'Afghan Afghani')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'ALL', longName: 'Albanian Lek'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'AMD', longName: 'Armenian Dram'))
            .toMap());
        db.insert(tableName, (new Currency(shortName: 'ANG',
          longName: 'Netherlands Antillean Guilder')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'AOA', longName: 'Angolan Kwanza')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ARS', longName: 'Argentine Peso')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'AUD', longName: 'Australian Dollar')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'AWG', longName: 'Aruban Florin'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'AZN', longName: 'Azerbaijani Manat')).toMap());
        db.insert(tableName, (new Currency(shortName: 'BAM',
          longName: 'Bosnia-Herzegovina Convertible Mark')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BBD', longName: 'Barbadian Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BDT', longName: 'Bangladeshi Taka')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'BGN', longName: 'Bulgarian Lev'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BHD', longName: 'Bahraini Dinar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BIF', longName: 'Burundian Franc')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BMD', longName: 'Bermudan Dollar')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'BND', longName: 'Brunei Dollar'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BOB', longName: 'Bolivian Boliviano'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BRL', longName: 'Brazilian Real')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BSD', longName: 'Bahamian Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BTN', longName: 'Bhutanese Ngultrum'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BWP', longName: 'Botswanan Pula')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'BZD', longName: 'Belize Dollar'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CAD', longName: 'Canadian Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CDF', longName: 'Congolese Franc')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'CHF', longName: 'Swiss Franc'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CLF', longName: 'Chilean Unit of Account UF'))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'CLP', longName: 'Chilean Peso'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CNH', longName: 'Chinese Yuan Offshore'))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'CNY', longName: 'Chinese Yuan'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'COP', longName: 'Colombian Peso')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'CUP', longName: 'Cuban Peso'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CVE', longName: 'Cape Verdean Escudo'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CZK', longName: 'Czech Republic Koruna'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'DJF', longName: 'Djiboutian Franc')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'DKK', longName: 'Danish Krone'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'DOP', longName: 'Dominican Peso')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'DZD', longName: 'Algerian Dinar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'EGP', longName: 'Egyptian Pound')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ERN', longName: 'Eritrean Nakfa')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ETB', longName: 'Ethiopian Birr')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'EUR', longName: 'Euro'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'FJD', longName: 'Fijian Dollar'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'FKP', longName: 'Falkland Islands Pound'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GBP', longName: 'British Pound Sterling'))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'GEL', longName: 'Georgian Lari'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'GHS', longName: 'Ghanaian Cedi'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GIP', longName: 'Gibraltar Pound')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GMD', longName: 'Gambian Dalasi')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'GNF', longName: 'Guinean Franc'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GTQ', longName: 'Guatemalan Quetzal'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GYD', longName: 'Guyanaese Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'HKD', longName: 'Hong Kong Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'HNL', longName: 'Honduran Lempira')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'HRK', longName: 'Croatian Kuna'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'HTG', longName: 'Haitian Gourde')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'HUF', longName: 'Hungarian Forint')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'IDR', longName: 'Indonesian Rupiah')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ILS', longName: 'Israeli New Sheqel'))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'INR', longName: 'Indian Rupee'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'IQD', longName: 'Iraqi Dinar'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'IRR', longName: 'Iranian Rial'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'JEP', longName: 'Jersey Pound'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'JMD', longName: 'Jamaican Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'JOD', longName: 'Jordanian Dinar')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'JPY', longName: 'Japanese Yen'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KES', longName: 'Kenyan Shilling')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KGS', longName: 'Kyrgystani Som')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KHR', longName: 'Cambodian Riel')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KMF', longName: 'Comorian Franc')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KPW', longName: 'North Korean Won')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KRW', longName: 'South Korean Won')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'KWD', longName: 'Kuwaiti Dinar'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KYD', longName: 'Cayman Islands Dollar'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KZT', longName: 'Kazakhstani Tenge')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'LAK', longName: 'Laotian Kip'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'LBP', longName: 'Lebanese Pound')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'LKR', longName: 'Sri Lankan Rupee')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'LRD', longName: 'Liberian Dollar')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'LSL', longName: 'Lesotho Loti'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'LYD', longName: 'Libyan Dinar'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MAD', longName: 'Moroccan Dirham')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'MDL', longName: 'Moldovan Leu'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MGA', longName: 'Malagasy Ariary')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MKD', longName: 'Macedonian Denar')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'MMK', longName: 'Myanma Kyat'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MNT', longName: 'Mongolian Tugrik')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MOP', longName: 'Macanese Pataca')).toMap());
        db.insert(tableName, (new Currency(shortName: 'MRO',
          longName: 'Mauritanian Ouguiya (pre-2018)')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MRU', longName: 'Mauritanian Ouguiya'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MUR', longName: 'Mauritian Rupee')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MVR', longName: 'Maldivian Rufiyaa')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MWK', longName: 'Malawian Kwacha')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'MXN', longName: 'Mexican Peso'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MYR', longName: 'Malaysian Ringgit')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MZN', longName: 'Mozambican Metical'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NAD', longName: 'Namibian Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NGN', longName: 'Nigerian Naira')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NOK', longName: 'Norwegian Krone')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NPR', longName: 'Nepalese Rupee')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NZD', longName: 'New Zealand Dollar'))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'OMR', longName: 'Omani Rial'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PAB', longName: 'Panamanian Balboa')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PEN', longName: 'Peruvian Nuevo Sol'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PGK', longName: 'Papua New Guinean Kina'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PHP', longName: 'Philippine Peso')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PKR', longName: 'Pakistani Rupee')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'PLN', longName: 'Polish Zloty'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PYG', longName: 'Paraguayan Guarani'))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'QAR', longName: 'Qatari Rial'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'RON', longName: 'Romanian Leu'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'RSD', longName: 'Serbian Dinar'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'RUB', longName: 'Russian Ruble'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'RUR', longName: 'Old Russian Ruble')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'RWF', longName: 'Rwandan Franc'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'SAR', longName: 'Saudi Riyal'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SBDf', longName: 'Solomon Islands Dollar'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SCR', longName: 'Seychellois Rupee')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SDG', longName: 'Sudanese Pound')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'SEK', longName: 'Swedish Krona'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SGD', longName: 'Singapore Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SHP', longName: 'Saint Helena Pound'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SLL', longName: 'Sierra Leonean Leone'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SOS', longName: 'Somali Shilling')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SRD', longName: 'Surinamese Dollar')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'SYP', longName: 'Syrian Pound'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SZL', longName: 'Swazi Lilangeni')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'THB', longName: 'Thai Baht'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TJS', longName: 'Tajikistani Somoni'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TMT', longName: 'Turkmenistani Manat'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TND', longName: 'Tunisian Dinar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TOP', longName: 'Tongan Pa\'anga')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'TRY', longName: 'Turkish Lira'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TTD', longName: 'Trinidad and Tobago Dollar'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TWD', longName: 'New Taiwan Dollar')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TZS', longName: 'Tanzanian Shilling'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'UAH', longName: 'Ukrainian Hryvnia')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'UGX', longName: 'Ugandan Shilling')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'USD', longName: 'United States Dollar'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'UYU', longName: 'Uruguayan Peso')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'UZS', longName: 'Uzbekistan Som')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'VND', longName: 'Vietnamese Dong')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'VUV', longName: 'Vanuatu Vatu'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'WST', longName: 'Samoan Tala'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'XAF', longName: 'CFA Franc BEAC')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'XAG', longName: 'Silver Ounce'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'XAU', longName: 'Gold Ounce'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'XCD', longName: 'East Caribbean Dollar'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'XDR', longName: 'Special Drawing Rights'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'XOF', longName: 'CFA Franc BCEAO')).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'XPF', longName: 'CFP Franc'))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'YER', longName: 'Yemeni Rial'))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ZAR', longName: 'South African Rand'))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ZMW', longName: 'Zambian Kwacha')).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ZWL', longName: 'Zimbabwean Dollar')).toMap());
      });
  }

  Future<Currency> insert(Currency currency) async {
    await open();
    currency.id = await database.insert(tableName, currency.toMap());
    await close();
    return currency;
  }

  Future<Currency> getCurrencyById(int id) async {
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

  Future<Currency> getCurrencyByShortName(String shortName) async {
    await open();
    List<Map> maps = await database.query(tableName,
      columns: [
        columnId,
        columnShortName,
        columnLongName,
        columnRate,
        columnUpdatedDateTime
      ],
      where: "$columnShortName like ?",
      whereArgs: [shortName]);
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

  Future close() async => database?.close();
}
