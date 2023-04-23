import 'package:flutter/material.dart';

class ReTryButtom extends StatelessWidget {
  final String title;
  final Function() onRetry;
  const ReTryButtom({
    super.key,
    required this.title,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onRetry,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(0.2),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
