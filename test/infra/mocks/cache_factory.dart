import 'package:faker/faker.dart';

class CacheFactory {
  static Map makeSurveyResult() => {
    'surveyId': faker.guid.guid(),
    'question': faker.lorem.sentence(),
    'answers': [{
      'image': faker.internet.httpUrl(),
      'answer': faker.lorem.sentence(),
      'isCurrentAnswer': 'true',
      'percent': '40'
    }, {
      'answer': faker.lorem.sentence(),
      'isCurrentAnswer': 'false',
      'percent': '60'
    }],
  };

  static Map makeInvalidSurveyResult() => {
    'surveyId': faker.guid.guid(),
    'question': faker.lorem.sentence(),
    'answers': [{
      'image': faker.internet.httpUrl(),
      'answer': faker.lorem.sentence(),
      'isCurrentAnswer': 'invalid bool',
      'percent': 'invalid int'
    }],
  };

  static Map makeIncompleteSurveyResult() => {
    'surveyId': faker.guid.guid()
  };

  static List<Map> makeSurveyList() => [{
    'id': faker.guid.guid(),
    'question': faker.randomGenerator.string(10),
    'date': '2020-07-20T00:00:00Z',
    'didAnswer': 'false',
  }, {
    'id': faker.guid.guid(),
    'question': faker.randomGenerator.string(10),
    'date': '2019-02-02T00:00:00Z',
    'didAnswer': 'true',
  }];

  static List<Map> makeInvalidSurveyList() => [{
    'id': faker.guid.guid(),
    'question': faker.randomGenerator.string(10),
    'date': 'invalid date',
    'didAnswer': 'false',
  }];

  static List<Map> makeIncompleteSurveyList() => [{
    'date': '2019-02-02T00:00:00Z',
    'didAnswer': 'false',
  }];
}