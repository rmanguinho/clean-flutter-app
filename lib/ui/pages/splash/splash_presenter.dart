abstract class SplashPresenter {
  Stream<String> get navigateToStream;

  Future<void> loadCurrentAccount();
}