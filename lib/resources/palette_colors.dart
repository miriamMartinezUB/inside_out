import 'package:flutter/material.dart';

class PaletteColors {
  Color primary = const Color(0xff28d0b5);
  Color secondary = const Color(0xff9df0e5);
  Color active = const Color(0xfff3b4fa);
}

class PaletteColorsLight extends PaletteColors {
  Color background = const Color(0xfff3edf5);
  Color text = const Color(0xff313047);
}

class PaletteColorsDark extends PaletteColors {
  Color background = const Color(0xff313047);
  Color text = const Color(0xfff3edf5);
}

class PaletteMaterialColors {
  static const MaterialColor primary = MaterialColor(0xff28d0b5, {
    50: Color.fromRGBO(40, 208, 181, .1),
    100: Color.fromRGBO(40, 208, 181, .2),
    200: Color.fromRGBO(40, 208, 181, .3),
    300: Color.fromRGBO(40, 208, 181, .4),
    400: Color.fromRGBO(40, 208, 181, .5),
    500: Color.fromRGBO(40, 208, 181, .6),
    600: Color.fromRGBO(40, 208, 181, .7),
    700: Color.fromRGBO(40, 208, 181, .8),
  });
}
