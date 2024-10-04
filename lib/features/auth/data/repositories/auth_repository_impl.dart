import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/exceptions.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/core/network/connection_checker.dart';
import 'package:new_bloc_clean_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:new_bloc_clean_app/core/common/entities/user_entities.dart';
import 'package:new_bloc_clean_app/features/auth/data/models/user_models.dart';
import 'package:new_bloc_clean_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, UserEntities>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("keine Internetverbindung"));
      }
      final user = await remoteDataSource.loginWithEmailPassword(
          email: email, password: password);

      return right(user);
      // AuthException comes from superbase itself
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntities>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("keine Internetverbindung"));
      }
      final user = await remoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password);

      return right(user);
      // AuthException comes from superbase itself
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntities>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure("Du bist nicht eingeloggt"));
        }
        return right(UserModel(
            id: session.user.id, email: session.user.email ?? "", name: ""));
      }
      final user = await remoteDataSource.getUserCurrentData();
      if (user == null) {
        return left(Failure("User not logged in"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
