import 'dart:io';
import 'dart:math';

import 'package:colors_blind/core/services/upload_image/upload_image_service.dart';

class UploadImageServiceFakeImplementation implements UploadImageService {
  @override
  Future<String> uploadImage(File image) async {
    await Future.delayed(const Duration(seconds: 1));


    return [
      'https://husmiyfbldyrrgwihgpn.supabase.co/storage/v1/object/public/product-images/10_159878852_1000000032.jpg',
      'https://husmiyfbldyrrgwihgpn.supabase.co/storage/v1/object/public/product-images/10_188461868_1000000029.jpg',
      'https://husmiyfbldyrrgwihgpn.supabase.co/storage/v1/object/public/product-images/11_140102799_1000000034.jpg',
      'https://husmiyfbldyrrgwihgpn.supabase.co/storage/v1/object/public/product-images/8_226229632_1000000023.jpg',
    ][Random().nextInt(4)];
  }
  
  @override
  Future<void> deleteImage() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}