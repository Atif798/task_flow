import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final double iconSize;

  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.task_alt_rounded,
    this.iconSize = 70,
  });

  const EmptyState.noTasks({
    Key? key,
  }) : this(
    key: key, // Pass key explicitly
    title: 'No tasks yet',
    subtitle: 'Create your first task to get started.',
    icon: Icons.task_alt_rounded,
    iconSize: 70,
  );

  const EmptyState.noSearchResult({
    Key? key,
  }) : this(
    key: key, // Pass key explicitly
    title: 'No matching tasks',
    subtitle: 'Try another search or filter.',
    icon: Icons.search_off_rounded,
    iconSize: 64,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: icon == Icons.search_off_rounded
                ? AppTheme.secondaryTextColor
                : AppTheme.primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTheme.emptyTitle,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTheme.emptySubtitle,
          ),
        ],
      ),
    );
  }
}