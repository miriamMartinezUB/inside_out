import 'package:flutter/material.dart';

class PaletteColors {
  Color primary = const Color(0xffEEC083);
  Color secondary = const Color(0xfffdedcb);
  Color active = const Color(0xffD19136);
  Color inactive = const Color(0xffD9D9D9);
  Color textError = Colors.red.shade400;
  late Color shadow;
  late Color textButton;
  late Color icons;
  late Color textAppBar;
  late Color background;
  late Color text;
  late Color textSubtitle;
  late Color card;
}

class PaletteColorsLight extends PaletteColors {
  PaletteColorsLight() {
    textButton = const Color(0xffffffff);
    icons = const Color(0xffffffff);
    textAppBar = const Color(0xffffffff);
    background = const Color(0xfffbf7ee);
    text = const Color(0xff242e37);
    textSubtitle = const Color(0xff3f484f);
    card = const Color(0xffffffff);
    shadow = Colors.grey.shade300;
  }
}

class PaletteColorsDark extends PaletteColors {
  PaletteColorsDark() {
    textButton = const Color(0xff242e37);
    icons = const Color(0xff242e37);
    textAppBar = const Color(0xff242e37);
    background = const Color(0xff242e37);
    text = const Color(0xfff3edf5);
    textSubtitle = const Color.fromRGBO(243, 237, 245, .6);
    card = const Color(0xff3f484f);
    shadow = const Color(0xff3f484f).withOpacity(0.4);
  }
}

class PaletteMaterialColors {
  static const MaterialColor primary = MaterialColor(0xffEEC083, {
    50: Color.fromRGBO(238, 192, 131, .1),
    100: Color.fromRGBO(238, 192, 131, .2),
    200: Color.fromRGBO(238, 192, 131, .3),
    300: Color.fromRGBO(238, 192, 131, .4),
    400: Color.fromRGBO(238, 192, 131, .5),
    500: Color.fromRGBO(238, 192, 131, .6),
    600: Color.fromRGBO(238, 192, 131, .7),
    700: Color.fromRGBO(238, 192, 131, .8),
  });
}
