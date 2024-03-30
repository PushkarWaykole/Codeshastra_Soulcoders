
import 'package:codeshastra/utils/constants/colors.dart';
import 'package:codeshastra/utils/constants/image_strings.dart';
import 'package:codeshastra/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = 0,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // padding: const EdgeInsets.all(TSizes.sm),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: THelperFunctions.isDarkMode(context)
              ? TColors.black
              : TColors.white,
          borderRadius: BorderRadius.circular(100)),
      child: Image(
        fit: fit,
        image: isNetworkImage
            ? NetworkImage(image)
            : const AssetImage(TImages.clothIcon) as ImageProvider,
        // color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.dark,
        color: overlayColor,
      ),
    );
  }
}
