import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/question/carrousel_question.dart';
import 'package:inside_out/features/common/form/views/checkbox_question_view.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class CarrouselQuestionView extends StatefulWidget {
  final List<CarrouselQuestionItem> items;
  final Function(String newValue) onChange;

  const CarrouselQuestionView({
    Key? key,
    required this.items,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CarrouselQuestionView> createState() => _CarrouselQuestionViewState();
}

class _CarrouselQuestionViewState extends State<CarrouselQuestionView> {
  late PaletteColors paletteColors;
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    paletteColors = Provider.of<ThemeService>(context).paletteColors;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1,
        aspectRatio: 0.57,
        scrollPhysics: const BouncingScrollPhysics(),
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          if (index >= 0 && index <= widget.items.length - 1) {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
      items: List.generate(
        widget.items.length,
        (index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: Dimens.iconMedium,
                      color: currentIndex == 0 ? paletteColors.inactive : paletteColors.primary,
                    ),
                    onPressed: currentIndex == 0
                        ? null
                        : () {
                            setState(() {
                              currentIndex = currentIndex - 1;
                            });
                          },
                  ),
                  ImageView(
                    widget.items[currentIndex].imagePath,
                    height: Dimens.iconXXLarge,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: Dimens.iconMedium,
                      color: currentIndex == widget.items.length - 1 ? paletteColors.inactive : paletteColors.primary,
                    ),
                    onPressed: currentIndex == widget.items.length - 1
                        ? null
                        : () {
                            setState(() {
                              currentIndex = currentIndex + 1;
                            });
                          },
                  ),
                ],
              ),
              AppText(
                translate(widget.items[currentIndex].title),
                align: TextAlign.center,
                color: widget.items[currentIndex].color,
              ),
              const SizedBox(height: Dimens.paddingLarge),
              CheckBoxQuestionView(
                values: widget.items[currentIndex].values,
                valuesSelected: widget.items[currentIndex].selectedValues ?? [],
                onChange: widget.onChange,
              ),
            ],
          );
        },
      ),
    );
  }
}
