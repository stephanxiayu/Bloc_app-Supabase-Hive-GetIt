import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/core/usecase/usecase.dart';
import 'package:new_bloc_clean_app/core/common/entities/user_entities.dart';
import 'package:new_bloc_clean_app/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements Usecase<UserEntities, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, UserEntities>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
