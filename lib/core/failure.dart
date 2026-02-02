abstract class Failure {
  final String? message;
  final int? statusCode;

  Failure({this.message, this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure(String? message) : super(message: message);
}

class LoginFailure extends Failure {
  LoginFailure(String? message) : super(message: message);
}

class ClientFailure extends Failure {
  ClientFailure(String? message) : super(message: message);
}

class OtherFailureNon200 extends Failure {
  OtherFailureNon200(String? message) : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String? message) : super(message: message);
}

// ✅ New Database Failure
class DatabaseFailure extends Failure {
  DatabaseFailure(String? message) : super(message: message);
}

class ItemNotFoundFailure extends Failure {
  ItemNotFoundFailure(String message) : super(message: message);
}
