import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:new_bloc_clean_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:new_bloc_clean_app/core/network/connection_checker.dart';
import 'package:new_bloc_clean_app/core/secrets/app_secrets.dart';
import 'package:new_bloc_clean_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:new_bloc_clean_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:new_bloc_clean_app/features/auth/domain/repository/auth_repository.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/current_user.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/user_login.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/user_signup.dart';
import 'package:new_bloc_clean_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:new_bloc_clean_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:new_bloc_clean_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:new_bloc_clean_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:new_bloc_clean_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:new_bloc_clean_app/features/blog/domain/usecases/get_uploaded_blogs.dart';
import 'package:new_bloc_clean_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:new_bloc_clean_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnon);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => Hive.box(name: "blogs"));
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
  );
// usecases
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

// bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator()),
  );
}

void _initBlog() {
  // datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(serviceLocator()))
    // repository
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        serviceLocator(), serviceLocator(), serviceLocator()))
    //usecase
    ..registerFactory(() => UploadBlog(serviceLocator()))
    //blog
    // vielleicht muss in blogBlog uploaded und get uploaded umgeschrieben werden
    ..registerFactory(() => GetUploadedBlogs(serviceLocator()))
    ..registerLazySingleton(() => BlogBloc(serviceLocator(), serviceLocator()));
}
