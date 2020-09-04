import 'package:flutter/material.dart';

class AlertHelper {
  yesNoAlertDraft(BuildContext context, String title,
      String contentMessage, Function yes, Function no) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          content: Text(contentMessage),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: yes,
                  child: Text("Yes"),
                ),
                SizedBox(
                  width: 3,
                ),
                FlatButton(
                  onPressed: no,
                  child: Text("No"),
                  color: Colors.redAccent,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
