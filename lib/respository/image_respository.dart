import 'dart:convert';

import 'package:imagesearch/model/image_model.dart';
import 'package:imagesearch/network/method.dart';

import '../model/response_model.dart';

class ImageRespository {
  static Future<Object> fetchImage(String query, currentPage) async {
    try {
      String querys = query.isEmpty ? "any" : query;
      List<String> listString = querys.split(" ");

      String newQuerys =
          listString.length >= 2 ? listString.join("+") : listString.join("");

      String url =
          "https://pixabay.com/api/?key=33987512-d7e9c29e6560569a044b8f8ac&q='$newQuerys'&page=$currentPage &image_type=all";

      Uri uri = Uri.parse(url);

      final response = await ApiController.getMethodWithOutToken(uri);

      if (response.statusCode == 200) {
        final parsedData = jsonDecode(response.body)['hits'];
        final data = parsedData.map<ImageModel>((json) {
          return ImageModel.fromJson(json);
        }).toList();
        return Success(code: response.statusCode, response: data);
      }
      return Failure(code: response.statusCode, errorMessage: 'Failure');
    } catch (e) {
      return Failure(code: 500, errorMessage: 'No Internet');
    }
  }
}
