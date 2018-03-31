import 'package:flutter/material.dart';

class NewTransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewTransactionScreenState();
}

class NewTransactionScreenState extends State<NewTransactionScreen> {
  @override
  Widget build(BuildContext context) =>
      new Scaffold(
        appBar: new AppBar(
          title: new Text('Add Transaction'
          ),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.check),
                onPressed: () {

                }
            )
          ],
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              title: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  hintText: 'Amount'
                ),
              ),
            ),
            new ListTile(
              title: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    hintText: 'Currency'
                ),
              ),
            ),
            new ListTile(
              title: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    hintText: 'Category'
                ),
              ),
            ),
            new ListTile(
              title: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    hintText: 'Note'
                ),
              ),
            ),
            new ListTile(
              title: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    hintText: 'Date time'
                ),
              ),
            ),
            new ListTile(
              title: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    hintText: 'Account'
                ),
              ),
            ),
          ],
        ),
      );

}