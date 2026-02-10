import 'package:colors_blind/core/data/remote/api/responses/default_response.dart';
import 'package:colors_blind/core/data/remote/api/restful_api_base_urls.dart';
import 'package:colors_blind/core/services/internet_state/internet_state_service.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:dio/dio.dart';
import '../restful_api_handler.dart';

class RestfulApiHandlerDioImpl implements RestfulApiHandler {
  late final Dio _dio;
  final InternetStateService _internetStateService;

  RestfulApiHandlerDioImpl(this._internetStateService){
    _init();
  }

  @override
  Future<DefaultResponse> delete({
    required String endpoint,
    Map<String, dynamic>? params,
  }) async {
    await _checkInternet();
    final response = await _dio.delete(endpoint, queryParameters: params);
    return DefaultResponse.fromJson(response.data);
  }

  @override
  Future<DefaultResponse> get({
    required String endpoint,
    Map<String, dynamic>? params,
  }) async {
    await _checkInternet();
    final response = await _dio.get(endpoint, queryParameters: params);

    return DefaultResponse.fromJson(response.data);
  }

  @override
  Future<DefaultResponse> patch({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    await _checkInternet();

    final response = await _dio.patch(
      endpoint,
      data: body,
      queryParameters: params,
    );
    return DefaultResponse.fromJson(response.data);
  }

  @override
  Future<DefaultResponse> post({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    await _checkInternet();

    final response = await _dio.post(
      endpoint,
      data: body,
      queryParameters: params,
    );

    return DefaultResponse.fromJson(response.data);
  }

  @override
  Future<DefaultResponse> put({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    await _checkInternet();

    final response = await _dio.put(
      endpoint,
      data: body,
      queryParameters: params,
    );
    return DefaultResponse.fromJson(response.data);
  }

  Future<void> _checkInternet() async {
    final isConnected = await _internetStateService.isConnected();
    if (!isConnected) {
      throw Exception(LocaleKeys.NoInternetConnection);
    }
  }

  void _init(){
    _dio = Dio(
      BaseOptions(
        baseUrl: RestfulApiBaseUrls.baseUrl,
      ),
    );
  }
}
