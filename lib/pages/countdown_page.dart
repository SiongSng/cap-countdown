import 'package:flutter/material.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('這裡是倒數頁面');
  }
}
