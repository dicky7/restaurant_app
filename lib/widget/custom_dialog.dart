
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';


customDialog(BuildContext context){
  if(Platform.isIOS){
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Comming Soob!"),
            content: const Text('This feature will be coming soon!'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigation.back();
                },
              ),
            ],
          );
        },
    );
  }else{
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Comming Soob!"),
            content: const Text('This feature will be coming soon!'),
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
}