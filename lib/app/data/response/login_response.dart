class LoginResponse {
  final String message;
  final int userId;

  const LoginResponse({required this.message, required this.userId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'message': String message,
        'user_id': int userId,
      } =>
        LoginResponse(message: message, userId: userId),
      _ => throw FormatException('Login Failed.'),
    };
  }
}
