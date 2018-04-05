import 'package:flutter/material.dart';

class NewAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewAccountScreenState();
}

class NewAccountScreenState extends State<NewAccountScreen> {
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
          new ListTile(
            title: new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: 'Currency'),
            ),
          ),
          new ListTile(
            title: new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: 'Balance'),
            ),
          ),
        ],
      ),
    );
}
