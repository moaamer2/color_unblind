import 'dart:io';

abstract class UploadImageService {
  Future<String> uploadImage(File image);

  Future<void> deleteImage();
}