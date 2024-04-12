abstract class AppError {
  String getError();
}

class GenericError implements AppError {
  final String errorMessage;

  GenericError(this.errorMessage);

  @override
  String getError() {
    return errorMessage;
  }
}
