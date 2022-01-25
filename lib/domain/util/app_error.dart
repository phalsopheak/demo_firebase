import 'package:demo_firebase/core/enum/app_error_type_enum.dart';

class AppError {
  final AppErrorType appErrorType;
  final String description;
  AppError({
    this.description = '',
    required this.appErrorType,
  });

  showError() {
    if (appErrorType == AppErrorType.database) {
    } else if (appErrorType == AppErrorType.io) {
    } else if (appErrorType == AppErrorType.api) {
    } else if (appErrorType == AppErrorType.connection) {}
  }
}
