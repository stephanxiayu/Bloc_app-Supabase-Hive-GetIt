import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/features/auth/domain/entities/user_entities.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntities>> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<Either<Failure, UserEntities>> loginWithEmailPassword(
      {required String email, required String password});
}
