import '../entities/entities.dart';

import 'package:meta/meta.dart';

abstract class SaveSurveyResult {
  Future<SurveyResultEntity> save({@required String answer});
}