import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const DeleteDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: onCancel,
        ),
        TextButton(
          child: Text('Excluir'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.red, // Cor vermelha
          ),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
