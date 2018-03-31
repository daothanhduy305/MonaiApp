import 'package:monai/data/category.dart';
import 'package:monai/data/currency.dart';

class Account {
  // TODO: There might be icon in the future
  String name;
  double initialBalance, currentBalance;
  Currency currency;
  AccountCategory accountCategory;
}