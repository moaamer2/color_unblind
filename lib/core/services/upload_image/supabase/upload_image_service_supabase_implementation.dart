import 'dart:io';
import 'dart:math';
import 'package:colors_blind/core/services/upload_image/supabase/utils/supabase_bukets.dart';
import 'package:colors_blind/core/services/upload_image/upload_image_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadImageServiceSupabaseImplementation implements UploadImageService {
  String? currentPath;
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<String> uploadImage(File image) async {
    currentPath = '${image.hashCode}${Random().nextInt(100000000)}';

    // upload image
    await _supabase.storage.from(SupabaseBukets.userImages).upload(
      currentPath ?? image.path,
      image,
    );

    final String url = _supabase.storage.from(SupabaseBukets.userImages).getPublicUrl(
      currentPath ?? image.path,
    );

    return url;
  }

  @override
  Future<void> deleteImage() async {
    await _supabase.storage.from(SupabaseBukets.userImages).remove(
      [currentPath ?? ''],
    );
  }
}
