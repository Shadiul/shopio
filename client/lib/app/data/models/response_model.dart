import '../../utils/log_colored.dart';
import '../enums.dart';

class ResponseModel {
  final ResponseStatus status;
  final String message;
  final dynamic data;

  ResponseModel({required this.status, required this.message, this.data}) {
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
    logColored(message, color: color);
  }
}
