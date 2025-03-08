class Failure {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode - Error: $message';
}
