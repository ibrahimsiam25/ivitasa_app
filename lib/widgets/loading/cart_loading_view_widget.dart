import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/colors_resources.dart';
import '../../core/constants/sizes_resources.dart';

class CartLoadingViewWidget extends StatelessWidget {
  const CartLoadingViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: ColorsResources.baseLoadingColor,
        highlightColor: ColorsResources.highlightLoadingColor,
        child: ListView.builder(
          // padding: EdgeInsets.symmetric(horizontal: SizesResources.s3),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: SizesResources.s2,
                  ),
                  width: MediaQuery.sizeOf(context).width - SizesResources.s4,
                  height: MediaQuery.sizeOf(context).width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
