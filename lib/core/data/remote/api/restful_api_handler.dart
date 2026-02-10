
import 'package:colors_blind/core/data/remote/api/responses/default_response.dart';

abstract class RestfulApiHandler {
  Future<DefaultResponse> get({
    required String endpoint,
    Map<String, dynamic>? params,
  });

  Future<DefaultResponse> post({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  });

  Future<DefaultResponse> put({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  });

  Future<DefaultResponse> patch({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  });

  Future<DefaultResponse> delete({
    required String endpoint,
    Map<String, dynamic>? params,
  });
}
