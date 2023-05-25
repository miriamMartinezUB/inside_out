import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/utils/dateFormat.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

final BorderRadius _borderRadius = BorderRadius.circular(Dimens.radiusMedium);

class CardEventView extends StatelessWidget {
  final Event event;
  const CardEventView({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    late Widget child;
    if (event is EventThoughtDiary) {
      child = _EventThoughtDiaryView(event: event as EventThoughtDiary);
    } else if (event is EventForgivenessDiet) {
      child = EventSection(
        title: 'forgiveness_phrases',
        items: (event as EventForgivenessDiet).forgivenessPhrases,
        axis: Axis.vertical,
      );
    } else if (event is EventPrioritisingPrinciples) {
      child = EventSection(title: 'principles_list', items: (event as EventPrioritisingPrinciples).principlesAndValues);
    } else {
      throw FlutterError('Event of type ${event.runtimeType} is not implemented');
    }
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.paddingLarge),
      child: Container(
        decoration: BoxDecoration(
          color: paletteColors.primary,
          borderRadius: _borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppText(
                      translate(event.title),
                      color: paletteColors.textButton,
                      type: TextTypes.bodyBold,
                    ),
                  ),
                  AppText(
                    event.dateTime.getHHmm(),
                    color: paletteColors.textButton,
                    type: TextTypes.smallBody,
                  ),
                ],
              ),
              const SizedBox(height: Dimens.paddingLarge),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _EventThoughtDiaryView extends StatefulWidget {
  final EventThoughtDiary event;

  const _EventThoughtDiaryView({Key? key, required this.event}) : super(key: key);

  @override
  State<_EventThoughtDiaryView> createState() => _EventThoughtDiaryViewState();
}

class _EventThoughtDiaryViewState extends State<_EventThoughtDiaryView> {
  late PaletteColors paletteColors;
  bool expanded = false;

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
        EventSection(title: 'day_emotions', items: widget.event.emotions),
        if (expanded) ...[
          const SizedBox(height: Dimens.paddingMedium),
          EventSection(title: 'body_sensations', items: widget.event.bodySensations),
          const SizedBox(height: Dimens.paddingMedium),
          EventSection(title: 'behaviours', items: widget.event.behaviours),
          const SizedBox(height: Dimens.paddingMedium),
          AppText(
            translate('reason'),
            color: paletteColors.textButton,
            type: TextTypes.smallBodyMedium,
          ),
          const SizedBox(height: Dimens.paddingMedium),
          ListItem(text: widget.event.reason),
          if (widget.event.thingsToImprove != null) ...[
            const SizedBox(height: Dimens.paddingMedium),
            EventSection(title: 'things_to_improve', items: widget.event.thingsToImprove!),
          ]
        ],
        Center(
          child: IconButton(
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
            icon: Icon(
              expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              size: Dimens.iconLarge,
              color: paletteColors.icons,
            ),
          ),
        ),
      ],
    );
  }
}

class EventSection extends StatelessWidget {
  final String title;
  final List items;
  final Axis axis;

  const EventSection({
    Key? key,
    required this.title,
    required this.items,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          translate(title),
          color: paletteColors.textButton,
          type: TextTypes.smallBodyMedium,
        ),
        const SizedBox(height: Dimens.paddingMedium),
        SizedBox(
          height: axis == Axis.horizontal ? 42 : null,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: axis,
            primary: false,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: axis == Axis.horizontal
                      ? 0
                      : index == items.length - 1
                          ? 0
                          : Dimens.paddingMedium,
                  right: axis == Axis.vertical
                      ? 0
                      : index == items.length - 1
                          ? 0
                          : Dimens.paddingMedium,
                ),
                child: ListItem(text: items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;
  final bool shouldTranslate;

  const ListItem({
    super.key,
    required this.text,
    this.shouldTranslate = true,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.paddingMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radiusXLarge),
        color: paletteColors.card,
      ),
      child: Container(
        margin: const EdgeInsets.all(Dimens.paddingSmall),
        child: AppText(
          shouldTranslate ? translate(text) : text,
          color: themeService.themePreference == ThemePreference.light ? paletteColors.active : paletteColors.text,
          type: TextTypes.tinyBody,
        ),
      ),
    );
  }
}
