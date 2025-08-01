class CategoryModel {
  final String categoryId;
  final String categoryName;
  final String imageUrl;


  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
    );
  }
}