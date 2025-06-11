import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

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
      child: IconButton(onPressed: widget.onPressed, icon: Icon(Icons.add)),
    );
  }
}
