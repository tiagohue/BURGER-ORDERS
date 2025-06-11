import 'package:burger_orders/ui/widgets/standard_button.dart';
import 'package:flutter/material.dart';

class StandardDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final VoidCallback onConfirm;
  final String confirmText;

  const StandardDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.confirmText,
  });

  @override
  State<StandardDialog> createState() => _StandardDialogState();
}

class _StandardDialogState extends State<StandardDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: FittedBox(
        child: Text(
          "${widget.title}:",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      content: widget.content,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FittedBox(
          child: Row(
            children: [
              StandardButton(
                text: "Cancel",
                onPressed: () => Navigator.pop(context),
                width: 120,
              ),
              StandardButton(
                text: widget.confirmText,
                onPressed: widget.onConfirm,
                width: 120,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
