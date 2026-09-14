import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/todo_provider.dart';
import '../widgets/Forms/stat_card.dart';
import '../widgets/Forms/task_card.dart';
import 'add_todo_screen.dart';
import 'edit_todo_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/home/filter_option.dart';
import '../widgets/home/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _closeSearch() {
    _searchController.clear();

    setState(() {
      _isSearching = false;
    });
  }

  void _showSnackBar({
    required String message,
    required IconData icon,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: backgroundColor,
        content: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppTheme.snackbarText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Tasks',
                  style: AppTheme.headingSmall,
                ),
                const SizedBox(height: 12),
                FilterOption(
                  title: 'All Tasks',
                  icon: Icons.list_alt_rounded,
                  selected: _selectedFilter == 'All',
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'All';
                    });
                    Navigator.pop(sheetContext);
                  },
                ),
                FilterOption(
                  title: 'Pending Tasks',
                  icon: Icons.pending_actions_rounded,
                  selected: _selectedFilter == 'Pending',
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'Pending';
                    });
                    Navigator.pop(sheetContext);
                  },
                ),
                FilterOption(
                  title: 'Completed Tasks',
                  icon: Icons.check_circle_outline_rounded,
                  selected: _selectedFilter == 'Completed',
                  onTap: () {
                    setState(() {
                      _selectedFilter = 'Completed';
                    });
                    Navigator.pop(sheetContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDeleteDialog(
      BuildContext context,
      TodoProvider provider,
      String todoId,
      ) async {
    final colorScheme = Theme.of(context).colorScheme;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              color: colorScheme.onErrorContainer,
              size: 26,
            ),
          ),
          title: Text(
            'Delete Task?',
            style: AppTheme.dialogTitle,
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Are you sure you want to delete this task? '
                'This action cannot be undone.',
            textAlign: TextAlign.center,
            style: AppTheme.dialogContent,
          ),
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          actions: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Delete Button (Primary - Red)
                  SizedBox(
                    width: 240,
                    height: 48,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.errorColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(dialogContext, true);
                      },
                      child: Text(
                        'Delete',
                        style: AppTheme.buttonWhite,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Cancel Button (Outlined)
                  SizedBox(
                    width: 240,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(
                          color: AppTheme.borderColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(dialogContext, false);
                      },
                      child: Text(
                        'Cancel',
                        style: AppTheme.buttonText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    try {
      await provider.deleteTodo(todoId);

      if (!mounted) return;

      _showSnackBar(
        message: 'Task deleted successfully 🗑️',
        icon: Icons.check_circle_outline_rounded,
        backgroundColor: AppTheme.errorColor,
      );
    } catch (_) {
      if (!mounted) return;

      _showSnackBar(
        message: 'Unable to delete task. Please try again.',
        icon: Icons.error_outline_rounded,
        backgroundColor: AppTheme.errorColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    final searchText = _searchController.text.trim().toLowerCase();

    final filteredTodos = todoProvider.todos.where((todo) {
      final matchesSearch =
          todo.title.toLowerCase().contains(searchText) ||
              todo.note.toLowerCase().contains(searchText);

      final matchesStatus = switch (_selectedFilter) {
        'Pending' => !todo.isCompleted,
        'Completed' => todo.isCompleted,
        _ => true,
      };

      return matchesSearch && matchesStatus;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Hide default AppBar
      ),
      body: SafeArea(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          children: [
            // HEADER CARD
            Card(
              color: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: App Icon + Search + Filter
                    Row(
                      children: [
                        // App Icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.task_alt_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // App Name
                        Expanded(
                          child: Text(
                            'Task Flow',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),

                        // Search Button
                        IconButton(
                          tooltip: 'Search tasks',
                          onPressed: _openSearch,
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.white.withOpacity(0.9),
                            size: 26,
                          ),
                        ),

                        // Filter Button with Badge
                        Stack(
                          children: [
                            IconButton(
                              tooltip: 'Filter tasks',
                              onPressed: _showFilterSheet,
                              icon: Icon(
                                Icons.tune_rounded,
                                color: Colors.white.withOpacity(0.9),
                                size: 26,
                              ),
                            ),
                            if (_selectedFilter != 'All')
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    // Search Field (Conditional)
                    if (_isSearching) ...[
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Icon(
                              Icons.search_rounded,
                              color: Colors.white.withOpacity(0.7),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                onChanged: (_) {
                                  setState(() {});
                                },
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Search tasks...',
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                  ),
                                  border: InputBorder.none,
                                  filled: false,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _closeSearch,
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.white.withOpacity(0.7),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Divider
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.15),
                    ),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      'Manage your tasks',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.7,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle
                    Text(
                      'Stay organized and get things done.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Decorative element
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 20,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 10,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Pending',
                    count: todoProvider.pendingCount,
                    icon: Icons.pending_actions_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: 'Completed',
                    count: todoProvider.completedCount,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Tasks header
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Your Tasks',
                    style: AppTheme.headingMedium,
                  ),
                ),
                Text(
                  '${filteredTodos.length} task${filteredTodos.length == 1 ? '' : 's'}',
                  style: AppTheme.taskCount,
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Active filter
            if (_selectedFilter != 'All') ...[
              Builder(
                builder: (context) {
                  // Determine color based on filter
                  Color filterColor;
                  IconData filterIcon;

                  if (_selectedFilter == 'Pending') {
                    filterColor = AppTheme.errorColor; // Red for Pending
                    filterIcon = Icons.pending_actions_rounded;
                  } else {
                    filterColor = AppTheme.successColor; // Green for Completed
                    filterIcon = Icons.check_circle_outline_rounded;
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: filterColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: filterColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          filterIcon,
                          size: 17,
                          color: filterColor,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          _selectedFilter,
                          style: AppTheme.labelSmall.copyWith(
                            color: filterColor,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 3),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedFilter = 'All';
                            });
                          },
                          icon: const Icon(Icons.close_rounded, size: 17),
                          visualDensity: VisualDensity.compact,
                          color: filterColor,
                          tooltip: 'Clear filter',
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],

            // Task list
            if (todoProvider.todos.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: EmptyState.noTasks(),
              )
            else if (filteredTodos.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: EmptyState.noSearchResult(),
              )
            else
              ...filteredTodos.map(
                    (todo) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TaskCard(
                    todo: todo,
                    onToggle: () {
                      todoProvider.toggleTodo(todo.id);
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditTodoScreen(todo: todo),
                        ),
                      );
                    },
                    onDelete: () {
                      _showDeleteDialog(context, todoProvider, todo.id);
                    },
                  ),
                ),
              ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTodoScreen()),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Task'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}