import 'package:flutter/material.dart';

abstract class SplashPresenter implements Listenable {
  Stream<String?> get navigateToStream;

  Future<void> checkAccount({int durationInSeconds});
}