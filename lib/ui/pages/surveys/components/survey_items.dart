import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import './components.dart';
import '../surveys.dart';

class SurveyItems extends StatelessWidget {
  final List<SurveyViewModel> viewModels;

  const SurveyItems(this.viewModels, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 1),
        items: viewModels
            .map((SurveyViewModel viewModel) => SurveyItem(viewModel))
            .toList(),
      ),
    );
  }
}
