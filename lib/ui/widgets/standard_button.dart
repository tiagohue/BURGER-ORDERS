import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? iconData;
  final double width;

  const StandardButton({
    super.key,
    this.iconData,
    required this.text,
    required this.onPressed,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          fixedSize: Size(width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            side: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        child: Stack(
          children: [
            if (iconData != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(iconData, size: 25),
              ),
            Align(
              alignment: Alignment.center,
              child: Text(text, style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
      ),
    );
  }
}
