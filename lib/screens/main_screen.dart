import 'package:flutter/material.dart';
import 'package:monai/data/account.dart';
import 'package:monai/data/database_helper.dart';
import 'package:monai/screens/main_screen_fragments/transaction_manager_fragment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  bool initializing = true;
  Account currentAccount;
  Widget currentFragment = TransactionManagerFragment();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: ListTile(
          leading: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          title: Text(
            currentAccount == null ? widget.title : currentAccount.name,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          subtitle: currentAccount == null
              ? null
              : Text(
                  '${currentAccount.currentBalance.toString()} '
                      '${currentAccount.currency.shortName}',
                  style: TextStyle(color: Colors.white70),
                ),
          onTap: () async {
            Navigator
                .of(context)
                .pushNamed("/account_manager")
                .then((resultAccount) async {
              if (resultAccount != null) {
                var updatedAccount =
                    await (resultAccount as Account).postConstruct();
                setState(() {
                  currentAccount = updatedAccount;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('last_account', updatedAccount.id);
              }
            });
          },
        ),
      ),
      body: initializing
          ? Center(child: Text('Initializing...'))
          : currentFragment,
      floatingActionButton: initializing
          ? null
          : Builder(
              builder: (context) => FloatingActionButton(
                    onPressed: () => addNewTransaction(context),
                    tooltip: 'transaction',
                    child: Icon(Icons.add),
                  )),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Testing user'),
              accountEmail: Text('email@gmail.com'),
              margin: EdgeInsets.only(bottom: 0.0),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.only(top: 10.0),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text('Transactions'),
                  onTap: () {
                    if (!(currentFragment is TransactionManagerFragment)) {
                      setState(
                          () => currentFragment = TransactionManagerFragment());
                    }
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.swap_vert),
                  title: Text('Debts'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text('Budgets'),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_basket),
                  title: Text('Savings'),
                ),
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text('Bills'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void addNewTransaction(BuildContext context) {
    AccountProvider.getInstance().getAllAccounts().then((accountList) {
      if (accountList.length == 0)
        Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                children: <Widget>[
                  Icon(Icons.error),
                  Container(
                    child: Text('You must have at least 1 account'),
                    margin: EdgeInsets.only(left: 10.0),
                  )
                ],
              ),
              duration: Duration(seconds: 5),
              action: SnackBarAction(
                  label: 'Create',
                  onPressed: () {
                    Navigator.of(context).pushNamed("/account_manager");
                  }),
            ));
      else
        Navigator.of(context).pushNamed("/new_transaction");
    });
  }

  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool initialized = (prefs.getBool('initialized') ?? false);
    setState(() => initializing = !initialized);
    if (!initialized) {
      await DatabaseHelper.getInstance().initializeDB();
      prefs.setBool('initialized', true);
      setState(() => initializing = false);
    }

    // Try getting last account
    int lastAccountId = prefs.getInt('last_account') ?? -1;
    if (lastAccountId >= 0)
      AccountProvider
          .getInstance()
          .getAccount(lastAccountId)
          .then((account) async {
        var updatedAccount = await account.postConstruct();
        setState(() {
          currentAccount = updatedAccount;
        });
      });
  }
}
