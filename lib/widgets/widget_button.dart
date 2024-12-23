import 'package:agichat/resources/_r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets_text.dart';

class ButtonBasic extends StatelessWidget {
  final TextBasic? textBasic;
  final Color? bgColor;
  final Color? disabledColor;
  final double radius;
  final double? elevation;
  final BorderSide borderSide;
  final VoidCallback? onPressed;
  final String? text;
  final Color? textColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Widget? child;
  final EdgeInsets? padding;
  final TextAlign? textAlign;

  const ButtonBasic({
    Key? key,
    this.textBasic,
    this.bgColor,
    this.disabledColor,
    this.radius = 14.0,
    this.elevation = 0.0,
    this.borderSide = BorderSide.none,
    this.onPressed,
    this.text,
    this.textColor,
    this.fontFamily,
    this.fontWeight,
    this.fontSize,
    this.child,
    this.padding,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: elevation,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: borderSide,
      ),
      color: bgColor ?? R.color.primary,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      disabledColor: disabledColor,
      onPressed: onPressed,
      child: textBasic ??
          child ??
          TextBasic(
            text: text ?? '',
            color: textColor ?? R.color.white,
            fontFamily: fontFamily ?? R.fonts.displayBold,
            fontSize: fontSize ?? 14.0,
            fontWeight: fontWeight,
            textAlign: textAlign,
          ),
    );
  }
}

class AppbarBackButton extends StatelessWidget {
  final Color? bgColor;
  final Color? iconColor;
  final double radius;
  final Function() onPressed;

  const AppbarBackButton({Key? key, this.bgColor, this.iconColor, this.radius = 8.0, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: IconButton(
          iconSize: 16.0,
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.arrow_back,
            color: iconColor ?? R.color.primary,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final Color? bgColor;
  final Color? iconColor;
  final String? iconPath;
  final String? iconSvgPath;
  final double? size;
  final double? iconSize;
  final Widget? icon;
  final Function onPressed;

  const AppBarButton({
    Key? key,
    this.bgColor,
    this.iconColor,
    this.iconPath,
    this.iconSvgPath,
    this.size = 40.0,
    this.iconSize = 24.0,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: bgColor ?? R.color.white,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => onPressed(),
          icon: icon != null
              ? icon!
              : iconPath == null
                  ? iconSvgPath == null
                      ? Container()
                      : SvgPicture.asset(
                          iconSvgPath!,
                          colorFilter: iconColor == null ? null : ColorFilter.mode(iconColor!, BlendMode.srcIn),
                          width: iconSize,
                          height: iconSize,
                        )
                  : Image.asset(
                      iconPath!,
                      color: iconColor,
                      width: iconSize,
                      height: iconSize,
                    ),
        ),
      ),
    );
  }
}

class ActionButtonBasic extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function() onTap;
  final Color? textColor;

  const ActionButtonBasic({Key? key, required this.iconPath, required this.title, required this.onTap, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide(width: 1.0, color: R.color.grayLight)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 12.0),
            TextBasic(
              text: title,
              color: textColor ?? R.color.grayLight,
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              fontFamily: R.fonts.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonBasic<T> extends StatelessWidget {
  final T item;
  final String itemTitle;
  final bool isSelected;
  final bool isActiveBorder;
  final Function(T) onSelected;
  const DropdownButtonBasic(
      {super.key, required this.item, required this.itemTitle, required this.isSelected, required this.isActiveBorder, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        decoration: BoxDecoration(
          border: isActiveBorder ? Border(bottom: BorderSide(width: 1.0, color: R.color.grayLight)) : null,
          color: R.color.white,
        ),
        child: Row(
          children: [
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1.0, color: isSelected ? R.color.primarySwatch : R.color.black.withOpacity(0.3)),
              ),
              child: Center(
                child: Container(
                  height: 8.0,
                  width: 8.0,
                  decoration: BoxDecoration(
                    color: isSelected ? R.color.primarySwatch : R.color.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: TextBasic(
                text: itemTitle.replaceAll('&amp;', '&'),
                color: isSelected ? R.color.primarySwatch : R.color.black,
                fontFamily: R.fonts.displayMedium,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonPremium extends StatelessWidget {
  const ButtonPremium({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: R.color.gold,
      ),
      child: TextBasic(text: R.string.premium, color: R.color.brown, fontFamily: R.fonts.displayBold, fontSize: 10.0),
    );
  }
}

class WidgetUtilsButton extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  final Function() onPressed;

  const WidgetUtilsButton({
    super.key,
    required this.color,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBasic(text: title, color: R.color.secondary, fontFamily: R.fonts.displayBold, fontSize: 14.0),
                const SizedBox(height: 10.0),
                TextBasic(text: description, color: R.color.secondary, fontSize: 12.0, maxLines: 1),
              ],
            ),
          ),
          Icon(Icons.arrow_forward, color: R.color.secondary),
        ],
      ),
    );
  }
}

class ButtonWithIconData extends StatelessWidget {
  final Color? bgColor;
  final double radius;
  final double? elevation;
  final BorderSide borderSide;
  final VoidCallback? onPressed;
  final String? text;
  final Color? textColor;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Widget? child;
  final EdgeInsets? padding;
  final IconData? icon;
  final Color? iconColor;

  const ButtonWithIconData(
      {super.key,
      this.bgColor,
      required this.radius,
      this.elevation,
      required this.borderSide,
      this.onPressed,
      this.text,
      this.textColor,
      this.fontFamily,
      this.fontWeight,
      this.fontSize,
      this.child,
      this.padding,
      this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: bgColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBasic(
            textAlign: TextAlign.center,
            text: text!,
            color: textColor,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          const SizedBox(width: 20,),
          GestureDetector(
            onTap: () => onPressed,
            child: Icon(icon,color: iconColor,size: 20),
          )
        ],
      ),
    );
  }
}
