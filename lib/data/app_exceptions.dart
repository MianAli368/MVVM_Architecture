class AppException implements Exception {
  final _prefix;
  final _message;

  AppException([this._prefix, this._message]);

  String toString() {
    return "$_prefix $_message";
  }
}

// Request TimeOut Exception
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication");
}


// Bad Request Exception
class BadReqeustException extends AppException {
  BadReqeustException([String? message])
      : super(message, "Invalid Request");
}


// Unauthorized Exception
// Token is used to validate user for giving 
// access to data that is related to him.
// Every use have token when he logged in
// we get a token to validate the user.
class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, "Unauthorized Request");
}


class InvalidException extends AppException {
  InvalidException([String? message])
      : super(message, "Invalid Input");
}