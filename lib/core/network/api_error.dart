class ApiError {
  final int? statusCode;
  final String message;
  ApiError({this.statusCode, required this.message});

  @override
  String toString() {
    return "error cause : $message status code : $statusCode";
  }
}
