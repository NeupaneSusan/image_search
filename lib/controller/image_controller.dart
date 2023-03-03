import 'package:flutter/material.dart';
import 'package:imagesearch/model/response_model.dart';
import 'package:imagesearch/respository/image_respository.dart';

import '../model/image_model.dart';

class ImageController with ChangeNotifier {
  List<ImageModel> _imageList = [];
  List<ImageModel> _favoriteList = [];
  bool _isLoading = true;
  bool _isLazyLoading = false;
  int _currentPage = 1;

  void fetchImage(
    String query,
    int currentPage,
  ) async {
    isLoading = true;
    final result = await ImageRespository.fetchImage(query, currentPage);
    if (result is Success) {
      _imageList.clear();
      _imageList = result.response as List<ImageModel>;

      _currentPage = currentPage;
      isLoading = false;
    }
    if (result is Error) {}
  }

  void addFavoriteList(ImageModel imageModel) async {
    int index =
        _favoriteList.indexWhere((element) => element.id == imageModel.id);
    if (index == -1) {
      _favoriteList.insert(0, imageModel);
      notifyListeners();
    }
  }

  void otherImage(String query) async {
     isLazyLoading = true;
    _currentPage = _currentPage + 1;
    final result = await ImageRespository.fetchImage(query, currentPage);
    if (result is Success) {
      _imageList.addAll(result.response as List<ImageModel>);
    }
    isLazyLoading = false;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isLazyLoading(bool value) {
    _isLazyLoading = value;
    notifyListeners();
  }

  void removeFavoriteList(ImageModel imageModel) {
    int index =
        _favoriteList.indexWhere((element) => element.id == imageModel.id);
    favoriteList.removeAt(index);
    notifyListeners();
  }

  List<ImageModel> get imageList => _imageList;
  List<ImageModel> get favoriteList => _favoriteList;
  bool get isLazyLoading => _isLazyLoading;
  int get currentPage => _currentPage;
  bool get isLoading=> _isLoading;
}
