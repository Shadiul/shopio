import 'dart:developer';

enum LogColor { black, red, green, yellow, blue, magenta, cyan, white }

void logColored(String value, {LogColor? color}) {
  String colorCode;
  switch (color) {
    case LogColor.black:
      colorCode = '\x1B[30m';
      break;
    case LogColor.red:
      colorCode = '\x1B[31m';
      break;
    case LogColor.green:
      colorCode = '\x1B[32m';
      break;
    case LogColor.yellow:
      colorCode = '\x1B[33m';
      break;
    case LogColor.blue:
      colorCode = '\x1B[34m';
      break;
    case LogColor.magenta:
      colorCode = '\x1B[35m';
      break;
    case LogColor.cyan:
      colorCode = '\x1B[36m';
      break;
    case LogColor.white:
      colorCode = '\x1B[37m';
      break;
    default:
      colorCode = '';
      break;
  }

  log('$colorCode$value\x1B[0m');
}
