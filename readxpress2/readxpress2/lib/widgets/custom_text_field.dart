import 'package:flutter/material.dart';
import 'package:readxpress2/themes/sizes.dart';
import 'package:readxpress2/themes/text_styles.dart';
import 'package:readxpress2/themes/theme_config.dart';

class CustomFloatingTextField extends StatefulWidget {
  CustomFloatingTextField({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.isPasswordField = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
  }) : super(
          key: key,
        );

  final Alignment? alignment;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool isPasswordField;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;

  @override
  _CustomFloatingTextFieldState createState() => _CustomFloatingTextFieldState();
}

class _CustomFloatingTextFieldState extends State<CustomFloatingTextField> {
  bool _passVisibility = true;

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: floatingTextFieldWidget,
          )
        : floatingTextFieldWidget;
  }

  Widget get floatingTextFieldWidget => SizedBox(
        width: widget.width ?? double.maxFinite,
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode ?? FocusNode(),
          autofocus: widget.autofocus!,
          style: widget.textStyle ?? TextStyle(),
          obscureText: widget.isPasswordField ? _passVisibility : false,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines ?? 1,
          decoration: decoration,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: widget.hintText ?? "",
        hintStyle: widget.hintStyle ?? TextStyle(),
        labelText: widget.labelText ?? "",
        labelStyle: widget.labelStyle,
        prefixIcon: widget.prefix,
        prefixIconConstraints: widget.prefixConstraints,
        suffixIcon: widget.isPasswordField ? passwordSuffixIcon : widget.suffix,
        suffixIconConstraints: widget.suffixConstraints,
        isDense: true,
        contentPadding:
            widget.contentPadding ?? EdgeInsets.fromLTRB(14, 16, 14, 14),
        fillColor: widget.fillColor,
        filled: widget.filled,
        border: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: appTheme.blue300, // Change this color as needed
                width: 1,
              ),
            ),
        enabledBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: appTheme.blue300,
                width: 1,
              ),
            ),
        focusedBorder: widget.borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: appTheme.blue300,
                width: 1,
              ),
            ),
      );

  Widget get passwordSuffixIcon => IconButton(
        icon: _passVisibility
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility),
        onPressed: () {
          setState(() {
            _passVisibility = !_passVisibility;
          });
        },
      );
}


