import 'package:get/get.dart';

import '../../ui/helpers/helpers.dart';

mixin UIErrorManager on GetxController {
  final Rx<UIError?> _mainError = Rx<UIError?>(null);
  Stream<UIError?> get mainErrorStream => _mainError.stream;
  set mainError(UIError? value) => _mainError.value = value;
}
