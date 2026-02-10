import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_contants.dart';

abstract interface class SupabaseHelper {
  static Future<void> init() async {
    await Supabase.initialize(
      url: SupabaseConstants.url,
      anonKey: SupabaseConstants.anonAPIKey,
    );
  }
}