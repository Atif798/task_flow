import 'package:flutter/material.dart';
import '../../models/todo.dart';
import '../../theme/app_theme.dart';

class TaskCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 6, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) => onToggle(),
                activeColor: todo.isCompleted
                    ? AppTheme.successColor
                    : AppTheme.primaryColor,
                checkColor: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 9,
                  bottom: 7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.titleMedium.copyWith(
                        color: todo.isCompleted
                            ? AppTheme.secondaryTextColor
                            : AppTheme.textColor,
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    if (todo.note.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        todo.note,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.bodySmall.copyWith(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    if (todo.isCompleted)
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 14,
                            color: AppTheme.successColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Completed',
                            style: AppTheme.labelSmall.copyWith(
                              color: AppTheme.successColor,
                            ),
                          ),
                        ],
                      )
                    else
                      const SizedBox(height: 14),
                  ],
                ),
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'Task options',
              icon: Icon(
                Icons.more_vert_rounded,
                size: 22,
                color: AppTheme.textColor,
              ),
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                } else if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(
                      Icons.edit_outlined,
                      color: AppTheme.textColor,
                    ),
                    title: Text(
                      'Edit',
                      style: AppTheme.filterTitle,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(
                      Icons.delete_outline_rounded,
                      color: AppTheme.errorColor,
                    ),
                    title: Text(
                      'Delete',
                      style: AppTheme.filterTitle.copyWith(
                        color: AppTheme.errorColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}