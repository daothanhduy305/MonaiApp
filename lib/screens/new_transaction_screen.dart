import 'package:flutter/material.dart';
import 'package:monai/data/account.dart';
import 'package:monai/data/currency.dart';
import 'package:monai/ebolo/widgets/ebolo_textfield.dart';

class NewTransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewTransactionScreenState();
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Add Transaction'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.check), onPressed: () {})
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 10.0),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: textBox(
                      'Transaction amount',
                      keyboardType: TextInputType.number,
                      hintText: currentCurrency == null ? '' : '0',
                      onChanged: (value) => transactionAmount = value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Builder(
                        builder: (context) => FlatButton(
                              child: Text(
                                currentCurrency == null
                                    ? 'Currency'
                                    : currentCurrency.shortName,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 18.0),
                              ),
                              onPressed: showCurrencyList,
                            )),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: textBox(
                'Category',
                keyboardType: TextInputType.text,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: textBox(
                'Note',
                keyboardType: TextInputType.text,
              ),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Theme(data: ThemeData(
                  disabledColor: Colors.black54
              ), child: textBox(
                'Date time',
                enabled: false,
              )),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Theme(data: ThemeData(
                disabledColor: Colors.black54
              ), child: textBox(
                currentAccounts.length > 0
                    ? currentAccounts[0].name
                    : 'Account',
                enabled: false,
              )),
              onTap: () {},
            ),
          ],
        ),
      );

  void showCurrencyList() =>
      CurrencyProvider
          .getInstance()
          .getAllCurrencies()
          .then((currencies) =>
          showModalBottomSheet(
              context: context,
              builder: (context) =>
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(top: 10.0),
                          children: currencies
                              .map((currency) =>
                              getCurrencyListItemUI(currency))
                              .toList(),
                        ),
                      )
                    ],
                  )));

  Widget getCurrencyListItemUI(Currency currency) =>
      ListTile(
        title: Text(currency.longName),
        onTap: () {
          setState(() {
            currentCurrency = currency;
            Navigator.pop(context);
          });
        },
      );
}
