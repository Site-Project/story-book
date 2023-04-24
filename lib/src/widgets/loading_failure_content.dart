import 'package:flutter/material.dart';

import '../shared/constants/app_constants.dart' as constants;
import 'retry_button.dart';

class LoadingFailureContent extends StatelessWidget {
  final Function() onRetry;
  const LoadingFailureContent({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              constants.ErrorMessage.getListFailure,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            ReTryButtom(
              title: constants.Global.retry,
              onRetry: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
