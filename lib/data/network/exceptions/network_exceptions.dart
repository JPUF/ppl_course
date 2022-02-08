class NetworkException implements Exception {
  final String _message;
  final String _prefix;

  NetworkException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchException extends NetworkException {
  FetchException(String message) : super(message, "Network Error: ");
}

class BadRequestException extends NetworkException {
  BadRequestException(message) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException(message) : super(message, "Unauthorised: ");
}

class InvalidInputException extends NetworkException {
  InvalidInputException(message) : super(message, "Invalid Input: ");
}
