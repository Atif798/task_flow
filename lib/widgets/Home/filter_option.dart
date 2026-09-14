import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class FilterOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Color? color; // Optional custom color

  const FilterOption({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.color,
  });

  // Helper to get color based on title
  Color _getColor() {
    if (color != null) return color!;

    if (title.contains('Pending')) {
      return AppTheme.errorColor; // Red for Pending
    } else if (title.contains('Completed')) {
      return AppTheme.successColor; // Green for Completed
    }
    return AppTheme.primaryColor; // Primary for All
  }

  @override
  Widget build(BuildContext context) {
    final optionColor = _getColor();

    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: selected ? optionColor : AppTheme.secondaryTextColor,
      ),
      title: Text(
        title,
        style: AppTheme.filterTitle.copyWith(
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          color: selected ? optionColor : AppTheme.textColor,
        ),
      ),
      trailing: selected
          ? Icon(
        Icons.check_rounded,
        color: optionColor,
      )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}