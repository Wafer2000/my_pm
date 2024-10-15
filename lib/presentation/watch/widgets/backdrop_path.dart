import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_pm/common/widgets/movie_loading.dart';
import 'package:my_pm/core/configs/assets/app_images.dart';

class BackdropPath extends StatelessWidget {
  final String backdropPath;
  const BackdropPath({required this.backdropPath, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: backdropPath,
      fit: BoxFit.cover,
      height: 300,
      width: double.infinity,
      placeholder: (context, url) {
        return const MovieLoading();
      },
      errorWidget: (context, url, stackTrace) {
        return Image.asset(
          AppImages.defaultImageLocal,
          fit: BoxFit.cover,
          height: 300,
        );
      },
    );
  }
}
