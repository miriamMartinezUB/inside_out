import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageView extends StatelessWidget {
  final String nameWithExtension;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const ImageView(
    this.nameWithExtension, {
    Key? key,
    this.height,
    this.width,
    this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (nameWithExtension.split('.').last == 'svg') {
      return SvgPicture.asset(
        'assets/images/$nameWithExtension',
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.contain,
      );
    }
    return Image.asset(
      'assets/images/$nameWithExtension',
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}
