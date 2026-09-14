import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/todo_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/Forms/custom_form.dart';
import '../widgets/common/custom_snackbar.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  bool _isLoading = false;
  bool _isTitleEmpty = true;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateButtonState);
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isTitleEmpty = _titleController.text.trim().isEmpty;
    });
  }

  Future<void> _saveTodo() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    setState(() => _isLoading = true);

    try {
      await context.read<TodoProvider>().addTodo(
        title: _titleController.text,
        note: _noteController.text,
      );

      if (!mounted) return;

      CustomSnackBar.show(
        context: context,
        message: 'Task added successfully! 🎉',
        icon: Icons.check_circle_outline_rounded,
        backgroundColor: AppTheme.successColor,
      );

      Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) return;

      setState(() => _isLoading = false);

      CustomSnackBar.show(
        context: context,
        message: 'Unable to save task. Please try again.',
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
          'Add Task',
          style: AppTheme.appBarTitle,
        ),
      ),

      body: SafeArea(
        child: CustomForm(
          formKey: _formKey,
          titleController: _titleController,
          noteController: _noteController,
          isLoading: _isLoading,
          isButtonDisabled: _isTitleEmpty,
          onSave: _saveTodo,
          headerTitle: 'Create a new task',
          headerSubtitle: 'Add the details below to keep your task organized.',
          buttonLabel: 'Save Task',
          buttonIcon: Icons.add_task_rounded,
          isEditMode: false, // Add mode
        ),
      ),
    );
  }
}