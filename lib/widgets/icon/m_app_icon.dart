import 'package:flutter/material.dart';

class MAppIcon extends StatelessWidget {
  final String image;

  const MAppIcon({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    //getting screen size
    final size = MediaQuery.of(context).size;

    //calculating container width
    double imageSize;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      imageSize = size.width * 0.20;
    } else {
      imageSize = size.height * 0.20;
    }

    return Image.asset(
      image,
      height: imageSize,
    );
  }
}
