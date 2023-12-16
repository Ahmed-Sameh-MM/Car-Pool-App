abstract class ErrorTypes {

  final String errorMessage;
  final String errorTitle;
  final int errorId;

  const ErrorTypes({
    required this.errorMessage,
    required this.errorTitle,
    required this.errorId,
  });
}

class ConnectionError extends ErrorTypes {

  static const _errorTitle = 'Connection Error';

  static const _errorId = 80;

  const ConnectionError({
    required String errorMessage,
  }) : super(
    errorMessage: errorMessage,
    errorTitle: _errorTitle,
    errorId: _errorId,
  );
}

class FirebaseError extends ErrorTypes {

  static const _errorTitle = 'Server Error';
  
  const FirebaseError({
    required String errorMessage,
    required int errorId,
  }) : super(
    errorMessage: errorMessage,
    errorTitle: _errorTitle,
    errorId: errorId,
  );
}

class LateReservationError extends ErrorTypes {

  static const _errorTitle = 'Late Reservation';

  static const _errorId = 90;

  const LateReservationError({
    required String errorMessage,
  }) : super(
    errorMessage: errorMessage,
    errorTitle: _errorTitle,
    errorId: _errorId,
  );
}

class ExpiredCancellation extends ErrorTypes {

  static const _errorTitle = 'Expired Cancellation';

  static const _errorMessage = 'Cancellation is Expired';

  static const _errorId = 40;

  const ExpiredCancellation() : super(
    errorMessage: _errorMessage,
    errorTitle: _errorTitle,
    errorId: _errorId,
  );
}

class WrongPasswordError extends ErrorTypes {

  static const _errorTitle = 'Wrong Password';

  static const _errorId = 60;

  static const _errorMessage = 'Wrong password provided';
  
  const WrongPasswordError() : super(
    errorMessage: _errorMessage,
    errorTitle: _errorTitle,
    errorId: _errorId,
  );
}

class UserDisabledError extends ErrorTypes {

  static const _errorTitle = 'User Disabled';

  static const _errorMessage = 'user disabled, contact support !';

  static const _errorId = 30;

  const UserDisabledError() : super(
    errorMessage: _errorMessage,
    errorTitle: _errorTitle,
    errorId: _errorId,
  );
}

class UnexpectedError extends ErrorTypes {

  static const _errorTitle = 'Error';

  static const _errorMessage = 'Contact support error#512, ';
  
  UnexpectedError({
    required String customError,
    required int errorId,
  }) : super(
    errorMessage: _errorMessage + customError,
    errorTitle: _errorTitle,
    errorId: errorId,
  );
}