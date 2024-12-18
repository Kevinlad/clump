import 'package:clump_project/model/user_model.dart';

class RegistrationResponse {
  final bool status;
  final String message;
  final UserData data;

  RegistrationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String userToken;
  final User user;

  UserData({
    required this.userToken,
    required this.user,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userToken: json['user_token'],
      user: User.fromJson(json['user']),
    );
  }
}
