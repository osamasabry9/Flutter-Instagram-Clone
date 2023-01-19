import 'dart:io';

import '../repository/post_firebase_repository.dart';

class UploadImagePostUseCase {
  final PostRepository repository;

  UploadImagePostUseCase({required this.repository});

  Future<String> call(File file) {
    return repository.uploadPostImageToStorage(file);
  }
}
