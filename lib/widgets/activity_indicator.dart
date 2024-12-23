import 'dart:io';
import 'dart:ui';

import 'package:agichat/resources/_r.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(color: R.color.black.withOpacity(0.1)),
          child: Center(child: _getActivityIndicator()),
        ),
      ],
    );
  }

  Widget _getActivityIndicator() {
    if (Platform.isAndroid) {
      return const AndroidIndicator();
    } else {
      return const IOSIndicator();
    }
  }
}

class AndroidIndicator extends StatelessWidget {
  final Color? color;
  final double strokeWidth;

  const AndroidIndicator({Key? key, this.color, this.strokeWidth = 4.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color ?? R.color.white.withOpacity(0.7)),
      strokeWidth: strokeWidth,
    );
  }
}

class IOSIndicator extends StatelessWidget {
  final Color? color;
  const IOSIndicator({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(color: color);
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: R.color.grayLight.withOpacity(0.3),
      highlightColor: R.color.grayLight.withOpacity(0.05),
      enabled: true,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: R.color.black,
      ),
    );
  }
}
