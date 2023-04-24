import 'package:flutter/material.dart';

import '../shared/styles/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
