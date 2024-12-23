import 'package:agichat/base/base_view.dart';
import 'package:agichat/resources/_r.dart';
import 'package:flutter/material.dart';

class BottomSheetBase extends StatelessWidget with BaseView {
  final Widget child;
  const BottomSheetBase({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomBarHeight = systemPadding(context).bottom + viewInsets(context).bottom;
    return GestureDetector(
      onTap: () => keyboardVisibility(context) ? router(context).hideKeyboard(context) : router(context).onBackPressed(),
      child: Container(
        width: double.infinity,
        color: R.color.transparent,
        padding: EdgeInsets.only(top: 10.0, right: isTablet ? size.width * 0.25 : 0.0, left: isTablet ? size.width * 0.25 : 0.0),
        child: Stack(
          children: [
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.only(bottom: bottomBarHeight, top: 16.0),
              constraints: BoxConstraints(
                maxHeight: size.height * 0.9,
                minHeight: size.height * 0.2,
              ),
              decoration: BoxDecoration(
                color: R.color.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: GestureDetector(
                onTap: () => router(context).hideKeyboard(context),
                child: child,
              ),
            ),
            Container(
              height: 10.0,
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: R.color.grayLight,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
