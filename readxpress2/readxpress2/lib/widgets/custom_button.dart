import 'package:flutter/material.dart';
import 'package:readxpress2/themes/sizes.dart';
import 'package:readxpress2/themes/theme_config.dart';


class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool isDisabled = false,
    double? height,
    double? width,
    required String text,
  })  : 
        margin = margin,
        onPressed = onPressed,
        buttonStyle = buttonStyle,
        alignment = alignment,
        buttonTextStyle = buttonTextStyle,
        isDisabled = isDisabled,
        height = height,
        width = width,
        text = text,
        super(key: key);

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final Alignment? alignment;
  final TextStyle? buttonTextStyle;
  final bool isDisabled;
  final double? height;
  final double? width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: buildButtonWidget(),
          )
        : buildButtonWidget();
  }

  Widget buildButtonWidget() {
    return Container(
      height: height ?? 40.v,
      width: width ?? double.maxFinite,
      margin: margin,
      decoration: decoration,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: isDisabled ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftIcon ?? const SizedBox(),
            Text(
              text,
              style: buttonTextStyle ?? theme.textTheme.bodySmall,
            ),
            rightIcon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
