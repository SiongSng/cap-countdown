import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class QuestionAudioPlayer extends StatefulWidget {
  final String audioFileName;
  final bool onlyPlayOnce;
  final ValueChanged<PlayerState>? onAudioPlayStateChanged;

  const QuestionAudioPlayer(
      {Key? key,
      required this.audioFileName,
      required this.onlyPlayOnce,
      this.onAudioPlayStateChanged})
      : super(key: key);

  @override
  State<QuestionAudioPlayer> createState() => _QuestionAudioPlayerState();
}

class _QuestionAudioPlayerState extends State<QuestionAudioPlayer> {
  final player = AudioPlayer();

  Duration? duration;
  int audioPosition = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initPlayer();
    });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = player.state == PlayerState.playing;

    return VisibilityDetector(
      key: Key(
          'question_audio_player_${widget.audioFileName}_visibility_detector'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (!widget.onlyPlayOnce) return;

        if (info.visibleFraction == 0 && isPlaying) {
          player.pause();
        } else if (player.state == PlayerState.paused) {
          player.resume();
        }
      },
      child: Column(
        children: [
          _buildPlayIndicator(),
          if (!widget.onlyPlayOnce) ...[
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(isPlaying ? '暫停播放' : '播放聽力試題'),
              onPressed: () {
                if (isPlaying) {
                  player.pause();
                } else {
                  player.resume();
                }
                setState(() {});
              },
            )
          ]
        ],
      ),
    );
  }

  Widget _buildPlayIndicator() {
    if (duration == null) {
      return const SizedBox.shrink();
    }

    if (player.state == PlayerState.playing && audioPosition == 0) {
      return const Center(
        child:
            SizedBox(width: 24, height: 24, child: CircularProgressIndicator()),
      );
    }

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      tween: Tween<double>(
          begin: 0, end: audioPosition / duration!.inMilliseconds),
      builder: (context, value, _) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(value: value)),
    );
  }

  Future<void> _initPlayer() async {
    await player.setSourceAsset('audios/exam/${widget.audioFileName}');

    player.onPlayerStateChanged.listen((state) {
      if (!mounted) return;

      widget.onAudioPlayStateChanged?.call(state);
    });

    player.onDurationChanged.listen((event) {
      if (event.inMicroseconds == 0 || !mounted) return;

      setState(() {
        duration = event;
      });
    });

    player.onPositionChanged.listen((event) {
      if (!mounted) return;

      setState(() {
        audioPosition = event.inMilliseconds;
      });
    });

    player.onPlayerComplete.listen((event) {
      if (!mounted || duration == null) return;

      setState(() {
        audioPosition = duration!.inMilliseconds;
      });
    });

    if (widget.onlyPlayOnce) {
      await player.resume();
    }
  }
}
