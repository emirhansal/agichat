import 'package:agichat/resources/_r.dart';
import 'package:flutter/material.dart';

class TextBasic extends StatelessWidget {
  final String text;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final double? lineHeight;
  final bool? underline;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? letterSpacing;

  const TextBasic({
    Key? key,
    required this.text,
    this.color,
    this.fontFamily,
    this.fontSize,
    this.lineHeight,
    this.underline = false,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.letterSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines ?? 999,
      textScaler: TextScaler.linear(1.0),
      style: TextStyle(
        letterSpacing: letterSpacing ?? 0.0,
        color: color ?? R.color.black,
        fontFamily: fontFamily ?? R.fonts.displayRegular,
        fontSize: fontSize ?? 14.0,
        decoration: underline! ? TextDecoration.underline : null,
        fontWeight: fontWeight ?? FontWeight.normal,
        height: lineHeight ?? 1.2,
      ),
    );
  }
}

TextSpan textSpanBasic({
  String? text,
  Color? color,
  String? fontFamily,
  FontWeight? fontWeight,
  double? fontSize,
  bool? underline = false,
}) {
  return TextSpan(
    text: text,
    style: TextStyle(
      color: color,
      fontFamily: fontFamily ?? R.fonts.displayRegular,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: underline! ? TextDecoration.underline : null,
    ),
  );
}

class RichTextBasic extends StatelessWidget {
  final List<TextSpan>? texts;
  final TextAlign? textAlign;

  const RichTextBasic({Key? key, this.texts, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(
        children: texts,
      ),
    );
  }
}

class TextNavigationTitle extends StatelessWidget {
  final String title;

  const TextNavigationTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextBasic(
      text: title,
      textAlign: TextAlign.center,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    );
  }
}

class WidgetInfoCardText extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  const WidgetInfoCardText({super.key, required this.title, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: R.color.grayBg,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextBasic(text: title, color: R.color.secondary, fontSize: 10.0, fontFamily: R.fonts.displayMedium),
          const SizedBox(height: 5.0),
          TextBasic(text: value, color: valueColor ?? R.color.secondary, fontSize: 12.0, fontFamily: R.fonts.displayBold, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
