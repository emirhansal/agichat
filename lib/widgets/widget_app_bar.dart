import 'package:agichat/resources/_r.dart';
import 'package:agichat/service/service_route.dart';
import 'package:agichat/widgets/widget_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets_text.dart';

class WidgetAppBarBasic extends StatelessWidget implements PreferredSize {
  final String? title;
  final Function()? onPressedLeading;
  final List<Widget>? actions;
  final bool centerTitle;
  final double elevation;
  const WidgetAppBarBasic({
    super.key,
    this.title,
    this.onPressedLeading,
    this.actions,
    this.centerTitle = true,
    this.elevation = .5,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: R.color.white,
      centerTitle: centerTitle,
      leading: AppbarBackButton(
        onPressed: () {
          if (onPressedLeading != null) {
            onPressedLeading!();
            return;
          }
          Provider.of<ServiceRoute>(context, listen: false).onBackPressed(true);
        },
      ),
      title: title == null ? null : TextBasic(text: title!, color: R.color.primary, fontFamily: R.fonts.displayBold, fontSize: 16.0),
      actions: actions,
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => AppBar().preferredSize;
}
