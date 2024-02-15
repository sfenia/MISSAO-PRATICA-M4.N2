import 'package:flutter/material.dart';

class TextCarousel extends StatefulWidget {
  final List<String> texts;

  const TextCarousel({Key? key, required this.texts}) : super(key: key);

  @override
  _TextCarouselState createState() => _TextCarouselState();
}

class _TextCarouselState extends State<TextCarousel> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.texts.length,
        itemBuilder: (context, index) {
          return buildTextItem(widget.texts[index]);
        },
      ),
    );
  }

  Widget buildTextItem(String text) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        text,
        softWrap: true,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
