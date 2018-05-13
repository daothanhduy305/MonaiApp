import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, String message) =>
    Scaffold.of(context).showSnackBar(SnackBar(
          content: Row(
            children: <Widget>[
              Icon(Icons.error),
              new Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(message),
              )
            ],
          ),
        ));
