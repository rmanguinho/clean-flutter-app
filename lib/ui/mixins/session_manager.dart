import 'package:get/get.dart';

mixin SessionManager {
  void handleSessionExpired(Stream<bool> stream) {
    stream.listen((bool isExpired) {
      if (isExpired == true) {
        Get.offAllNamed('/login');
      }
    });
  }
}
