
import 'package:flutter/material.dart';

typedef FirstValidator = bool Function();

void alert_function({
  required VoidCallback? onConfirmPressed,
  required String alertMessage,
  required FirstValidator validator,
  required String validatorFalseMessage,
  required BuildContext context,
}){
  if (validator() == false) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(validatorFalseMessage),
      ),
    );
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Caution'),
            content: Text(
              alertMessage,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Dismiss'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Confirm'),
                onPressed: onConfirmPressed,
              ),
            ],
          );
        });
  }
}