import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bloc_clean_app/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final response = await _userSignUp(UserSignUpPramas(
          email: event.email, password: event.password, name: event.name));

      response.fold(
          (l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
    });
  }
}
