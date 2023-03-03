import 'package:flutter/material.dart';
import 'package:imagesearch/controller/image_controller.dart';
import 'package:imagesearch/until/shimmer_card.dart';
import 'package:imagesearch/until/text_style.dart';
import 'package:imagesearch/view/shimmer_page.dart';
import 'package:provider/provider.dart';

import '../model/image_model.dart';
import 'color.dart';
import 'common_value.dart';
import 'dialog_box.dart';

class GridViewPage extends StatelessWidget {
  final bool isHomePage;
  final ScrollController? controller;
  const GridViewPage({
    super.key,
    required this.isHomePage,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<ImageController>(
      builder: (context, provider, child) {
        if (isHomePage && provider.isLoading) {
          return const ShimmerEffectPage();
        }
        int itemCount = isHomePage
            ? provider.imageList.length + 1
            : provider.favoriteList.length;
        if (!isHomePage && itemCount == 0) {
          return Center(
              child: Text(
            'Opps! There No Favorite.',
            style: textStyle,
          ));
        }
        if (isHomePage && itemCount == 1) {
          return Center(
            child: Text(
              'Opps! Not Found.',
              style: textStyle,
            ),
          );
        }
        return GridView.builder(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxCrossAxisExtent,
              mainAxisExtent: mainAxisExtent,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing),
          itemBuilder: (context, i) {
            if (i == provider.imageList.length && isHomePage) {
              return provider.isLazyLoading ? const ShimmerCard() : Container();
            } else {
              ImageModel image =
                  isHomePage ? provider.imageList[i] : provider.favoriteList[i];
              return Card(
                elevation: elevation,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isHomePage &&
                            provider.favoriteList
                                .where((element) => element.id == image.id)
                                .isEmpty) {
                          final provider = Provider.of<ImageController>(context,
                              listen: false);
                          provider.addFavoriteList(image);
                          return;
                        }
                        if (!isHomePage) {
                          customDialog(context: context, data: image);
                          return;
                        }

                        if (provider.favoriteList
                            .where((element) => element.id == image.id)
                            .isNotEmpty) {
                          customDialog(context: context, data: image);
                          return;
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: Image.network(
                          image.webformatURL!,
                          height: height,
                          width: width,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: baseColor,
                                backgroundColor: highlightColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: AnimatedOpacity(
                          curve: Curves.easeInOut,
                          opacity: provider.favoriteList
                                  .where((element) => element.id == image.id)
                                  .isNotEmpty
                              ? 1.0
                              : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ),
                        )),
                    Positioned(
                      bottom: 1,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(image.imageSize! / 1000000).toStringAsFixed(1)} Mb',
                              style: bottomTextStyle,
                            ),
                            SizedBox(
                              width: 120,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${image.user}',
                                  style: bottomTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 1,

                    //   right: 10,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 5),
                    //     child: Text(
                    //       '123456',
                    //       style: TextStyle(fontSize: 12, color: highlightColor),
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
