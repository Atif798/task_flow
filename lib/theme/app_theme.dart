import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  AppTheme._(); // Private constructor - is class ko instantiate nahi kar sakte

  /// Used in: FAB, Header Card, Primary Buttons, Active Filters
  static const Color primaryColor = Color(0xFF5B5FEF);
  /// Screen background color - Scaffold, AppBar background
  static const Color backgroundColor = Color(0xFFF7F7FC);
  /// Primary text color - Headings, Titles, Task titles
  static const Color textColor = Color(0xFF202124);
  /// Used in: Subtitle, Hint text, Task notes, Labels
  static const Color secondaryTextColor = Color(0xFF707070);
  /// Used in: Card borders, Input borders, Cancel button border
  static const Color borderColor = Color(0xFFE6E6EE);
  /// Used in: Delete buttons, Validation/Error messages, Pending stat card, Pending filter, All screens (error), Delete task confirmation
  static const Color errorColor = Color(0xFFD64545);
  /// Used in: Completed checkbox, Completed stat card, Completed filter, AddTodoScreen, EditTodoScreen (success)
  static const Color successColor = Color(0xFF34A853);
  /// Used in: AddTodoScreen, EditTodoScreen (success)
  //static const Color snackbarSuccess = Color(0xFF34A853);
  /// Used in: All screens (error), Delete task confirmation
  //static const Color snackbarError = Color(0xFFD64545);
  /// Used in: Future use
  // static const Color snackbarInfo = Color(0xFF5B5FEF);

  /// Used in: "Manage your tasks" (HomeScreen)
  static TextStyle get headingLarge => GoogleFonts.poppins(
    fontSize: 25,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.7,
    color: textColor,
  );
  /// Used in: "Your Tasks" (HomeScreen)
  static TextStyle get headingMedium => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: textColor,
  );
  /// Used in: "Filter Tasks" (Filter sheet), Dialog titles
  static TextStyle get headingSmall => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: textColor,
  );
  /// Used in: Future use (larger titles)
  // static TextStyle get titleLarge => GoogleFonts.poppins(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w600,
  //   color: textColor,
  // );
  /// Used in: TaskCard title
  static TextStyle get titleMedium => GoogleFonts.poppins(
    fontSize: 15.5,
    fontWeight: FontWeight.w600,
    height: 1.35,
    color: textColor,
  );
  /// Used in: Future use
  // static TextStyle get titleSmall => GoogleFonts.poppins(
  //   fontSize: 14,
  //   fontWeight: FontWeight.w600,
  //   color: textColor,
  // );
  /// Used in: HomeScreen subtitle, AddTodoScreen subtitle
  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 15,
    height: 1.4,
    color: secondaryTextColor,
  );
  /// Used in: Snackbar text, Form hints
  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: secondaryTextColor,
  );
  /// Used in: TaskCard note, Counter text, Helper text
  static TextStyle get bodySmall => GoogleFonts.poppins(
    fontSize: 12.5,
    height: 1.4,
    color: secondaryTextColor,
  );
  /// Used in: FieldLabel ("Task title", "Notes")
  static TextStyle get labelLarge => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: secondaryTextColor,
  );
  /// Used in: TaskCard "Completed" text
  static TextStyle get labelSmall => GoogleFonts.poppins(
    fontSize: 10.5,
    fontWeight: FontWeight.w600,
    color: successColor, // Green
  );
  /// Used in: StatCard count (Pending/Completed numbers)
  static TextStyle get countLarge => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
  /// Used in: StatCard title ("Pending", "Completed")
  static TextStyle get statTitle => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: secondaryTextColor,
  );
  /// Used in: FilterOption ("All Tasks", "Pending Tasks")
  static TextStyle get filterTitle => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textColor,
  );
  /// Used in: EmptyState ("No tasks yet", "No matching tasks")
  static TextStyle get emptyTitle => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
  /// Used in: EmptyState ("Create your first task...")
  static TextStyle get emptySubtitle => GoogleFonts.poppins(
    color: secondaryTextColor,
  );
  /// Used in: Cancel button, Outlined buttons
  static TextStyle get buttonText => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
  /// Used in: Save button, Delete button, Update button
  static TextStyle get buttonWhite => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  /// Used in: "Delete Task?" dialog title
  static TextStyle get dialogTitle => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: textColor,
  );
  /// Used in: "Are you sure you want to delete..." dialog content
  static TextStyle get dialogContent => GoogleFonts.poppins(
    fontSize: 13.5,
    height: 1.45,
    color: secondaryTextColor,
  );
  /// Used in: All snackbars (success/error)
  static TextStyle get snackbarText => GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  /// Used in: tasks count label in HomeScreen
  static TextStyle get taskCount => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: secondaryTextColor,
  );
  /// Used in: Search TextField hint
  static TextStyle get searchHint => GoogleFonts.poppins(
    color: secondaryTextColor,
  );
  /// Used in: "Add Task", "Edit Task" AppBar titles
  static TextStyle get appBarTitle => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
  /// Used in: CustomTextField hint text
  static TextStyle get hintText => GoogleFonts.poppins(
    fontSize: 13,
    color: secondaryTextColor.withOpacity(0.7),
  );


  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // Global background color for all screens
    scaffoldBackgroundColor: backgroundColor,
    // Used by: All Material widgets automatically
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,   // Main color
      error: errorColor,       // Error states
      surface: Colors.white,   // Surface color for cards, sheets
    ),
    // Global font family for entire app
    fontFamily: GoogleFonts.poppins().fontFamily,
    // Used in: AddTodoScreen, EditTodoScreen
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: appBarTitle, // "Add Task", "Edit Task"
      iconTheme: const IconThemeData(
        color: textColor, // Back arrow icon
      ),
    ),
    // Used in: StatCard, TaskCard, Header Card
    cardTheme: CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: borderColor, // Card border
        ),
      ),
    ),
    // Used in: CustomTextField, TextFormField
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      // Default border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: borderColor,
        ),
      ),
      // Enabled state border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: borderColor,
        ),
      ),
      // Focused state border (when typing)
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
    ),
    // Used in: HomeScreen FAB ("Add Task")
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    // Used in: CustomButton, Dialog buttons (Save, Delete, Update)
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: buttonWhite,
      ),
    ),
    // Used in: Cancel button in dialogs
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: buttonText,
      ),
    ),
    // Used in: TaskCard checkbox
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    // Used in: TaskCard popup menu (Edit/Delete)
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 4,
    ),
    // Used in: All snackbars (success/error)
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
}