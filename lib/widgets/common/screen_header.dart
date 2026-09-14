import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const ScreenHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.headingLarge.copyWith(
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: AppTheme.bodyLarge.copyWith(
            fontSize: 13.5,
          ),
        ),
      ],
    );
  }
}