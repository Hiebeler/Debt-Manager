import 'dart:ui';
import 'package:flutter/material.dart';


class ErrorDialog extends StatelessWidget {

  String title;
  String content;

  ErrorDialog(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title: Text(title,style: Theme.of(context).textTheme.bodyText1,),
          content: Text(content, style: Theme.of(context).textTheme.bodyText1,),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}