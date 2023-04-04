import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class QuestionAudioPlayer extends StatefulWidget {
  final String audioFileName;
  final bool autoPlay;

  const QuestionAudioPlayer(
      {Key? key, required this.audioFileName, required this.autoPlay})
      : super(key: key);

  @override
  State<QuestionAudioPlayer> createState() => _QuestionAudioPlayerState();
}

class _QuestionAudioPlayerState extends State<QuestionAudioPlayer> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    if (widget.autoPlay) {
      _play();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void _play() {
    player.play(AssetSource('audios/exam/${widget.audioFileName}'));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.play_circle_outline),
      label: const Text('播放聽力試題'),
      onPressed: () {
        _play();
      },
    );
  }
}
