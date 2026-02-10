enum FailureType { unknown, timeout, forbidden, notFound, badRequest, invalidInput, noInternet }

class Failure {
  FailureType type;
  String message;

  Failure({this.type = FailureType.unknown, this.message = ''});

  factory Failure.fromException(dynamic e) => Failure(message: e.toString().replaceAll('Exception: ', ''));
}
