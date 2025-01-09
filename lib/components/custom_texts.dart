import 'package:flutter/material.dart';

import '../utils/app_sizes.dart';
import '../utils/colors.dart';

class FontSizes {
  static double scale = 1;

  static void init(BuildContext context) {
    scale = AppSizes.getScreenWidth(context) / 400;
  }

  static double adjustFontSize(double fontSize) {
    const double minSize = 14;
    const double maxSize = 28;

    if (fontSize < minSize) {
      return minSize;
    } else if (fontSize > maxSize) {
      return maxSize;
    } else {
      return fontSize;
    }
  }

  static double get h1 => adjustFontSize(28 * scale);

  static double get h2 => adjustFontSize(24 * scale);

  static double get h3 => adjustFontSize(20 * scale);

  static double get h4 => adjustFontSize(18 * scale);

  static double get h5 => adjustFontSize(16 * scale);

  static double get h6 => adjustFontSize(14 * scale);
}

class TextWeight {
  static FontWeight get regular => FontWeight.w300;

  static FontWeight get medium => FontWeight.w500;

  static FontWeight get semiBold => FontWeight.w700;

  static FontWeight get bold => FontWeight.w900;
}

class BodyExtraLargeText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isUnderlined;
  final FontWeight? weight;
  final Color? color;
  final TextOverflow? textOverflow;

  const BodyExtraLargeText(this.text,
      {super.key,
      this.textAlign,
      this.maxLines,
      this.weight,
      this.color,
      this.isUnderlined = false,
      this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        overflow: textOverflow ?? TextOverflow.ellipsis,
        maxLines: maxLines ?? 1,
        style: TextStyle(
            decoration: isUnderlined ? TextDecoration.underline : null,
            decorationColor: color,
            fontSize: FontSizes.h1,
            color: color ?? kMainTextColor,
            fontWeight: weight ?? TextWeight.semiBold));
  }
}

class BodyLargeText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? weight;
  final Color? color;
  final bool isUnderlined;

  const BodyLargeText(this.text,
      {super.key,
      this.textAlign,
      this.maxLines,
      this.weight,
      this.color,
      this.isUnderlined = false});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.left,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 1,
        style: TextStyle(
            decoration: isUnderlined ? TextDecoration.underline : null,
            decorationColor: color,
            fontSize: FontSizes.h2,
            color: color ?? kMainTextColor,
            fontWeight: weight ?? TextWeight.medium,
            overflow: TextOverflow.ellipsis));
  }
}

class BodyMediumText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isUnderlined;
  final FontWeight? weight;
  final Color? color;

  const BodyMediumText(this.text,
      {super.key,
      this.textAlign,
      this.maxLines,
      this.weight,
      this.color,
      this.isUnderlined = false});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.center,
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decoration: isUnderlined ? TextDecoration.underline : null,
            decorationColor: color,
            fontSize: FontSizes.h3,
            overflow: TextOverflow.ellipsis,
            color: color ?? kMainTextColor,
            fontWeight: weight ?? TextWeight.medium));
  }
}

class BodySmallText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isUnderlined;

  final FontWeight? weight;
  final Color? color;

  const BodySmallText(this.text,
      {super.key,
      this.isUnderlined = false,
      this.textAlign,
      this.maxLines,
      this.weight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 1,
        style: TextStyle(
            decoration: isUnderlined ? TextDecoration.underline : null,
            decorationColor: color,
            fontSize: FontSizes.h4,
            color: color ?? kMainTextColor,
            fontWeight: weight ?? TextWeight.medium));
  }
}

class BodyExtraSmallText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isUnderlined;

  final FontWeight? weight;
  final Color? color;

  const BodyExtraSmallText(this.text,
      {super.key,
      this.isUnderlined = false,
      this.textAlign,
      this.maxLines,
      this.weight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 1,
        style: TextStyle(
            decoration: isUnderlined ? TextDecoration.underline : null,
            decorationColor: kMainTextColor,
            fontSize: FontSizes.h5,
            color: color ?? kMainTextColor,
            fontWeight: weight ?? TextWeight.medium));
  }
}

class BodyTinyText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isUnderlined;

  final FontWeight? weight;
  final Color? color;

  const BodyTinyText(this.text,
      {super.key,
      this.isUnderlined = false,
      this.textAlign,
      this.maxLines,
      this.weight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 1,
        style: TextStyle(
            decoration: isUnderlined ? TextDecoration.underline : null,
            decorationColor: color,
            fontSize: FontSizes.h6,
            color: color ?? null,
            fontWeight: weight ?? TextWeight.bold));
  }
}
