import 'package:flutter/material.dart';
import 'package:imagesearch/controller/image_controller.dart';
import 'package:imagesearch/until/color.dart';
import 'package:imagesearch/until/common_app_bar.dart';
import 'package:imagesearch/until/common_value.dart';
import 'package:imagesearch/until/grid_view.dart';
import 'package:imagesearch/view/favorite_page.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  final _scrollController = ScrollController();
  final ValueNotifier<bool> _valueNotifier = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ImageController>(context, listen: false);
      provider.fetchImage('', 1);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final provider = Provider.of<ImageController>(context, listen: false);
        provider.otherImage(textEditingController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CommonAppBar(
          scrollController: _scrollController,
          textEditingController: textEditingController,
          valueNotifier: _valueNotifier,
          isHomePage: true,
          title: 'Find Image',
        ),
        floatingActionButton: FloatingActionButton(
            elevation: elevation,
            backgroundColor: backgroundColor,
            child: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FavoritePage()));
            }),
        body: GridViewPage(
          controller: _scrollController,
          isHomePage: true,
        ));
  }
}
