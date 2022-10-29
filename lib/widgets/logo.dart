import 'package:flutter/material.dart';
import 'package:portfolio/utils/image_asset_constants.dart';
import 'package:portfolio/utils/breakpoints.dart';

class Logo extends StatelessWidget {
  final double width;
  final ScrollController scrollController;
  const Logo({required this.width, required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "<>u#-dev</>",
      style: TextStyle(color: Colors.white, fontSize: 30),
    );
    // return Image.asset(ImageAssetConstants.logo,
    //     width: width >= Breakpoints.xlg ? width * 0.14 : Breakpoints.xlg * 0.14,
    //     height:
    //         width >= Breakpoints.xlg ? 0.04 * width : 0.04 * Breakpoints.xlg);
  }
}
