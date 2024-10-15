import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_pm/domain/entities/movie.dart';

class MovieCarousel extends StatelessWidget {
  const MovieCarousel({
    super.key,
    required this.movies,
  });

  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return FanCarouselImageSlider.sliderType1(
      imagesLink: movies
          .map((item) => item.providePosterPath())
          .where((path) => path.isNotEmpty)
          .cast<String>()
          .toList(),
      isAssets: false,
      autoPlay: false,
      sliderHeight: 400,
      showIndicator: true,
      initalPageIndex: 0,
    );
  }
}
