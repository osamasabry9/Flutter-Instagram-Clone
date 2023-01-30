import 'dart:io';

import '../repository/story_firebase_repository.dart';

class UploadImageStoryUseCase {
  final StoryRepository repository;

  UploadImageStoryUseCase({required this.repository});

  Future<String> call(File file) {
    return repository.uploadStoryImageToStorage(file);
  }
}
