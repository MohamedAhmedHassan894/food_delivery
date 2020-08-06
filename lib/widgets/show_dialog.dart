import 'package:flutter/material.dart';

Future<void> showLoadingIndicator(BuildContext context, String message) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      //it will prevent the user from clicking outside the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 10.0,
              ),
              Text("$message"),
            ],
          ),
        );
      });
}
