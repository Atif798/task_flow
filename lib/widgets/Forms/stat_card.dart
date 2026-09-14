import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Determine color based on title using AppTheme colors
    Color titleColor;
    if (title == 'Pending') {
      titleColor = AppTheme.errorColor;
    } else if (title == 'Completed') {
      titleColor = AppTheme.successColor;
    } else {
      titleColor = AppTheme.secondaryTextColor;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: AppTheme.primaryColor,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                size: 24,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTheme.statTitle.copyWith(
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$count',
                    textAlign: TextAlign.center,
                    style: AppTheme.countLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}