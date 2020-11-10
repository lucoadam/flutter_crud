class AuthenticationException implements Exception{
  final String message;

  AuthenticationException({this.message = 'An Unknown error occurred. '});
}