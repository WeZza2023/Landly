import 'package:flutter/material.dart';
import 'package:landly/components/custom_texts.dart';
import 'package:landly/extentions/padding.dart';
import '../utils/app_sizes.dart';
import '../utils/colors.dart';

/// default form field

class DefaultFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final bool isPassword;
  final bool readOnly;
  final String? Function(String?)? validate;
  final String label;
  final IconData? prefix;
  final IconData? suffix;
  final Function()? onTap;
  final Function()? onSuffixPressed;
  final bool isClickable;

  const DefaultFormField({
    Key? key,
    required this.controller,
    required this.type,
    this.onSubmit,
    this.onChange,
    this.isPassword = false,
    this.readOnly = false,
    required this.validate,
    required this.label,
    this.prefix,
    this.suffix,
    this.onTap,
    this.onSuffixPressed,
    this.isClickable = true,
  }) : super(key: key);

  @override
  _DefaultFormFieldState createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  late TextDirection _textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: widget.type,
      obscureText: widget.isPassword,
      onFieldSubmitted: widget.onSubmit,
      onChanged: (value) {
        setState(() {
          _textDirection = _getTextDirection(value);
        });
      },
      onTap: widget.onTap,
      enabled: widget.isClickable,
      validator: widget.validate,
      textDirection: _textDirection,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AppSizes.getBaseScale(context) * 15,
            horizontal: AppSizes.getBaseScale(context) * 10),
        fillColor: kSubBackgroundColor,
        filled: true,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: kMainTextColor.withOpacity(0.5),
          fontSize: FontSizes.adjustFontSize(FontSizes.scale * 14),
        ),
        prefixIcon: widget.prefix != null
            ? Icon(
                widget.prefix,
                size: 24,
                color: kMainTextColor.withOpacity(0.5),
              )
            : null,
        suffixIcon: widget.suffix != null
            ? IconButton(
                onPressed: widget.onSuffixPressed,
                icon: Icon(
                  widget.suffix,
                  size: 20,
                  color: kMainTextColor.withOpacity(0.5),
                )).p4
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          borderSide: BorderSide(
            width: 1,
            color: kMainBtnColor.withOpacity(0.2),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          borderSide: const BorderSide(
            width: 1,
            color: kMainBtnColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          borderSide: const BorderSide(
            width: 1.5,
            color: kMainBtnColor,
          ),
        ),
      ),
    );
  }

  TextDirection _getTextDirection(String text) {
    bool hasArabicCharacters = RegExp(
            r'[\u0600-\u06FF\u0750-\u077F\u0590-\u05FF\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]')
        .hasMatch(text);
    return hasArabicCharacters ? TextDirection.rtl : TextDirection.ltr;
  }
}

/// main drop down form field

class MainDropDownFormField extends StatelessWidget {
  const MainDropDownFormField(
      {Key? key,
      required this.Controller,
      required this.labelText,
      this.items,
      this.icon,
      this.onChanged,
      this.validation,
      this.onTap})
      : super(key: key);

  final TextEditingController Controller;
  final String labelText;
  final List<DropdownMenuItem<String>>? items;
  final String? Function(String?)? validation;
  final Widget? icon;
  final Function()? onTap;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: TextStyle(
        color: kMainTextColor.withOpacity(0.5),
        fontSize: FontSizes.adjustFontSize(FontSizes.scale * 14),
      ),
      borderRadius: BorderRadius.circular(30),
      validator: validation,
      icon: icon,
      dropdownColor: kSubBackgroundColor,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(
            vertical: AppSizes.getBaseScale(context) * 15,
            horizontal: AppSizes.getBaseScale(context) * 10),
        enabled: true,
        floatingLabelStyle: const TextStyle(color: kMainTextColor),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(
          color: kMainTextColor.withOpacity(0.5),
          fontSize: FontSizes.adjustFontSize(FontSizes.scale * 14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          borderSide: BorderSide(
            width: 1,
            color: kMainBtnColor.withOpacity(0.2),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          borderSide: const BorderSide(
            width: 1,
            color: kMainBtnColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          borderSide: const BorderSide(
            width: 1.5,
            color: kMainBtnColor,
          ),
        ),
        fillColor: kSubBackgroundColor,
        filled: true,
      ),
      isExpanded: true,
      items: items,
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
