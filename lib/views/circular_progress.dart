import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:provider/provider.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.black12,
        valueColor: AlwaysStoppedAnimation<Color>(
          Provider.of<ThemeService>(context).paletteColors.primary,
        ),
      ),
    );
  }
}
