import 'package:flutter/material.dart';
import 'package:monai/data/account.dart';

class AccountManagerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AccountManagerScreenState();
}

class AccountManagerScreenState extends State<AccountManagerScreen> {
  List<Account> currentAccounts;

  @override
  void initState() {
    super.initState();
    currentAccounts = [];
    AccountProvider.getInstance().getAllAccounts().then((value) =>
      setState(() => currentAccounts.addAll(value)));
  }

  @override
  Widget build(BuildContext context) =>
    new Scaffold(
      appBar: new AppBar(
        title: new Text('Acount Manager'),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/new_account").then((result) {
            if (result != null)
              setState(() => currentAccounts.add(result));
          });
        },
      ),
      body: new ListView(
        children: ListTile.divideTiles(context: context,
          tiles: currentAccounts.map((account) => buildAccountItemUI(account)))
          .toList(),
      ),
    );

  Widget buildAccountItemUI(Account account) =>
    new ListTile(
      title: new Text(account.name),
    );
}
