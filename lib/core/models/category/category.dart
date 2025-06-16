import 'dart:ui';

import '../base_model.dart';

class Category implements BaseModel {
  final String? categoryId;
  final String? categoryName;
  final String? description;
  final String? imageUrl;
  final bool? isActive;
  final int? displayOrder;
  final String? parentCategoryId;
  final Category? parentCategory;
  final List<Category>? subCategories;
  final VoidCallback? onTap;
  final String? emoji;


  Category({
    this.categoryId,
    this.categoryName,
    this.description,
    this.imageUrl,
    this.isActive,
    this.displayOrder,
    this.parentCategoryId,
    this.parentCategory,
    this.subCategories,
    this.onTap,
    this.emoji
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      isActive: json['isActive'],
      displayOrder: json['displayOrder'],
      parentCategoryId: json['parentCategoryId'],
      parentCategory: json['parentCategory'] != null ? Category.fromJson(json['parentCategory']) : null,
      subCategories: json['categoryItems'] != null
          ? List<Category>.from(json['categoryItems'].map((x) => Category.fromJson(x)))
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'description': description,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'parentCategoryId': parentCategoryId,
      'parentCategory': parentCategory?.toJson(),
      'categoryItems': subCategories != null ? subCategories!.map((x) => x.toJson()).toList() : null,
    };
  }
}

final List<Category> categories = [
  Category(
    categoryName: 'Tâm lý học',
    emoji: '🧠',
    onTap: () {
      // Xử lý khi nhấn vào danh mục Tâm lý học
    },
  ),
  Category(
    categoryName: 'Kỹ năng',
    emoji: '💪',
    onTap: () {
      // Xử lý khi nhấn vào danh mục Kỹ năng
    },
  ),
  Category(
    categoryName: 'Tư duy',
    emoji: '🤔',
    onTap: () {
      // Xử lý khi nhấn vào danh mục Tư duy
    },
  ),
  Category(
    categoryName: 'Tâm linh - Tôn giáo',
    emoji: '🙏',
    onTap: () {
      // Xử lý khi nhấn vào danh mục Tâm linh - Tôn giáo
    },
  ),
  Category(
    categoryName: 'Văn học',
    emoji: '📜',
    onTap: () {
      // Xử lý khi nhấn vào danh mục Văn học
    },
  ),
  Category(
    categoryName: 'Kinh doanh',
    emoji: '🤝',
    onTap: () {
      // Xử lý khi nhấn vào danh mục Kinh doanh
    },
  ),
];