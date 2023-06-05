import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final String nameWithExtension;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final bool canZoom;

  const ImageView(
    this.nameWithExtension, {
    Key? key,
    this.height,
    this.width,
    this.boxFit,
    this.canZoom = false,
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
    if (canZoom) {
      PhotoView(imageProvider: AssetImage('assets/images/$nameWithExtension'));
    }
    return Image.asset(
      'assets/images/$nameWithExtension',
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}
