import 'dart:ui';

import 'package:cap_countdown/src/exam/question_note.dart';
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

  Color get accentColor =>
      Color(StorageHelper.get<int>('accent_color', 0xFFD0BCFF));

  set accentColor(Color? value) =>
      StorageHelper.set<int?>('accent_color', value?.value);

  /// A map of question hashes to notes.
  Map<String, QuestionNote> get questionNotes {
    final map = StorageHelper.get<Map>('question_notes', {});

    return map.map((key, value) => MapEntry(key, QuestionNote.fromJson(value)));
  }

  set questionNotes(Map<String, QuestionNote> value) {
    StorageHelper.set<Map<String, Map>>('question_notes',
        value.map((key, value) => MapEntry(key, value.toJson())));
  }

  /// A list of optional question hashes that have been answered.
  List<String> get answeredQuestions =>
      StorageHelper.get<List>('answered_questions', []).cast<String>();

  set answeredQuestions(List<String> value) =>
      StorageHelper.set<List<String>>('answered_questions', value);
}
