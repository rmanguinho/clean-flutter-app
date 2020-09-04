import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/usecases/usecases.dart';

import 'package:ForDev/ui/pages/pages.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;

  final _isLoading = true.obs;
  final _surveys = Rx<List<SurveyViewModel>>();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;

  GetxSurveysPresenter({@required this.loadSurveys});

  Future<void> loadData() async {
    _isLoading.value = true;
    final surveys = await loadSurveys.load();
    _surveys.value = surveys
      .map((survey) => SurveyViewModel(
        id: survey.id,
        question: survey.question,
        date: DateFormat('dd MMM yyyy').format(survey.dateTime),
        didAnswer: survey.didAnswer
      ))
      .toList();
    _isLoading.value = false;
  }
}

class LoadSurveysSpy extends Mock implements LoadSurveys {}

void main() {
  GetxSurveysPresenter sut;
  LoadSurveysSpy loadSurveys;
  List<SurveyEntity> surveys;

  List<SurveyEntity> mockValidData() => [
    SurveyEntity(id: faker.guid.guid(), question: faker.lorem.sentence(), dateTime: DateTime(2020, 2, 20), didAnswer: true),
    SurveyEntity(id: faker.guid.guid(), question: faker.lorem.sentence(), dateTime: DateTime(2018, 10, 3), didAnswer: false),
  ];

  void mockLoadSurveys(List<SurveyEntity> data) {
    surveys = data;
    when(loadSurveys.load()).thenAnswer((_) async => surveys);
  }

  setUp(() {
    loadSurveys = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
    mockLoadSurveys(mockValidData());
  });

  test('Should call LoadSurveys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.surveysStream.listen(expectAsync1((surveys) => expect(surveys, [
      SurveyViewModel(id: surveys[0].id, question: surveys[0].question, date: '20 Fev 2020', didAnswer: surveys[0].didAnswer),
      SurveyViewModel(id: surveys[1].id, question: surveys[1].question, date: '03 Out 2018', didAnswer: surveys[1].didAnswer),
    ])));

    await sut.loadData();
  });
}