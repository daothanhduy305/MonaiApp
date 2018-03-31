import 'package:monai/data/account.dart';
import 'package:monai/data/category.dart';

class Transaction {
  Account account;
  DateTime dateTime;
  String note;
  double amount;
  Category category;
}