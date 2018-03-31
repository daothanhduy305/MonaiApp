import 'package:flutter/material.dart';

class AccountManagerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AccountManagerScreenState();

}

class AccountManagerScreenState extends State<AccountManagerScreen> {
  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('Acount Manager'),
    ),
    floatingActionButton: new FloatingActionButton(
      child: new Icon(Icons.add),
      onPressed: () {

      },
    ),
  );

}