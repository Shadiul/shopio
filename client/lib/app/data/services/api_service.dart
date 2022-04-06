import 'package:client/app/data/models/models.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../enums.dart';

class ApiService extends GetxService {
  Future<ApiService> init() async {
    return this;
  }

  Logger logger = Logger();

  final GetConnect connect = GetConnect();

  static const String baseURL = 'https://api.imagga.com/v2/tags';

  Future<ResponseModel> searchForTags(String imageUrl) async {
    final url = '$baseURL?image_url=$imageUrl';

    final headers = {
      "Accept": "application/json",
      'Authorization':
          'Basic YWNjXzYxOGY4MjIxMjg0M2Y1Yzo3ZWU1M2U1ZGZmOWQyMzY4YmNjOGE2ODFmZDA1ZjQ3NA=='
    };

    ResponseModel response;
    try {
      final resp = await connect.get(url, headers: headers);
      response = ResponseModel(
        status: ResponseStatus.success,
        message: '⏬ Tags data fetch success',
        data: resp.body,
      );
    } catch (e) {
      logger.e(e);
      response = ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
    return response;
  }
}
