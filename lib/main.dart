import 'package:flutter/material.dart';
import 'package:monai/configs/general_configs.dart';
import 'package:monai/screens/account_manager_screen.dart';
import 'package:monai/screens/new_account_screen.dart';
import 'package:monai/screens/new_transaction_screen.dart';
import 'package:monai/screens/transaction_manager_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: APP_NAME,
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new TransactionManagerScreen(title: APP_NAME),
      routes: {
        "/new_transaction": (context) => new NewTransactionScreen(),
        "/account_manager": (context) => new AccountManagerScreen(),
        "/new_account": (context) => new NewAccountScreen(),
      },
    );
  }
}
