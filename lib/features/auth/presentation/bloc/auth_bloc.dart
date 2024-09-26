import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bloc_clean_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:new_bloc_clean_app/core/usecase/usecase.dart';
import 'package:new_bloc_clean_app/core/common/entities/user_entities.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/current_user.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/user_login.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required CurrentUser currentUser,
      required UserSignUp userSignUp,
      required UserLogin userLogin,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(UserSignUpPramas(
        email: event.email, password: event.password, name: event.name));

    response.fold((l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(UserLoginPramas(
      email: event.email,
      password: event.password,
    ));

    response.fold((l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response = await _currentUser(NoParams());
    response.fold((l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(UserEntities userEntities, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(userEntities);
    emit(AuthSuccess(userEntities));
  }
}
