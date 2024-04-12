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

class ErrorWhileAddingNameToFavorite extends GenericError {
  ErrorWhileAddingNameToFavorite(super.errorMessage);
}

class ErrorWhileRemovingNameToFavorite extends GenericError {
  ErrorWhileRemovingNameToFavorite(super.errorMessage);
}
