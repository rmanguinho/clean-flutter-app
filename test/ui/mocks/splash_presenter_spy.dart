import 'package:fordev/ui/pages/pages.dart';

import 'dart:async';
import 'package:mocktail/mocktail.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {
  final navigateToController = StreamController<String?>();

  SplashPresenterSpy() {
    when(() => checkAccount(durationInSeconds: any(named: 'durationInSeconds')))
        .thenAnswer((_) async => _);
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
  }
  void emitNavigateTo(String route) => navigateToController.add(route);

  void dispose() {
    navigateToController.close();
  }
}
