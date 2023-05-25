import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/question/question.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/views/texts.dart';

class SimpleTextView extends StatelessWidget {
  final List<SimpleText> simpleTexts;
  final TextAlign textAlign;
  final TextTypes textType;

  const SimpleTextView(
    this.simpleTexts, {
    Key? key,
    this.textAlign = TextAlign.start,
    this.textType = TextTypes.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: Dimens.paddingLarge),
      itemCount: simpleTexts.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              translate(simpleTexts[index].text),
              align: textAlign,
              type: textType,
            ),
            if (simpleTexts[index].bulletPoints != null || simpleTexts[index].bulletPoints!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.paddingLarge),
                child: BulletPoints(
                  simpleTexts[index].bulletPoints!,
                  textType: textType,
                  textAlign: textAlign,
                ),
              )
          ],
        );
      },
    );
  }
}

class BulletPoints extends StatelessWidget {
  final List<BulletPoint> bulletPoints;
  final TextAlign textAlign;
  final TextTypes textType;

  const BulletPoints(
    this.bulletPoints, {
    Key? key,
    this.textAlign = TextAlign.start,
    this.textType = TextTypes.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
      itemCount: bulletPoints.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              translate(bulletPoints[index].text),
              align: textAlign,
              type: textType,
            ),
            if (bulletPoints[index].children != null || bulletPoints[index].children!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.paddingLarge),
                child: ChildBulletPoints(
                  bulletPoints[index].children!,
                  textType: textType,
                  textAlign: textAlign,
                ),
              )
          ],
        );
      },
    );
  }
}

class ChildBulletPoints extends StatelessWidget {
  final List<String> children;
  final TextAlign textAlign;
  final TextTypes textType;

  const ChildBulletPoints(
    this.children, {
    Key? key,
    this.textAlign = TextAlign.start,
    this.textType = TextTypes.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return AppText(
          translate(children[index]),
          align: textAlign,
          type: textType,
        );
      },
    );
  }
}
