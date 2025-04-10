import 'package:flutter/material.dart';
import 'package:ivitasa_app/core/constants/colors_resources.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/sizes_resources.dart';

class DefaultLoadingViewWidget extends StatelessWidget {
  const DefaultLoadingViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: ColorsResources.baseLoadingColor,
        highlightColor: ColorsResources.highlightLoadingColor,
        child: GridView.builder(
          padding: EdgeInsets.all(SizesResources.s3),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          },
        ),
      ),
    );
  }
}
