import 'package:get_it/get_it.dart';
import 'package:new_bloc_clean_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:new_bloc_clean_app/core/secrets/app_secrets.dart';
import 'package:new_bloc_clean_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:new_bloc_clean_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:new_bloc_clean_app/features/auth/domain/repository/auth_repository.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/current_user.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/user_login.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/user_signup.dart';
import 'package:new_bloc_clean_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:new_bloc_clean_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:new_bloc_clean_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:new_bloc_clean_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:new_bloc_clean_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:new_bloc_clean_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnon);

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
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
    ..registerFactory<BlogRepository>(
        () => BlogRepositoryImpl(serviceLocator()))
    //usecase
    ..registerFactory(() => UploadBlog(serviceLocator()))
    //blog
    ..registerLazySingleton(() => BlogBloc(serviceLocator()));
}
