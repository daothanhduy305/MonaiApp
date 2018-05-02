import 'package:flutter/material.dart';
import 'package:monai/data/account.dart';
import 'package:monai/data/currency.dart';

class NewTransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewTransactionScreenState();
}

class NewTransactionScreenState extends State<NewTransactionScreen> {
  List<Account> currentAccounts = [];
  Currency currentCurrency;
  String transactionAmount = '0.0';

  @override
  void initState() {
    super.initState();
    AccountProvider.getInstance().getAllAccounts().then(
        (accountList) => setState(() => currentAccounts.addAll(accountList)));
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text('Add Transaction'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.check), onPressed: () {})
          ],
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.monetization_on),
              title: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: currentCurrency == null ? '' : '0',
                          labelText: 'Transaction amount'),
                      onChanged: (value) => transactionAmount = value,
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(left: 10.0),
                    child: new Builder(
                        builder: (context) => new FlatButton(
                              child: new Text(
                                currentCurrency == null
                                    ? 'Currency'
                                    : currentCurrency.shortName,
                                style: new TextStyle(
                                    color: Colors.blue, fontSize: 18.0),
                              ),
                              onPressed: () {
                                CurrencyProvider
                                    .getInstance()
                                    .getAllCurrencies()
                                    .then((currencies) => showModalBottomSheet(
                                        context: context,
                                        builder: (context) => new Column(
                                              children: <Widget>[
                                                new Expanded(
                                                  child: new ListView(
                                                    padding:
                                                        new EdgeInsets.only(
                                                            top: 10.0),
                                                    children: currencies
                                                        .map((currency) =>
                                                            new ListTile(
                                                              title: new Text(
                                                                  currency
                                                                      .longName),
                                                              onTap: () {
                                                                setState(() {
                                                                  currentCurrency =
                                                                      currency;
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              },
                                                            ))
                                                        .toList(),
                                                  ),
                                                )
                                              ],
                                            )));
                              },
                            )),
                  )
                ],
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.category),
              title: new TextField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(hintText: 'Category'),
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.edit),
              title: new TextField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(hintText: 'Note'),
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.date_range),
              title: new Theme(data: new ThemeData(
                  disabledColor: Colors.black54
              ), child: new TextField(
                decoration: new InputDecoration(
                    hintText: 'Date time'),
                enabled: false,
              )),
              onTap: () {},
            ),
            new ListTile(
              leading: new Icon(Icons.account_balance_wallet),
              title: new Theme(data: new ThemeData(
                disabledColor: Colors.black54
              ), child: new TextField(
                decoration: new InputDecoration(
                    hintText: currentAccounts.length > 0
                        ? currentAccounts[0].name
                        : 'Account'),
                enabled: false,
              )),
              onTap: () {},
            ),
          ],
        ),
      );
}
