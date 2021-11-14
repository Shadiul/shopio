import 'dart:developer';

enum LogColor { black, red, green, yellow, blue, magenta, cyan, white }

void logColored(String value, {LogColor? color}) {
  switch (color) {
    case LogColor.black:
      log('\x1B[30m$value\x1B[0m', stackTrace: StackTrace.current);
      break;
    case LogColor.red:
      log('\x1B[31m$value\x1B[0m');
      break;
    case LogColor.green:
      log('\x1B[32m$value\x1B[0m');
      break;
    case LogColor.yellow:
      log('\x1B[33m$value\x1B[0m');
      break;
    case LogColor.blue:
      log('\x1B[34m$value\x1B[0m');
      break;
    case LogColor.magenta:
      log('\x1B[35m$value\x1B[0m');
      break;
    case LogColor.cyan:
      log('\x1B[36m$value\x1B[0m');
      break;
    case LogColor.white:
      log('\x1B[37m$value\x1B[0m');
      break;
    default:
      log(value);
  }
}
