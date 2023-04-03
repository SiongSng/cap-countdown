import 'package:flutter/material.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class QuestionImage extends StatelessWidget {
  final String imageFileName;

  const QuestionImage({
    super.key,
    required this.imageFileName,
  });

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        'assets/images/exam/$imageFileName',
        fit: BoxFit.fitWidth,
      ),
    );
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.android || platform == TargetPlatform.iOS) {
      return ZoomOverlay(
        maxScale: 5.0,
        child: image,
      );
    }

    return image;
  }
}
