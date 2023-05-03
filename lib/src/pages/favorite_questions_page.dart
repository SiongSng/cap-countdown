import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/exam/exam_loader.dart';
import 'package:cap_countdown/src/exam/group_choice_question.dart';
import 'package:cap_countdown/src/exam/single_choice_question.dart';
import 'package:cap_countdown/src/exam/subject_question.dart';
import 'package:cap_countdown/src/widgets/optional_question_view.dart';
import 'package:cap_countdown/src/widgets/subject_question_view.dart';
import 'package:flutter/material.dart';

class FavoriteQuestionsPage extends StatefulWidget {
  const FavoriteQuestionsPage({Key? key}) : super(key: key);

  @override
  State<FavoriteQuestionsPage> createState() => _FavoriteQuestionsPageState();
}

class _FavoriteQuestionsPageState extends State<FavoriteQuestionsPage> {
  @override
  Widget build(BuildContext context) {
    final favorites = localStorage.questionRecords.entries
        .where((entry) => entry.value.isFavorite)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('題目收藏庫'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '重新整理',
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              final SubjectQuestion question;
              try {
                question = ExamLoader.getAllQuestions()
                    .firstWhere((e) => e.hash == favorite.key);
              } on StateError {
                return const SizedBox.shrink();
              }

              final String? description;
              if (question is SingleChoiceQuestion) {
                description = question.description;
              } else if (question is GroupChoiceQuestion) {
                description = question.description;
              } else {
                description = null;
              }

              return ListTile(
                leading:
                    Text('${index + 1}.', style: const TextStyle(fontSize: 20)),
                title: Text(description ?? question.type.name,
                    overflow: TextOverflow.ellipsis),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          _showFavoriteQuestion(question);
                        },
                        tooltip: '檢視題目',
                        icon: const Icon(Icons.visibility)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            question.removeFromFavorite();
                          });
                        },
                        tooltip: '移除收藏',
                        icon: const Icon(Icons.delete_forever_rounded)),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void _showFavoriteQuestion(SubjectQuestion question) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('檢視收藏題目'),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SubjectQuestionView(
                      question: question,
                      meta: question.meta,
                      option: const QuestionViewOption(submitted: true)),
                ),
              ),
            )));
  }
}
