class HomeModel {
  String? message;
  List<dynamic>? Banners;
  List<dynamic>? categories;
  List<dynamic>? categoriesImages;

  HomeModel.fromJson(Map<String, dynamic> json) {
    categoriesImages = json['categoriesImages'];
    Banners = json['Banners'];
    categories = json['categories'];
  }
}
