import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/task/data/datasources/task_local_data_source.dart';
import 'features/task/data/models/task_model.dart';
import 'features/task/data/repositories/task_repository_impl.dart';
import 'features/task/domain/usecases/add_task.dart';
import 'features/task/domain/usecases/delete_task.dart';
import 'features/task/domain/usecases/get_tasks.dart';
import 'features/task/domain/usecases/update_task.dart';
import 'features/task/presentation/bloc/task_bloc.dart';
import 'features/task/presentation/pages/splash_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Adapter
  Hive.registerAdapter(TaskModelAdapter());
  
  // Open the tasks box
  await Hive.openBox<TaskModel>('tasks');

  // Manual Dependency Injection
  final taskLocalDataSource = TaskLocalDataSourceImpl();
  final taskRepository = TaskRepositoryImpl(localDataSource: taskLocalDataSource);
  
  final getTasks = GetTasks(taskRepository);
  final addTask = AddTask(taskRepository);
  final updateTask = UpdateTask(taskRepository);
  final deleteTask = DeleteTask(taskRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(
            getTasks: getTasks,
            addTask: addTask,
            updateTask: updateTask,
            deleteTask: deleteTask,
          ),
        ),
        BlocProvider(create: (context) => ThemeCubit()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskNest',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeCubit>().state,


      home: const SplashScreen(),
    );
  }
}
