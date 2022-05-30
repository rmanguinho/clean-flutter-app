import 'package:get/get.dart';

mixin NavigationManager on GetxController {
  final Rx<String?> _navigateTo = Rx<String?>(null);
  Stream<String?> get navigateToStream => _navigateTo.stream;
  set navigateTo(String value) => _navigateTo.subject.add(value);
}
