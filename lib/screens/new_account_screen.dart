import 'package:flutter/material.dart';
import 'package:monai/data/account.dart';
import 'package:monai/data/currency.dart';
import 'package:monai/ebolo/widgets/ebolo_textfield.dart';

class NewAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewAccountScreenState();
}

class NewAccountScreenState extends State<NewAccountScreen> {
  Currency currentCurrency;
  String accountName, accountCategory, accountBalance;

  @override
  void initState() {
    super.initState();
    accountBalance = '0.0';
    accountName = '';
    accountCategory = '';
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text('New Account'),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.check),
                onPressed: () {
                  var account = new Account(
                      name: accountName,
                      initialBalance: double.parse(accountBalance),
                      currentBalance: double.parse(accountBalance),
                      accountCategory: accountCategory,
                      currency: currentCurrency);

                  AccountProvider
                      .getInstance()
                      .insert(account)
                      .then((value) => Navigator.pop(context, value));
                })
          ],
        ),
        body: new ListView(
          padding: EdgeInsets.only(top: 10.0),
          children: <Widget>[
            new ListTile(
              title: textBox(
                'Name',
                keyboardType: TextInputType.text,
                onChanged: (value) => accountName = value,
              ),
            ),
            new ListTile(
              title: textBox(
                'Category',
                keyboardType: TextInputType.text,
                onChanged: (value) => accountCategory = value,
              ),
            ),
            new ListTile(
              title: new Row(
                children: <Widget>[
                  new Expanded(
                    child: textBox(
                      'Initial balance',
                      keyboardType: TextInputType.number,
                      hintText: currentCurrency == null ? '' : '0',
                      onChanged: (value) => accountBalance = value,
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
            )
          ],
        ),
      );
}
