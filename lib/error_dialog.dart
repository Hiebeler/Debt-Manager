import 'dart:ui';
import 'package:flutter/material.dart';


class ErrorDialog extends StatelessWidget {

  String title;
  String content;

  ErrorDialog(this.title, this.content);
  TextStyle textStyle = TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title: Text(title,style: textStyle,),
          content: Text(content, style: textStyle,),
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