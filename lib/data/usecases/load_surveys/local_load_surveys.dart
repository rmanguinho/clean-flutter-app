import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../cache/cache.dart';
import '../../models/models.dart';

class LocalLoadSurveys implements LoadSurveys {
  final CacheStorage cacheStorage;

  LocalLoadSurveys({ required this.cacheStorage });

  Future<List<SurveyEntity>> load() async {
    try {
      final data = await cacheStorage.fetch('surveys');
      if (data?.isEmpty != false) {
        throw Exception();
      }
      return _mapToEntity(data);
    } catch(error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate() async {
    try {
      final data = await cacheStorage.fetch('surveys');
      _mapToEntity(data);
    } catch(error) {
      await cacheStorage.delete('surveys');
    }
  }

  Future<void> save(List<SurveyEntity> surveys) async {
    try {
      final json = _mapToJson(surveys);
      await cacheStorage.save(key: 'surveys', value: json);
    } catch(error) {
      throw DomainError.unexpected;
    }
  }

  List<SurveyEntity> _mapToEntity(dynamic list) =>
    list.map<SurveyEntity>((json) => LocalSurveyModel.fromJson(json).toEntity()).toList();

  List<Map> _mapToJson(List<SurveyEntity> list) =>
    list.map((entity) => LocalSurveyModel.fromEntity(entity).toJson()).toList();
}