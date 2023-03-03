import 'package:flutter/material.dart';
import 'package:imagesearch/until/common_value.dart';

InputDecoration inputDecoration({
  String? hintText = "",
  String? helperText = "",
  Icon? prefixIcon,
  
}) {
 
  return InputDecoration(
  
      prefixIcon: prefixIcon,
    
     
      hintText: '$hintText',
      alignLabelWithHint: true,
      helperText: '$helperText',
      counterText: '',
      focusColor: Colors.grey,
      border: InputBorder.none,
      focusedBorder: InputBorder.none);
}

InputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(borderRadius),
  ),
);
