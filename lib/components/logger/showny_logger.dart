import 'package:logger/logger.dart';

class ShownyLog {
  late Logger logger;

  static final ShownyLog _instance = ShownyLog._internal();

  factory ShownyLog() {
    return _instance;
  }

  d(String message) {
    logger.d(message);
  }

  i(String message) {
    logger.i(message);
  }

  e(String message) {
    logger.e(message);
  }

  changeLoggingEnable() {
    logger = Logger(filter: LogEnableFilter());
  }

  ShownyLog._internal() {
    logger = Logger(printer: PrettyPrinter(methodCount: 0));
  }
}

class LogEnableFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
