import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inside_out/domain/question/carrousel_question.dart';
import 'package:inside_out/features/common/form/views/checkbox_question_view.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/carrousel_header_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
      key: Key(const Uuid().v4()),
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1,
        aspectRatio: 0.57,
        scrollPhysics: const BouncingScrollPhysics(),
        initialPage: currentIndex,
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
              CarrouselHeaderView(
                title: widget.items[currentIndex].title,
                colorTitle: widget.items[currentIndex].color,
                imagePath: widget.items[currentIndex].imagePath,
                sizeImage: Dimens.iconXXLarge,
                isLeftIconDisabled: currentIndex == 0,
                onPressLeftIcon: () {
                  setState(() {
                    currentIndex = currentIndex - 1;
                  });
                },
                isRightIconDisabled: currentIndex == widget.items.length - 1,
                onPressRightIcon: () {
                  setState(() {
                    currentIndex = currentIndex + 1;
                  });
                },
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
