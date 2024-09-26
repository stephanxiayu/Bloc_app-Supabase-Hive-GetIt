import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bloc_clean_app/core/common/cubits/app_user/app_user_state.dart';
import 'package:new_bloc_clean_app/core/common/entities/user_entities.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(UserEntities? userEntities) {
    if (userEntities == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(userEntities));
    }
  }
}
