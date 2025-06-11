import 'package:burger_orders/ui/widgets/standard_dialog.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final String modelName;
  final Widget content;
  final VoidCallback onCreate;

  const AddButton({
    super.key,
    required this.modelName,
    required this.content,
    required this.onCreate,
  });

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 3.0,
        ),
      ),
      child: IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => StandardDialog(
            title: "Create new ${widget.modelName}",
            content: widget.content,
            onConfirm: widget.onCreate,
            confirmText: "Create",
          ),
        ),
        icon: Icon(Icons.add),
      ),
    );
  }
}
