import 'package:flutter/material.dart';
import 'package:latext/latext.dart';

class QuestionText extends StatelessWidget {
  final String text;

  const QuestionText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use LaTexT to render LaTeX (math formula) in text.
    return LaTexT(
      laTeXCode: Text(text, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
