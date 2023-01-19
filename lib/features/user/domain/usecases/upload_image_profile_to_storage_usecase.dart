import 'dart:io';

import '../repository/user_firebase_repository.dart';

class UploadImageProfileToStorageUseCase {
  final UserRepository repository;

  UploadImageProfileToStorageUseCase({required this.repository});

  Future<String> call(File file) {
    return repository.uploadImageProfileToStorage(file);
  }
}
