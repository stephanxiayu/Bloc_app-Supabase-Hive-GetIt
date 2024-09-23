import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/core/usecase/usecase.dart';
import 'package:new_bloc_clean_app/features/auth/domain/entities/user_entities.dart';
import 'package:new_bloc_clean_app/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements Usecase<UserEntities, UserSignUpPramas> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, UserEntities>> call(UserSignUpPramas params) async {
    return await authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.email);
  }
}

class UserSignUpPramas {
  final String email;
  final String password;
  final String name;

  UserSignUpPramas(
      {required this.email, required this.password, required this.name});
}
