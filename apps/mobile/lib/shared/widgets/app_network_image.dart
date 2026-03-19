import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Shared network image widget with caching, placeholder, and error handling.
///
/// Wraps [CachedNetworkImage] with consistent styling across the app.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderIcon = Icons.image_outlined,
    this.errorIcon = Icons.broken_image_outlined,
    this.iconSize = 36,
    this.iconColor,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData placeholderIcon;
  final IconData errorIcon;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: iconColor ?? Colors.grey,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: Icon(
          errorIcon,
          size: iconSize,
          color: iconColor ?? Colors.grey,
        ),
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }
}
