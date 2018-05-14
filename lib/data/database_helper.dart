import 'dart:async';
import 'dart:io';

import 'package:monai/configs/general_configs.dart';
import 'package:monai/data/currency.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String currencyTableName = "currencies";

const columnId = "_id";
const columnShortName = "s_name";
const columnLongName = "l_name";
const columnRate = "rate";
const columnUpdatedDateTime = "updated_date";

const String accountTableName = "accounts";

const columnName = "name";
const columnInitialBalance = "i_balance";
const columnCurrentBalance = "c_balance";
const columnCurrency = "currency";
const columnAccountCategory = "category";
const columnCreatedDateTime = "created_date";

const String transactionTableName = "transactions";

const columnNote = "note";
const columnAmount = "amount";
const columnCategory = "category";
const columnAccount = "account";
const columnIsIncome = "is_income";

const String transactionCategoryTableName = "transaction_categories";

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _databaseHelper = new DatabaseHelper._internal();

  DatabaseHelper._internal();

  static DatabaseHelper getInstance() => _databaseHelper;

  Database database;

  Future initializeDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    database = await openDatabase(path, version: 1, onCreate: (db, ver) async {
      var batch = db.batch();

      // Initialize currency table
      batch.execute('''
      create table $currencyTableName(
       $columnId integer primary key autoincrement,
       $columnShortName text not null,
       $columnLongName text not null,
       $columnRate real not null,
       $columnUpdatedDateTime text not null
      );
      ''');
      batch.insert(
          currencyTableName,
          (new Currency(
                  shortName: 'AED', longName: 'United Arab Emirates Dirham'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'AFN', longName: 'Afghan Afghani')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'ALL', longName: 'Albanian Lek')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'AMD', longName: 'Armenian Dram')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(
                  shortName: 'ANG', longName: 'Netherlands Antillean Guilder'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'AOA', longName: 'Angolan Kwanza')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'ARS', longName: 'Argentine Peso')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'AUD', longName: 'Australian Dollar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'AWG', longName: 'Aruban Florin')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'AZN', longName: 'Azerbaijani Manat'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(
                  shortName: 'BAM',
                  longName: 'Bosnia-Herzegovina Convertible Mark'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'BBD', longName: 'Barbadian Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'BDT', longName: 'Bangladeshi Taka'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'BGN', longName: 'Bulgarian Lev')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'BHD', longName: 'Bahraini Dinar')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'BIF', longName: 'Burundian Franc'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'BMD', longName: 'Bermudan Dollar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'BND', longName: 'Brunei Dollar')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'BOB', longName: 'Bolivian Boliviano'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'BRL', longName: 'Brazilian Real')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'BSD', longName: 'Bahamian Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'BTN', longName: 'Bhutanese Ngultrum'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'BWP', longName: 'Botswanan Pula')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'BZD', longName: 'Belize Dollar')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'CAD', longName: 'Canadian Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'CDF', longName: 'Congolese Franc'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'CHF', longName: 'Swiss Franc')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(
                  shortName: 'CLF', longName: 'Chilean Unit of Account UF'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'CLP', longName: 'Chilean Peso')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'CNH', longName: 'Chinese Yuan Offshore'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'CNY', longName: 'Chinese Yuan')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'COP', longName: 'Colombian Peso')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'CUP', longName: 'Cuban Peso')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'CVE', longName: 'Cape Verdean Escudo'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'CZK', longName: 'Czech Republic Koruna'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'DJF', longName: 'Djiboutian Franc'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'DKK', longName: 'Danish Krone')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'DOP', longName: 'Dominican Peso')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'DZD', longName: 'Algerian Dinar')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'EGP', longName: 'Egyptian Pound')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'ERN', longName: 'Eritrean Nakfa')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'ETB', longName: 'Ethiopian Birr')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'EUR', longName: 'Euro')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'FJD', longName: 'Fijian Dollar')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'FKP', longName: 'Falkland Islands Pound'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'GBP', longName: 'British Pound Sterling'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'GEL', longName: 'Georgian Lari')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'GHS', longName: 'Ghanaian Cedi')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'GIP', longName: 'Gibraltar Pound'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'GMD', longName: 'Gambian Dalasi')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'GNF', longName: 'Guinean Franc')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'GTQ', longName: 'Guatemalan Quetzal'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'GYD', longName: 'Guyanaese Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'HKD', longName: 'Hong Kong Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'HNL', longName: 'Honduran Lempira'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'HRK', longName: 'Croatian Kuna')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'HTG', longName: 'Haitian Gourde')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'HUF', longName: 'Hungarian Forint'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'IDR', longName: 'Indonesian Rupiah'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'ILS', longName: 'Israeli New Sheqel'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'INR', longName: 'Indian Rupee')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'IQD', longName: 'Iraqi Dinar')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'IRR', longName: 'Iranian Rial')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'JEP', longName: 'Jersey Pound')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'JMD', longName: 'Jamaican Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'JOD', longName: 'Jordanian Dinar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'JPY', longName: 'Japanese Yen')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'KES', longName: 'Kenyan Shilling'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'KGS', longName: 'Kyrgystani Som')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'KHR', longName: 'Cambodian Riel')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'KMF', longName: 'Comorian Franc')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'KPW', longName: 'North Korean Won'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'KRW', longName: 'South Korean Won'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'KWD', longName: 'Kuwaiti Dinar')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'KYD', longName: 'Cayman Islands Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'KZT', longName: 'Kazakhstani Tenge'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'LAK', longName: 'Laotian Kip')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'LBP', longName: 'Lebanese Pound')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'LKR', longName: 'Sri Lankan Rupee'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'LRD', longName: 'Liberian Dollar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'LSL', longName: 'Lesotho Loti')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'LYD', longName: 'Libyan Dinar')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MAD', longName: 'Moroccan Dirham'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'MDL', longName: 'Moldovan Leu')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MGA', longName: 'Malagasy Ariary'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MKD', longName: 'Macedonian Denar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'MMK', longName: 'Myanma Kyat')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MNT', longName: 'Mongolian Tugrik'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MOP', longName: 'Macanese Pataca'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(
                  shortName: 'MRO', longName: 'Mauritanian Ouguiya (pre-2018)'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MRU', longName: 'Mauritanian Ouguiya'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MUR', longName: 'Mauritian Rupee'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MVR', longName: 'Maldivian Rufiyaa'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MWK', longName: 'Malawian Kwacha'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'MXN', longName: 'Mexican Peso')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MYR', longName: 'Malaysian Ringgit'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'MZN', longName: 'Mozambican Metical'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'NAD', longName: 'Namibian Dollar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'NGN', longName: 'Nigerian Naira')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'NOK', longName: 'Norwegian Krone'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'NPR', longName: 'Nepalese Rupee')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'NZD', longName: 'New Zealand Dollar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'OMR', longName: 'Omani Rial')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'PAB', longName: 'Panamanian Balboa'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'PEN', longName: 'Peruvian Nuevo Sol'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'PGK', longName: 'Papua New Guinean Kina'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'PHP', longName: 'Philippine Peso'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'PKR', longName: 'Pakistani Rupee'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'PLN', longName: 'Polish Zloty')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'PYG', longName: 'Paraguayan Guarani'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'QAR', longName: 'Qatari Rial')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'RON', longName: 'Romanian Leu')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'RSD', longName: 'Serbian Dinar')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'RUB', longName: 'Russian Ruble')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'RUR', longName: 'Old Russian Ruble'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'RWF', longName: 'Rwandan Franc')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'SAR', longName: 'Saudi Riyal')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'SBDf', longName: 'Solomon Islands Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'SCR', longName: 'Seychellois Rupee'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'SDG', longName: 'Sudanese Pound')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'SEK', longName: 'Swedish Krona')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'SGD', longName: 'Singapore Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'SHP', longName: 'Saint Helena Pound'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'SLL', longName: 'Sierra Leonean Leone'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'SOS', longName: 'Somali Shilling'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'SRD', longName: 'Surinamese Dollar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'SYP', longName: 'Syrian Pound')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'SZL', longName: 'Swazi Lilangeni'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'THB', longName: 'Thai Baht')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'TJS', longName: 'Tajikistani Somoni'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'TMT', longName: 'Turkmenistani Manat'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'TND', longName: 'Tunisian Dinar')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'TOP', longName: 'Tongan Pa\'anga'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'TRY', longName: 'Turkish Lira')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(
                  shortName: 'TTD', longName: 'Trinidad and Tobago Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'TWD', longName: 'New Taiwan Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'TZS', longName: 'Tanzanian Shilling'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'UAH', longName: 'Ukrainian Hryvnia'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'UGX', longName: 'Ugandan Shilling'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'USD', longName: 'United States Dollar'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'UYU', longName: 'Uruguayan Peso')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'UZS', longName: 'Uzbekistan Som')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'VND', longName: 'Vietnamese Dong'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'VUV', longName: 'Vanuatu Vatu')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'WST', longName: 'Samoan Tala')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'XAF', longName: 'CFA Franc BEAC')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'XAG', longName: 'Silver Ounce')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'XAU', longName: 'Gold Ounce')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'XCD', longName: 'East Caribbean Dollar'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'XDR', longName: 'Special Drawing Rights'))
              .toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'XOF', longName: 'CFA Franc BCEAO'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'XPF', longName: 'CFP Franc')).toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'YER', longName: 'Yemeni Rial')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'ZAR', longName: 'South African Rand'))
              .toMap());
      batch.insert(currencyTableName,
          (new Currency(shortName: 'ZMW', longName: 'Zambian Kwacha')).toMap());
      batch.insert(
          currencyTableName,
          (new Currency(shortName: 'ZWL', longName: 'Zimbabwean Dollar'))
              .toMap());
      // End of initializing currency table

      // Initialize account table
      batch.execute('''
      create table $accountTableName(
       $columnId integer primary key autoincrement,
       $columnName text not null,
       $columnInitialBalance real not null,
       $columnCurrentBalance real not null,
       $columnCurrency integer not null,
       $columnAccountCategory text not null,
       $columnUpdatedDateTime text not null,
       $columnCreatedDateTime text not null
      );
      ''');
      // End of initializing account table

      // Initialize transaction category table
      batch.execute('''
      create table $transactionCategoryTableName(
       $columnId integer primary key autoincrement,
       $columnName text not null
      );
      ''');
      // End of initializing transaction category table

      // Initialize transaction table
      batch.execute('''
      create table $transactionTableName(
       $columnId integer primary key autoincrement,
       $columnNote text not null,
       $columnAmount real not null,
       $columnCreatedDateTime text not null,
       $columnCategory integer not null,
       $columnAccount integer not null
      );
      ''');
      // End of initializing transaction table

      await batch.commit(noResult: true);
    });
    await database.close();
  }
}
