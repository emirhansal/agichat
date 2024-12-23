import 'package:agichat/resources/_r.dart';
import 'package:agichat/service/service_api.dart';
import 'package:agichat/widgets/activity_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NetworkImageWithPlaceholder extends StatelessWidget {
  final String? imageUrl;
  final String? svgPath;
  final String? placeholderPath;
  final double width;
  final double height;
  final bool? isColorFilterActive;
  final bool isCircle;
  final BoxFit? boxFit;
  final BoxBorder? border;
  final double? radius;

  const NetworkImageWithPlaceholder({
    Key? key,
    this.imageUrl,
    this.svgPath,
    this.placeholderPath,
    required this.height,
    required this.width,
    this.isColorFilterActive = false,
    this.isCircle = false,
    this.border,
    this.boxFit,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: !isCircle && radius != null ? BorderRadius.circular(radius! + 4.0) : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ??
            (isCircle
                ? width > height
                    ? width
                    : height
                : 0.0)),
        child: imageUrl == null
            ? svgPath != null
                ? SvgPicture.asset(svgPath!, height: height, width: width)
                : _getPlaceHolder()
            : (imageUrl?.contains('.svg') ?? false)
                ? SvgPicture.network(
                    imageUrl!,
                    fit: boxFit ?? BoxFit.cover,
                    height: height,
                    width: width,
                    headers: Provider.of<ServiceApi>(context, listen: false).getHeaderData,
                  )
                : CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: boxFit ?? BoxFit.cover,
                    height: height,
                    width: width,
                    httpHeaders: Provider.of<ServiceApi>(context, listen: false).getHeaderData,
                    placeholder: (ctx, str) => _getLoading(),
                    errorWidget: (context, url, error) => _getPlaceHolder(),
                    imageBuilder: !(isColorFilterActive ?? false)
                        ? null
                        : (context, imageProvider) => Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      R.color.black.withOpacity(0.8),
                                      R.color.transparent,
                                      R.color.black.withOpacity(0.8),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.0, 0.5, 1],
                                  ),
                                ),
                              ),
                            ),
                  ),
      ),
    );
  }

  Widget _getLoading() {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: IOSIndicator(
          color: R.color.black,
        ),
      ),
    );
  }

  Widget _getPlaceHolder() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: R.color.grayBg,
      ),
      child: Center(child: Icon(Icons.photo, color: R.color.gray)),
    );
  }
}
