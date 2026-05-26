/// Logger da aplicação
class Logger {
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    print('[DEBUG] $message');
    if (error != null) print('[ERROR] $error');
    if (stackTrace != null) print(stackTrace);
  }

  static void info(String message) {
    print('[INFO] $message');
  }

  static void warning(String message) {
    print('[WARNING] $message');
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    print('[ERROR] $message');
    if (error != null) print('[ERROR_DETAIL] $error');
    if (stackTrace != null) print(stackTrace);
  }
}
