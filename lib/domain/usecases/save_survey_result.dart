import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class SaveSurveyResult {
  Future<SurveyResultEntity> save({@required String answer});
}