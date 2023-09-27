abstract class AppError {
  String getError();
}

class GenericAppError extends AppError {
  final String _errorMessage;
  GenericAppError(this._errorMessage);

  @override
  String getError() => _errorMessage;
}
