import 'package:flutter/material.dart';

class QuestionImage extends StatelessWidget {
  final String imageFileName;

  const QuestionImage({
    super.key,
    required this.imageFileName,
  });

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isMobile =
        platform == TargetPlatform.android || platform == TargetPlatform.iOS;
    final isDesktop = platform == TargetPlatform.linux ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows;

    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/exam/$imageFileName',
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('試題圖片檢視器'),
              ),
              body: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      if (isMobile) const Text('請透過雙指縮放或拖曳來檢視圖片'),
                      if (isDesktop) const Text('請透過滑鼠滾輪縮放或拖曳來檢視圖片'),
                      Expanded(
                        child: InteractiveViewer(
                          boundaryMargin: const EdgeInsets.all(100),
                          maxScale: 6,
                          child:
                              Image.asset('assets/images/exam/$imageFileName'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
