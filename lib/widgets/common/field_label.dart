import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class FieldLabel extends StatelessWidget {
  final String text;
  final bool required;

  const FieldLabel({
    super.key,
    required this.text,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: AppTheme.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (required)
          Text(
            ' *',
            style: AppTheme.labelLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.errorColor,
            ),
          ),
      ],
    );
  }
}