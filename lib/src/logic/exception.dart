class FatoraException implements Exception {
  final String message;

  FatoraException(this.message);

  @override
  String toString() {
    return message;
  }
}

class NetworkException extends FatoraException {
  NetworkException(String message) : super(message);
}

class ServerException extends FatoraException {
  ServerException(String message) : super(message);
}

class UnknownException extends FatoraException {
  UnknownException(String message) : super(message);
}
