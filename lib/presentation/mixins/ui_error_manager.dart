import 'package:get/get.dart';

import '../../ui/helpers/helpers.dart';

mixin UIErrorManager {
  final _mainError = Rx<UIError>();
  Stream<UIError> get mainErrorStream => _mainError.stream;
  set mainError(UIError value) => _mainError.value = value;
}