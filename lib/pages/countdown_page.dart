import 'package:cap_countdown/widgets/cap_time_left.dart';
import 'package:flutter/material.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [CAPTimeLeft(showDetail: true)],
    );
  }
}
