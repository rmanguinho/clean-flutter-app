import '../surveys.dart';
import './components.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SurveyItems extends StatelessWidget {
  final List<SurveyViewModel> viewModels;

  SurveyItems(this.viewModels);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          aspectRatio: 1
        ),
        items: viewModels.map((viewModel) => SurveyItem(viewModel)).toList(),
      ),
    );
  }
}