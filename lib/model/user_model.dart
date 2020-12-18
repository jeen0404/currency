


class UserModel{
  final String username;
  final String password;

  UserModel(this.username, this.password);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}