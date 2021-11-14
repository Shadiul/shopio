import 'dart:developer';

enum LogColor { Black, Red, Green, Yellow, Blue, Magenta, Cyan, White }

void logColored(String value, {LogColor? color}) {
  switch (color) {
    case LogColor.Black:
      log('\x1B[30m$value\x1B[0m', stackTrace: StackTrace.current);
      break;
    case LogColor.Red:
      log('\x1B[31m$value\x1B[0m');
      break;
    case LogColor.Green:
      log('\x1B[32m$value\x1B[0m');
      break;
    case LogColor.Yellow:
      log('\x1B[33m$value\x1B[0m');
      break;
    case LogColor.Blue:
      log('\x1B[34m$value\x1B[0m');
      break;
    case LogColor.Magenta:
      log('\x1B[35m$value\x1B[0m');
      break;
    case LogColor.Cyan:
      log('\x1B[36m$value\x1B[0m');
      break;
    case LogColor.White:
      log('\x1B[37m$value\x1B[0m');
      break;
    default:
      log(value);
  }
}
