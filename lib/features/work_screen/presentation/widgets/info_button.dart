import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveInfoButton extends StatelessWidget {
  final String message;

  const AdaptiveInfoButton({super.key, required this.message});

  void _showInfo(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        //title: const Text('Info'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showInfo(context),
      child: Icon(
        CupertinoIcons.info_circle,
        size: 14,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
