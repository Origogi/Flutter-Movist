import 'package:logger/logger.dart';

class DLog {
  static final logger = Logger();

  static void d(message) {
    return logger.d(message);
  }

  static void e(message) {
    return logger.e(message);
  }

  static void i(message) {
    return logger.i(message);
  }

  static void w(message) {
    return logger.w(message);
  }
}
