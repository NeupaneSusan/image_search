import 'package:flutter/material.dart';
import 'package:imagesearch/until/color.dart';

import 'package:provider/provider.dart';

import '../controller/image_controller.dart';
import '../until/input_decoration.dart';

class SearchTextField extends StatelessWidget {
  final String title;
  final ValueNotifier<bool> valueNotifier;
  final TextEditingController textEditingController;
  final ScrollController? scrollController;
  const SearchTextField(
      {super.key,
      required this.title,
      required this.valueNotifier,
      required this.textEditingController,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
   if( MediaQuery.of(context).viewInsets.bottom==0){
     FocusManager.instance.primaryFocus?.unfocus();
   }
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, bool data, child) {
          if (!data) {
            return Text(title);
          }
          return Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Theme(
                data: ThemeData(
                    colorScheme:
                        ThemeData().colorScheme.copyWith(primary: baseColor)),
                child: TextFormField(
                  cursorColor: baseColor,
                  style: TextStyle(color: baseColor),
                  controller: textEditingController,
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      final provider = Provider.of<ImageController>(context,
                          listen: false);
                      if (provider.imageList.isNotEmpty) {
                        scrollController?.initialScrollOffset;
                      }

                      provider.fetchImage(value, 1);
                    }
                  },
                  decoration: inputDecoration(
                      hintText: 'Search Image',
                      prefixIcon: const Icon(Icons.search,size:23)),
                ),
              ),
            ],
          );
        });
  }
}
