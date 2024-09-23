import 'package:new_bloc_clean_app/features/auth/domain/entities/user_entities.dart';

class UserModel extends UserEntities {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? "",
      email: map["email"] ?? "",
      name: map["name"] ?? "",
    );
  }
}
