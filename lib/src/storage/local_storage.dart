import 'package:cap_countdown/src/exam/subject_question.dart';

import 'app_theme.dart';
import 'storage.dart';

class LocalStorage {
  AppTheme get appTheme => AppTheme.values.byName(
      StorageHelper.get<String>('app_theme', AppTheme.followSystem.name));

  set appTheme(AppTheme value) => StorageHelper.set('app_theme', value.name);

  List<SubjectQuestion> get favoriteQuestions {
    final list = StorageHelper.get<List>('favorite_questions', [])
        .cast<Map<String, dynamic>>();

    return list
        .map((e) => SubjectQuestion.fromJson(e))
        .toList()
        .cast<SubjectQuestion>();
  }

  set favoriteQuestions(List<SubjectQuestion> value) {
    StorageHelper.set<List<Map>>(
        'favorite_questions', value.map((e) => e.toJson()).toList());
  }
}
