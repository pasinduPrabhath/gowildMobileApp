class UserLogin {
  String email;
  String password;
  UserLogin({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  static UserLogin fromMap(Map<String, dynamic> map) {
    return UserLogin(
      email: map['email'],
      password: map['password'],
    );
  }
}
