import 'package:flutter/material.dart';

class CustomNotification extends StatelessWidget {
  final String title;
  final String body;
  const CustomNotification(
      {super.key, required this.title, required this.body});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
      content: Text(body),
    );
  }
}
