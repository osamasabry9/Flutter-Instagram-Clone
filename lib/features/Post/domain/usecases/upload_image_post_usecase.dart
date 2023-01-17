import 'dart:io';

import '../repository/post_firebase_repository.dart';


class UploadImagePostUseCase {
  final PostFirebaseRepository repository;

  UploadImagePostUseCase({required this.repository});

  Future<String> call(File file) {
    return repository.uploadPostImageToStorage(file);
  }
}
