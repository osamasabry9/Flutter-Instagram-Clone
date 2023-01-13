import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/assets_manager.dart';

Widget imageProfileWidget({String? imageUrl, File? image}) {
  if (image == null) {
    if (imageUrl == null || imageUrl == "") {
      return Image.asset(
        ImageAssets.profileDefault,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return const CircularProgressIndicator();
        },
        errorWidget: (context, url, error) => Image.asset(
          ImageAssets.profileDefault,
          fit: BoxFit.cover,
        ),
      );
    }
  } else {
    return Image.file(
      image,
      fit: BoxFit.cover,
    );
  }
}
