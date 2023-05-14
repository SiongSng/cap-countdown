import 'dart:typed_data';
import 'dart:ui';

import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/question_record.dart';
import 'package:pub_semver/pub_semver.dart';

import 'app_theme.dart';
import 'storage.dart';

class LocalStorage {
  /// Merge the records of question notes and answered questions into a new record format.
  /// This is only used for migrating old data (before v0.1.3).
  static void mergeQuestionRecords() {
    final questionNotes = StorageHelper.get<Map>('question_notes', {});
    if (questionNotes.isNotEmpty) {
      final records = localStorage.questionRecords;
      for (final note in questionNotes.entries) {
        final hash = note.key;
        var record = QuestionRecord.getByHash(hash);

        record = record.copyWith(note: note.value['text']);
        records[hash] = record;
      }
      localStorage.questionRecords = records;
      StorageHelper.set('question_notes', null);
    }

    final answeredQuestions =
        StorageHelper.get<List>('answered_questions', []).cast<String>();
    if (answeredQuestions.isNotEmpty) {
      final records = localStorage.questionRecords;
      for (String hash in answeredQuestions) {
        var record = QuestionRecord.getByHash(hash);
        record = record.copyWith(answerHistory: [
          ...record.answerHistory,
          AnswerHistory(
              date: DateTime.now(), selectedAnswer: null, isCorrect: true)
        ]);
        records[hash] = record;
      }
      localStorage.questionRecords = records;
      StorageHelper.set('answered_questions', null);
    }
  }

  AppTheme get appTheme => AppTheme.values.byName(
      StorageHelper.get<String>('app_theme', AppTheme.followSystem.name));

  set appTheme(AppTheme value) => StorageHelper.set('app_theme', value.name);

  Color get accentColor =>
      Color(StorageHelper.get<int>('accent_color', 0xFFD0BCFF));

  set accentColor(Color? value) =>
      StorageHelper.set<int?>('accent_color', value?.value);

  Uint8List? get personalAvatar {
    final bytes = StorageHelper.get<List?>('personal_avatar')?.cast<int>();

    return bytes == null ? null : Uint8List.fromList(bytes);
  }

  set personalAvatar(Uint8List? value) =>
      StorageHelper.set<List<int>?>('personal_avatar', value?.toList());

  String? get personalName => StorageHelper.get<String?>('personal_name');

  set personalName(String? value) =>
      StorageHelper.set<String?>('personal_name', value);

  Map<String, QuestionRecord> get questionRecords {
    final map = StorageHelper.get<Map>('question_records', {});

    return map
        .map((key, value) => MapEntry(key, QuestionRecord.fromJson(value)));
  }

  set questionRecords(Map<String, QuestionRecord> value) {
    StorageHelper.set<Map<String, Map>>('question_records',
        value.map((key, value) => MapEntry(key, value.toJson())));
  }

  Version? get lastVersion {
    final version = StorageHelper.get<String?>('last_version');
    return version == null ? null : Version.parse(version);
  }

  set lastVersion(Version? value) =>
      StorageHelper.set<String?>('last_version', value?.toString());

  bool get userFriendlyCountdown =>
      StorageHelper.get<bool>('user_friendly_countdown', true);

  set userFriendlyCountdown(bool value) =>
      StorageHelper.set<bool>('user_friendly_countdown', value);
}
