class RequestResult {
  final bool success;
  final bool duplicated;
  final String message;

  RequestResult({
    required this.success,
    this.duplicated = false,
    this.message = '',
  });
}