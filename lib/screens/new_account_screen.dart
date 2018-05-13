import 'package:flutter/material.dart';
import 'package:monai/data/account.dart';
import 'package:monai/data/currency.dart';
import 'package:monai/ebolo/utils/ebolo_snackbar_utils.dart';
import 'package:monai/ebolo/widgets/ebolo_textfield.dart';

class NewAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewAccountScreenState();
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
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () => createNewAccount(context)
              ),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 10.0),
          children: <Widget>[
            ListTile(
              title: textBox(
                'Name',
                keyboardType: TextInputType.text,
                onChanged: (value) => accountName = value,
              ),
            ),
            ListTile(
              title: textBox(
                'Category',
                keyboardType: TextInputType.text,
                onChanged: (value) => accountCategory = value,
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: textBox(
                      'Initial balance',
                      keyboardType: TextInputType.number,
                      hintText: currentCurrency == null ? '' : '0',
                      onChanged: (value) => accountBalance = value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Builder(
                        builder: (context) =>
                            FlatButton(
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
            )
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

  void createNewAccount(BuildContext context) {
    // Check the data first
    if (accountName.isEmpty) {
      showErrorSnackbar(context, 'Acount name must be filled!');
      return;
    }

    if (currentCurrency == null) {
      showErrorSnackbar(context, 'Acount must have its own currency!');
      return;
    }

    var account = Account(
        name: accountName,
        initialBalance: accountBalance.isEmpty
            ? 0.0
            : double.parse(accountBalance),
        currentBalance: accountBalance.isEmpty
            ? 0.0
            : double.parse(accountBalance),
        accountCategory: accountCategory,
        currency: currentCurrency);

    AccountProvider
        .getInstance()
        .insert(account)
        .then((value) => Navigator.pop(context, value));
  }
}
