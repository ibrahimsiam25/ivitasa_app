import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/colors_resources.dart';
import '../../core/constants/sizes_resources.dart';

class HomeLoadingViewWidget extends StatelessWidget {
  const HomeLoadingViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Shimmer.fromColors(
          baseColor: ColorsResources.baseLoadingColor,
          highlightColor: ColorsResources.highlightLoadingColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizesResources.s3),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: SizesResources.s4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  height: 140,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
