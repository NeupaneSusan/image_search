import 'package:flutter/material.dart';
import 'package:imagesearch/controller/image_controller.dart';
import 'package:imagesearch/until/color.dart';
import 'package:imagesearch/until/common_value.dart';
import 'package:provider/provider.dart';

import '../model/image_model.dart';
import 'text_style.dart';

Future customDialog({required BuildContext context, required ImageModel data}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        actionsPadding: const EdgeInsets.only(top: 25, right: 8),
        buttonPadding: EdgeInsets.zero,
        content: Text(
          'Do You Want To Remove From Favorite?',
          style: textStyle,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: backgroundColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('CANCEL'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: backgroundColor,
            ),
            onPressed: () {
              final provider =
                  Provider.of<ImageController>(context, listen: false);
              provider.removeFavoriteList(data);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
