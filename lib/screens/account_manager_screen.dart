import 'package:flutter/material.dart';
import 'package:monai/data/account.dart';

class AccountManagerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountManagerScreenState();
}

class AccountManagerScreenState extends State<AccountManagerScreen> {
  List<Account> currentAccounts;

  @override
  void initState() {
    super.initState();
    currentAccounts = [];
    AccountProvider.getInstance().getAllAccounts().then((accountList) =>
        accountList.forEach((account) => account.postConstruct().then(
            (updatedAccount) =>
                setState(() => currentAccounts.add(updatedAccount)))));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Acount Manager'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("/new_account").then((result) {
              if (result != null) setState(() => currentAccounts.add(result));
            });
          },
        ),
        body: ListView(
          children: ListTile
              .divideTiles(
                  context: context,
                  tiles: currentAccounts
                      .map((account) => buildAccountItemUI(account)))
              .toList(),
        ),
      );

  Widget buildAccountItemUI(Account account) => ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(account.name),
        subtitle: Text('${account.currentBalance.toString()} '
            '(${account.currency.shortName})'),
        trailing: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            )
          ],
        ),
    onTap: () => Navigator.of(context).pop(account),
      );
}
