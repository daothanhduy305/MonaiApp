import 'package:flutter/material.dart';
import 'package:monai/data/currency.dart';

class NewAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewAccountScreenState();
}

class NewAccountScreenState extends State<NewAccountScreen> {
  Currency currentCurrency;

  @override
  Widget build(BuildContext context) =>
    new Scaffold(
      appBar: new AppBar(
        title: new Text('New Account'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.check), onPressed: () {})
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: 'Name'),
            ),
          ),
          new ListTile(
            title: new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: 'Category'),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(child: new ListTile(
                title: new TextField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(hintText: currentCurrency == null? '' : '0.0'),
                ),
                trailing: currentCurrency == null? null : new Text(currentCurrency.shortName),
              ),),
              new Builder(builder: (context) => new FlatButton(
                child: new Text(currentCurrency == null? 'Currency' : currentCurrency.shortName),
                onPressed: () {
                  CurrencyProvider.getInstance().getAllCurrencies().then((currencies) => showModalBottomSheet(context: context, builder: (context) => new Container(
                    child: new ListView(
                      padding: new EdgeInsets.only(top: 10.0),
                      children: currencies.map((currency) => new ListTile(title: new Text(currency.longName),)).toList(),
                    ),
                  )));
                },
              ))
            ],
          ),
        ],
      ),
    );
}
