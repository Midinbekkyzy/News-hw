abstract interface class AuthDataSource {
  Future<bool> auth(String login, String password);

  Future<void> logout();
}
