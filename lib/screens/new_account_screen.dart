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
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(labelText: 'Name'),
            ),
          ),
          new ListTile(
            title: new TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(labelText: 'Category'),
            ),
          ),
          new ListTile(
            title: new Row(
              children: <Widget>[
                new Expanded(child: new TextField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: currentCurrency == null ? '' : '0',
                    labelText: 'Initial balance'
                  ),
                ),),
                new Padding(
                  padding: new EdgeInsets.only(left: 10.0),
                  child: new Builder(builder: (context) =>
                  new FlatButton(
                    child: new Text(
                      currentCurrency == null
                        ? 'Currency'
                        : currentCurrency.shortName,
                      style: new TextStyle(color: Colors.blue, fontSize: 18.0),
                    ),
                    onPressed: () {
                      CurrencyProvider.getInstance().getAllCurrencies().then((
                        currencies) =>
                        showModalBottomSheet(
                          context: context, builder: (context) =>
                        new Column(
                          children: <Widget>[
                            new Expanded(child: new ListView(
                              padding: new EdgeInsets.only(top: 10.0),
                              children: currencies.map((currency) =>
                              new ListTile(
                                title: new Text(currency.longName),
                                onTap: () {
                                  setState(() {
                                    currentCurrency = currency;
                                    Navigator.pop(context);
                                  });
                                },
                              )).toList(),
                            ),)
                          ],
                        ))
                      );
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
