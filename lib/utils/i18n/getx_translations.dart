import 'package:get/get.dart';

import 'resources/resources.dart';

class GetxTranslations implements Translations {
  Map<String, Map<String, String>> get keys => {
    'pt_BR': PtBr().toJson(),
    'en_US': EnUs().toJson(),
  };
}