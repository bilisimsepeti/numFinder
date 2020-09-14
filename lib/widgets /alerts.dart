import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/styles/text.dart';

abstract class AppAlerts {

  static Future<void> showErrorDialog(BuildContext context, String errorMessage) async {

    return showCupertinoDialog(
      context: context,
      builder: (context){
        return CupertinoAlertDialog(  
          title: Text('Error',style: TextStyles.subtitle,),
          content: SingleChildScrollView(  
            child: ListBody(  
              children: <Widget>[
                Text(errorMessage, style: TextStyles.body)
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoButton(  
              child: Text('Okay',style: TextStyles.body),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }

}