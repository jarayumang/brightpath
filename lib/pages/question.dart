import 'package:flutter/material.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Question',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
