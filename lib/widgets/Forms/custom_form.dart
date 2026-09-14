import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../common/field_label.dart';
import '../common/custom_text_field.dart';
import '../common/custom_button.dart';
import '../common/screen_header.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController noteController;
  final bool isLoading;
  final bool isButtonDisabled;
  final VoidCallback onSave;
  final String headerTitle;
  final String headerSubtitle;
  final String buttonLabel;
  final IconData buttonIcon;
  final bool isEditMode; // New parameter

  const CustomForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.noteController,
    required this.isLoading,
    required this.isButtonDisabled,
    required this.onSave,
    required this.headerTitle,
    required this.headerSubtitle,
    required this.buttonLabel,
    required this.buttonIcon,
    this.isEditMode = false, // Default is false (Add mode)
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        keyboardDismissBehavior:
        ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          32,
        ),
        children: [
          ScreenHeader(
            title: headerTitle,
            subtitle: headerSubtitle,
          ),

          const SizedBox(height: 30),

          FieldLabel(
            text: 'Task title',
            required: true,
          ),

          const SizedBox(height: 8),

          CustomTextField(
            controller: titleController,
            hintText: 'e.g. Complete Flutter Task',
            prefixIcon: Icon(
              Icons.task_alt_rounded,
              color: AppTheme.secondaryTextColor,
            ),
            textStyle: AppTheme.titleMedium,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a task title';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          FieldLabel(
            text: 'Notes (Optional)',
            required: false,
          ),

          const SizedBox(height: 8),

          CustomTextField(
            controller: noteController,
            hintText: 'Add some details about this task...',
            maxLines: 5,
            minLines: 5,
            maxLength: 300,
            textInputAction: TextInputAction.newline,
            textStyle: AppTheme.bodySmall,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 76),
              child: Icon(
                Icons.notes_rounded,
                color: AppTheme.secondaryTextColor,
              ),
            ),
          ),

          const SizedBox(height: 24),

          CustomButton(
            onPressed: onSave,
            label: buttonLabel,
            icon: buttonIcon,
            isLoading: isLoading,
            isDisabled: isButtonDisabled,
          ),

          const SizedBox(height: 12),

          // Dynamic Footer Text
          Center(
            child: Text(
              isEditMode
                  ? 'Your task will keep its current status.'
                  : 'You can edit this task later.',
              style: AppTheme.bodySmall.copyWith(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}