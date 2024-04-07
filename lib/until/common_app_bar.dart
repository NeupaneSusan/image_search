import 'package:flutter/material.dart';

import 'package:imagesearch/until/gesture_detector_button.dart';
import 'package:imagesearch/view/search_text_field.dart';

import 'color.dart';
import 'common_value.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueNotifier<bool>? valueNotifier;
  final TextEditingController? textEditingController;
  final ScrollController? scrollController;
  final bool isHomePage;
  final String title;
  const CommonAppBar(
      {super.key,
      required this.valueNotifier,
      required this.isHomePage,
      required this.title,
      this.textEditingController,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      centerTitle: true,
      titleTextStyle: const TextStyle(fontSize: 17),
      automaticallyImplyLeading: true,
      title: isHomePage
          ? SearchTextField(
              title: title,
              valueNotifier: valueNotifier!,
              textEditingController: textEditingController!)
          : Text(title),
      actions: [
        if (valueNotifier != null) ...[
          ValueListenableBuilder(
              valueListenable: valueNotifier!,
              builder: (context, bool data, child) {
                return GestureDetectorButton(
                  onTap: () {
                    valueNotifier!.value = !valueNotifier!.value;
                  },
                  iconData: !data ? Icons.search : Icons.close,
                );
              }),
        ],
        const SizedBox(
          width: 10,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
