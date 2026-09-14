import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/todo_provider.dart';
import '../models/todo.dart';
import '../theme/app_theme.dart';
import '../widgets/Forms/custom_form.dart';
import '../widgets/common/custom_snackbar.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;
  const EditTodoScreen({super.key, required this.todo,});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _noteController;
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.todo.title,
    );

    _noteController = TextEditingController(
      text: widget.todo.note,
    );

    _titleController.addListener(_updateButtonState);
    _noteController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateButtonState);
    _noteController.removeListener(_updateButtonState);
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final bool titleChanged = _titleController.text != widget.todo.title;
    final bool noteChanged = _noteController.text != widget.todo.note;

    setState(() {
      _hasChanges = titleChanged || noteChanged;
    });
  }

  Future<void> _updateTodo() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    setState(() => _isLoading = true);

    try {
      await context.read<TodoProvider>().updateTodo(
        id: widget.todo.id,
        title: _titleController.text,
        note: _noteController.text,
      );

      if (!mounted) return;

      CustomSnackBar.show(
        context: context,
        message: 'Task updated successfully! ✅',
        icon: Icons.check_circle_outline_rounded,
        backgroundColor: AppTheme.successColor,
      );

      Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) return;

      setState(() => _isLoading = false);

      CustomSnackBar.show(
        context: context,
        message: 'Unable to update task. Please try again.',
        icon: Icons.error_outline_rounded,
        backgroundColor: AppTheme.errorColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 24,
            color: AppTheme.textColor,
          ),
        ),
        title: Text(
          'Edit Task',
          style: AppTheme.appBarTitle,
        ),
      ),

      body: SafeArea(
        child: CustomForm(
          formKey: _formKey,
          titleController: _titleController,
          noteController: _noteController,
          isLoading: _isLoading,
          isButtonDisabled: !_hasChanges,
          onSave: _updateTodo,
          headerTitle: 'Update your task',
          headerSubtitle: 'Make changes to your task details below.',
          buttonLabel: 'Update Task',
          buttonIcon: Icons.save_rounded,
          isEditMode: true, // Edit mode
        ),
      ),
    );
  }
}