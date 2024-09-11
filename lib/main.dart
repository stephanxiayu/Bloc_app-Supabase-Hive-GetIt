import 'package:flutter/material.dart';
import 'package:new_bloc_clean_app/core/secrets/app_secrets.dart';
import 'package:new_bloc_clean_app/core/theme/theme.dart';
import 'package:new_bloc_clean_app/features/auth/presentation/pages/login_page.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnon);
  runApp(const MyApp());
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
