import 'package:flutter/material.dart';
import 'package:imagesearch/until/color.dart';
import 'package:shimmer/shimmer.dart';

import '../until/common_value.dart';
import '../until/shimmer_card.dart';

class ShimmerEffectPage extends StatelessWidget {
  const ShimmerEffectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
          mainAxisExtent: mainAxisExtent,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing),
      itemBuilder: (context, i) {
       return  const ShimmerCard();
      },
    );
  }
}
