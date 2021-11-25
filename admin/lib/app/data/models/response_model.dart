import '../../utils/log_colored.dart';
import '../enums.dart';

class ResponseModel {
  final ResponseStatus status;
  final String? code;
  final String message;
  final dynamic data;

  ResponseModel({
    required this.status,
    this.code,
    required this.message,
    this.data,
  }) {
    LogColor color = LogColor.white;
    switch (status) {
      case ResponseStatus.empty:
        color = LogColor.magenta;
        break;
      case ResponseStatus.error:
        color = LogColor.red;
        break;
      case ResponseStatus.success:
        color = LogColor.green;
        break;
      default:
        color = LogColor.white;
        break;
    }
    if (code != null) logColored(code!, color: color);
    logColored(message, color: color);
  }
}
