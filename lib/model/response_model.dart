class Success {
  int code;
  Object response;
  Success({required this.code, required this.response});
}
class Failure {
  int code;
  String errorMessage;
  Failure({required this.code, required this.errorMessage});
}