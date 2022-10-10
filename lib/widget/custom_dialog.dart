import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';

customDialogData(BuildContext context,
    {required String routeName,
    required String title,
    required String message,
    Object? arguments}) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigation.intentWithDataClearTop(routeName, arguments: arguments);
            },
          ),
        ],
      );
    },
  );
}

customDialog(BuildContext context, {required String title, required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigation.back();
            },
          ),
        ],
      );
    },
  );
}
