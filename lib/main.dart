import 'package:flutter/material.dart';
import 'package:monai/configs/general_configs.dart';
import 'package:monai/data/account.dart';
import 'package:monai/data/currency.dart';
import 'package:monai/data/transaction.dart';
import 'package:monai/screens/account_manager_screen.dart';
import 'package:monai/screens/new_account_screen.dart';
import 'package:monai/screens/new_transaction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: APP_NAME,
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: APP_NAME),
      routes: {
        "/new_transaction": (context) => new NewTransactionScreen(),
        "/account_manager": (context) => new AccountManagerScreen(),
        "/new_account": (context) => new NewAccountScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool initializing = true;
  double progress = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new ListTile(
          leading: new Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          title: new Text(
            // TODO: For now this is the app title
            // In the future, this should be the amount of the current viewing account
            widget.title,
            style: new TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          onTap: () {
            Navigator.of(context).pushNamed("/account_manager");
          },
        ),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: initializing? <Widget>[
            new CircularProgressIndicator(
              value: progress,
            ),
            new Text('Initializing...'),
          ] : <Widget>[],
        ),
      ),
      floatingActionButton: initializing? null : new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/new_transaction");
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text('Testing user'), accountEmail: new Text('email@gmail.com'), margin: new EdgeInsets.only(bottom: 0.0),),
            new Expanded(child: new ListView(
              padding: new EdgeInsets.only(top: 10.0),
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.account_balance_wallet),
                  title: new Text('Transactions'),
                ),
                new ListTile(
                  leading: new Icon(Icons.swap_vert),
                  title: new Text('Debts'),
                ),
                new Divider(),
                new ListTile(
                  leading: new Icon(Icons.monetization_on),
                  title: new Text('Budgets'),
                ),
                new ListTile(
                  leading: new Icon(Icons.shopping_basket),
                  title: new Text('Savings'),
                ),
                new ListTile(
                  leading: new Icon(Icons.assignment),
                  title: new Text('Bills'),
                ),
                new Divider(),
                new ListTile(
                  leading: new Icon(Icons.settings),
                  title: new Text('Settings'),
                ),
              ],
            ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool initialized = (prefs.getBool('initialized') ?? false);
    setState(() => initializing = !initialized);
    if (!initialized) {
      await CurrencyProvider.getInstance().open();
      await CurrencyProvider.getInstance().close();
      setState(() => progress = 0.33);
      await AccountProvider.getInstance().open();
      await AccountProvider.getInstance().close();
      setState(() => progress = 0.66);
      await TransactionProvider.getInstance().open();
      await TransactionProvider.getInstance().close();
      setState(() => progress = 1.0);
      prefs.setBool('initialized', true);
      setState(() => initializing = false);
    }
  }
}
