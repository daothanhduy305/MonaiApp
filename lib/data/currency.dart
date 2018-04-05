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

  Currency({this.rate, this.shortName, this.longName}) {
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
          shortName: 'AED', longName: 'United Arab Emirates Dirham', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'AFN', longName: 'Afghan Afghani', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'ALL', longName: 'Albanian Lek', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'AMD', longName: 'Armenian Dram', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(shortName: 'ANG',
          longName: 'Netherlands Antillean Guilder',
          rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'AOA', longName: 'Angolan Kwanza', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ARS', longName: 'Argentine Peso', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'AUD', longName: 'Australian Dollar', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'AWG', longName: 'Aruban Florin', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'AZN', longName: 'Azerbaijani Manat', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(shortName: 'BAM',
          longName: 'Bosnia-Herzegovina Convertible Mark',
          rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BBD', longName: 'Barbadian Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BDT', longName: 'Bangladeshi Taka', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'BGN', longName: 'Bulgarian Lev', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BHD', longName: 'Bahraini Dinar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BIF', longName: 'Burundian Franc', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BMD', longName: 'Bermudan Dollar', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'BND', longName: 'Brunei Dollar', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BOB', longName: 'Bolivian Boliviano', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BRL', longName: 'Brazilian Real', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BSD', longName: 'Bahamian Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BTN', longName: 'Bhutanese Ngultrum', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'BWP', longName: 'Botswanan Pula', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'BZD', longName: 'Belize Dollar', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CAD', longName: 'Canadian Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CDF', longName: 'Congolese Franc', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'CHF', longName: 'Swiss Franc', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CLF', longName: 'Chilean Unit of Account UF', rate: 0.0))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'CLP', longName: 'Chilean Peso', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CNH', longName: 'Chinese Yuan Offshore', rate: 0.0))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'CNY', longName: 'Chinese Yuan', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'COP', longName: 'Colombian Peso', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'CUP', longName: 'Cuban Peso', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CVE', longName: 'Cape Verdean Escudo', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'CZK', longName: 'Czech Republic Koruna', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'DJF', longName: 'Djiboutian Franc', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'DKK', longName: 'Danish Krone', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'DOP', longName: 'Dominican Peso', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'DZD', longName: 'Algerian Dinar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'EGP', longName: 'Egyptian Pound', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ERN', longName: 'Eritrean Nakfa', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ETB', longName: 'Ethiopian Birr', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'EUR', longName: 'Euro', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'FJD', longName: 'Fijian Dollar', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'FKP', longName: 'Falkland Islands Pound', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GBP', longName: 'British Pound Sterling', rate: 0.0))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'GEL', longName: 'Georgian Lari', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'GHS', longName: 'Ghanaian Cedi', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GIP', longName: 'Gibraltar Pound', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GMD', longName: 'Gambian Dalasi', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'GNF', longName: 'Guinean Franc', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GTQ', longName: 'Guatemalan Quetzal', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'GYD', longName: 'Guyanaese Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'HKD', longName: 'Hong Kong Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'HNL', longName: 'Honduran Lempira', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'HRK', longName: 'Croatian Kuna', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'HTG', longName: 'Haitian Gourde', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'HUF', longName: 'Hungarian Forint', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'IDR', longName: 'Indonesian Rupiah', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ILS', longName: 'Israeli New Sheqel', rate: 0.0))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'INR', longName: 'Indian Rupee', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'IQD', longName: 'Iraqi Dinar', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'IRR', longName: 'Iranian Rial', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'JEP', longName: 'Jersey Pound', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'JMD', longName: 'Jamaican Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'JOD', longName: 'Jordanian Dinar', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'JPY', longName: 'Japanese Yen', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KES', longName: 'Kenyan Shilling', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KGS', longName: 'Kyrgystani Som', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KHR', longName: 'Cambodian Riel', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KMF', longName: 'Comorian Franc', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KPW', longName: 'North Korean Won', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KRW', longName: 'South Korean Won', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'KWD', longName: 'Kuwaiti Dinar', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KYD', longName: 'Cayman Islands Dollar', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'KZT', longName: 'Kazakhstani Tenge', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'LAK', longName: 'Laotian Kip', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'LBP', longName: 'Lebanese Pound', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'LKR', longName: 'Sri Lankan Rupee', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'LRD', longName: 'Liberian Dollar', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'LSL', longName: 'Lesotho Loti', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'LYD', longName: 'Libyan Dinar', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MAD', longName: 'Moroccan Dirham', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'MDL', longName: 'Moldovan Leu', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MGA', longName: 'Malagasy Ariary', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MKD', longName: 'Macedonian Denar', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'MMK', longName: 'Myanma Kyat', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MNT', longName: 'Mongolian Tugrik', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MOP', longName: 'Macanese Pataca', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(shortName: 'MRO',
          longName: 'Mauritanian Ouguiya (pre-2018)',
          rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MRU', longName: 'Mauritanian Ouguiya', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MUR', longName: 'Mauritian Rupee', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MVR', longName: 'Maldivian Rufiyaa', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MWK', longName: 'Malawian Kwacha', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'MXN', longName: 'Mexican Peso', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MYR', longName: 'Malaysian Ringgit', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'MZN', longName: 'Mozambican Metical', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NAD', longName: 'Namibian Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NGN', longName: 'Nigerian Naira', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NOK', longName: 'Norwegian Krone', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NPR', longName: 'Nepalese Rupee', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'NZD', longName: 'New Zealand Dollar', rate: 0.0))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'OMR', longName: 'Omani Rial', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PAB', longName: 'Panamanian Balboa', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PEN', longName: 'Peruvian Nuevo Sol', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PGK', longName: 'Papua New Guinean Kina', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PHP', longName: 'Philippine Peso', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PKR', longName: 'Pakistani Rupee', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'PLN', longName: 'Polish Zloty', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'PYG', longName: 'Paraguayan Guarani', rate: 0.0))
          .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'QAR', longName: 'Qatari Rial', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'RON', longName: 'Romanian Leu', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'RSD', longName: 'Serbian Dinar', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'RUB', longName: 'Russian Ruble', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'RUR', longName: 'Old Russian Ruble', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'RWF', longName: 'Rwandan Franc', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'SAR', longName: 'Saudi Riyal', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SBDf', longName: 'Solomon Islands Dollar', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SCR', longName: 'Seychellois Rupee', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SDG', longName: 'Sudanese Pound', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'SEK', longName: 'Swedish Krona', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SGD', longName: 'Singapore Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SHP', longName: 'Saint Helena Pound', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SLL', longName: 'Sierra Leonean Leone', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SOS', longName: 'Somali Shilling', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SRD', longName: 'Surinamese Dollar', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'SYP', longName: 'Syrian Pound', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'SZL', longName: 'Swazi Lilangeni', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'THB', longName: 'Thai Baht', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TJS', longName: 'Tajikistani Somoni', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TMT', longName: 'Turkmenistani Manat', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TND', longName: 'Tunisian Dinar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TOP', longName: 'Tongan Pa\'anga', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'TRY', longName: 'Turkish Lira', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TTD', longName: 'Trinidad and Tobago Dollar', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TWD', longName: 'New Taiwan Dollar', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'TZS', longName: 'Tanzanian Shilling', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'UAH', longName: 'Ukrainian Hryvnia', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'UGX', longName: 'Ugandan Shilling', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'USD', longName: 'United States Dollar', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'UYU', longName: 'Uruguayan Peso', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'UZS', longName: 'Uzbekistan Som', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'VND', longName: 'Vietnamese Dong', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'VUV', longName: 'Vanuatu Vatu', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'WST', longName: 'Samoan Tala', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'XAF', longName: 'CFA Franc BEAC', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'XAG', longName: 'Silver Ounce', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'XAU', longName: 'Gold Ounce', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'XCD', longName: 'East Caribbean Dollar', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'XDR', longName: 'Special Drawing Rights', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'XOF', longName: 'CFA Franc BCEAO', rate: 0.0)).toMap());
        db.insert(tableName,
          (new Currency(shortName: 'XPF', longName: 'CFP Franc', rate: 0.0))
            .toMap());
        db.insert(tableName,
          (new Currency(shortName: 'YER', longName: 'Yemeni Rial', rate: 0.0))
            .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ZAR', longName: 'South African Rand', rate: 0.0))
          .toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ZMW', longName: 'Zambian Kwacha', rate: 0.0)).toMap());
        db.insert(tableName, (new Currency(
          shortName: 'ZWL', longName: 'Zimbabwean Dollar', rate: 0.0)).toMap());
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

  Future close() async => database.close();
}
