import 'package:flutter/material.dart';
import 'package:new_bloc_clean_app/core/common/entities/user_entities.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final UserEntities userEntities;
  AppUserLoggedIn(this.userEntities);
}

// IMPORTANT! Core can depent on other Features, 
// but other Features can depent on Core