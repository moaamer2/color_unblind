
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';

class DefaultResponse<T> {
  dynamic data;

  int status;

  String message;

  DefaultResponse({this.data, required this.status, required this.message});

  factory DefaultResponse.fromJson(dynamic json){
    if (json is Map<String, dynamic>) {
      return DefaultResponse(
        data: json['data'] ?? json,
        status: int.tryParse((json['status'] ?? '0').toString(),) ?? 0,
        message: json['message']?.toString() ?? LocaleKeys.error,
      );
    }
    else{
      return DefaultResponse(
        message: 'cannot parse json',
        status: 0,
      );
    }
  }
}
