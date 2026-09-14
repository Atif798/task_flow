import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isButtonDisabled = isLoading || isDisabled;

    return SizedBox(
      width: double.infinity,
      height: 54,

      child: FilledButton.icon(
        onPressed: isButtonDisabled ? null : onPressed,

        icon: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.2,
            color: Colors.white,
          ),
        )
            : Icon(
          icon ?? Icons.add_task_rounded,
          size: 21,
          color: Colors.white,
        ),

        label: Text(
          isLoading ? 'Loading...' : label,
          style: AppTheme.buttonWhite,
        ),

        style: FilledButton.styleFrom(
          backgroundColor: isButtonDisabled
              ? AppTheme.secondaryTextColor.withOpacity(0.4)
              : AppTheme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}