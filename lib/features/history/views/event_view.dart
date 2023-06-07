import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/utils/date_format.dart';
import 'package:inside_out/views/list_section_view.dart';
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
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            translate('forgiveness_phrases'),
            color: paletteColors.textButton,
            type: TextTypes.smallBodyMedium,
          ),
          const SizedBox(height: Dimens.paddingMedium),
          ListItemView(text: (event as EventForgivenessDiet).forgivenessPhrases),
        ],
      );
    } else if (event is EventPrioritisingPrinciples) {
      child = Column(
        children: [
          ListSectionView(title: 'principles_list', items: (event as EventPrioritisingPrinciples).principles),
          ListSectionView(title: 'values_list', items: (event as EventPrioritisingPrinciples).values),
        ],
      );
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
        ListSectionView(title: 'day_emotions', items: widget.event.emotions),
        if (expanded) ...[
          const SizedBox(height: Dimens.paddingMedium),
          ListSectionView(title: 'body_sensations', items: widget.event.bodySensations),
          const SizedBox(height: Dimens.paddingMedium),
          ListSectionView(title: 'behaviours', items: widget.event.behaviours),
          const SizedBox(height: Dimens.paddingMedium),
          AppText(
            translate('reason'),
            color: paletteColors.textButton,
            type: TextTypes.smallBodyMedium,
          ),
          const SizedBox(height: Dimens.paddingMedium),
          ListItemView(text: widget.event.reason),
          if (widget.event.thingsToChange != null && widget.event.thingsToChange!.isNotEmpty) ...[
            const SizedBox(height: Dimens.paddingMedium),
            ListSectionView(title: 'things_to_improve', items: widget.event.thingsToChange!),
          ],
          if (widget.event.thingsToLearn != null && widget.event.thingsToLearn!.isNotEmpty) ...[
            const SizedBox(height: Dimens.paddingMedium),
            ListSectionView(title: 'things_to_learn', items: widget.event.thingsToLearn!),
          ],
          if (widget.event.thingsToKeep != null && widget.event.thingsToKeep!.isNotEmpty) ...[
            const SizedBox(height: Dimens.paddingMedium),
            ListSectionView(title: 'things_to_keep', items: widget.event.thingsToKeep!),
          ],
          if (widget.event.thingsToPrevent != null && widget.event.thingsToPrevent!.isNotEmpty) ...[
            const SizedBox(height: Dimens.paddingMedium),
            ListSectionView(title: 'things_to_prevent', items: widget.event.thingsToPrevent!),
          ],
        ],
        Center(
          child: IconButton(
            padding: EdgeInsets.zero,
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
