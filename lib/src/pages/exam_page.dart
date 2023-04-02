import 'package:cap_countdown/src/exam/exam_loader.dart';
import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage>
    with AutomaticKeepAliveClientMixin {
  final examScope = ExamLoader.exams.map((e) => e.name);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '請選擇試題類型',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Card(
              child: InkResponse(
                onTap: () => _handleOptionChange(ExamType.simulation),
                child: _buildCard(
                  title: '模擬歷屆會考',
                  description:
                      '透過模擬歷屆會考，讓您身歷其境地感受考試的氛圍。最後，在考試結束後記得查看答案與詳解，並紀錄錯題了解弱點！',
                  image: 'assets/images/materials/homework.png',
                ),
              ),
            ),
            Card(
              child: InkResponse(
                onTap: () => _handleOptionChange(ExamType.random),
                child: _buildCard(
                  title: '隨機抽題',
                  description: '從龐大的題庫中抽取試題來練習吧！\n此外也支援自訂抽題範圍，讓您更能針對特定部份加強練習～',
                  image: 'assets/images/materials/dice.png',
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget _buildCard({
    required String title,
    required String description,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
          ),
        ],
      ),
    );
  }

  void _handleOptionChange(ExamType option) {
    // TODO: implement
  }

  @override
  bool get wantKeepAlive => true;
}

enum ExamType { random, simulation }
