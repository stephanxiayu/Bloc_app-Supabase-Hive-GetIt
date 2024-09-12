import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_bloc_clean_app/core/theme/theme.dart';

import 'package:new_bloc_clean_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:new_bloc_clean_app/features/auth/presentation/pages/login_page.dart';
import 'package:new_bloc_clean_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc App',
        theme: AppTheme.darkMode,
        home: const LoginPage());
  }
}
