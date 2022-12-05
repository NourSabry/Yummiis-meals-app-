// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback? okay;
  final VoidCallback? cancel;

  const DeleteDialog({this.okay, this.cancel});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Welcome'),
      content: const Text('GeeksforGeeks'),
      actions: [
        TextButton(
          onPressed: cancel,
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: okay,
          child: const Text('ACCEPT'),
        ),
      ],
    );
  }
}
