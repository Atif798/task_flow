import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/data/todo_repository.dart';
import 'package:task_flow/models/todo.dart';
import 'package:task_flow/screens/splash_screen.dart';
import 'package:task_flow/theme/app_theme.dart';
import 'controllers/todo_provider.dart';

//https://drive.google.com/drive/folders/1yJ6yiVlJlV1FGKkWEOajXxcaGzeX-0Ms?usp=sharing
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  final repository = TodoRepository();
  await repository.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider(repository)..loadTodos(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Flow',
        theme: AppTheme.lightTheme,
      home: const SplashScreen()
    );
  }
}
