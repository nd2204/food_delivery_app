abstract class DomainError extends Error {
  final String message;

  DomainError({required this.message});
}

class AuthenticationError extends DomainError {
  AuthenticationError([String reason = "Authentication failed"])
    : super(message: reason);
}
