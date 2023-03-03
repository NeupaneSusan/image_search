import 'package:flutter/material.dart';
import 'package:imagesearch/until/common_app_bar.dart';

import 'package:imagesearch/until/grid_view.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        isHomePage: false,
        title: 'Favorite',
        valueNotifier: null,
      ),
      body: GridViewPage(
        isHomePage: false,
      ),
    );
  }
}
