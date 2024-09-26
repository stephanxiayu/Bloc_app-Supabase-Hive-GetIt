import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/core/usecase/usecase.dart';
import 'package:new_bloc_clean_app/core/common/entities/user_entities.dart';
import 'package:new_bloc_clean_app/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements Usecase<UserEntities, UserLoginPramas> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, UserEntities>> call(UserLoginPramas params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.email);
  }
}

class UserLoginPramas {
  final String email;
  final String password;

  UserLoginPramas({
    required this.email,
    required this.password,
  });
}
