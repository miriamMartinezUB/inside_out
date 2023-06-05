import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/content/carrousel_content.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/carrousel_header_view.dart';
import 'package:inside_out/views/list_section_view.dart';
import 'package:inside_out/views/show_my_dialog.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CarrouselContentView extends StatefulWidget {
  final CarrouselContent content;

  const CarrouselContentView({Key? key, required this.content}) : super(key: key);

  @override
  State<CarrouselContentView> createState() => _CarrouselContentViewState();
}

class _CarrouselContentViewState extends State<CarrouselContentView> {
  late PaletteColors paletteColors;
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    paletteColors = Provider.of<ThemeService>(context).paletteColors;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: AppText(
                translate(widget.content.title),
                type: TextTypes.title,
              ),
            ),
            IconButton(
              onPressed: () {
                ShowMyDialog(
                  title: translate(widget.content.title),
                  text: translate(widget.content.description),
                ).show(context);
              },
              icon: Icon(
                Icons.info_outline_rounded,
                size: Dimens.iconBase,
                color: paletteColors.active,
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.paddingLarge),
        CarouselSlider(
          key: Key(const Uuid().v4()),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 1,
            initialPage: currentIndex,
            height: widget.content.height,
            scrollPhysics: const BouncingScrollPhysics(),
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              if (index >= 0 && index <= widget.content.items.length - 1) {
                setState(() {
                  currentIndex = index;
                });
              }
            },
          ),
          items: List.generate(
            widget.content.items.length,
            (index) {
              return Container(
                padding: const EdgeInsets.all(Dimens.paddingMedium),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.radiusMedium),
                  color: paletteColors.primary,
                ),
                child: Column(
                  children: [
                    CarrouselHeaderView(
                      title: widget.content.items[currentIndex].title,
                      colorTitle: widget.content.items[currentIndex].color,
                      imagePath: widget.content.items[currentIndex].imagePath,
                      sizeImage: Dimens.iconLarge,
                      isLeftIconDisabled: currentIndex == 0,
                      onPressLeftIcon: () {
                        setState(() {
                          currentIndex = currentIndex - 1;
                        });
                      },
                      isRightIconDisabled: currentIndex == widget.content.items.length - 1,
                      onPressRightIcon: () {
                        setState(() {
                          currentIndex = currentIndex + 1;
                        });
                      },
                      activeIconColor: paletteColors.icons,
                      isTitleDown: false,
                    ),
                    const SizedBox(height: Dimens.paddingMedium),
                    if (widget.content.items[currentIndex].sections != null)
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: widget.content.items[currentIndex].sections!.length,
                                  itemBuilder: (context, index) {
                                    final item = widget.content.items[currentIndex].sections![index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: widget.content.items[currentIndex].sections!.length - 1 == index
                                              ? 0
                                              : Dimens.paddingMedium),
                                      child: item.text == null
                                          ? ListSectionView(
                                              key: Key(const Uuid().v4()),
                                              title: item.title,
                                              items: item.bulletPoints!.map((e) => e.text).toList())
                                          : Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (item.title != null) ...[
                                                  AppText(
                                                    translate(item.title!),
                                                    type: TextTypes.smallBodyMedium,
                                                    color: paletteColors.textButton,
                                                  ),
                                                  const SizedBox(height: Dimens.paddingMedium),
                                                ],
                                                ListItemView(text: item.text!),
                                              ],
                                            ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
