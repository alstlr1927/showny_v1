enum ItemCategory {
  outer(0),
  top(1),
  pants(2),
  shoes(3),
  bag(4),
  accessory(5);

  const ItemCategory(this.idx);
  final int idx;
}

extension ItemCategoryExtension on ItemCategory {
  String get convertToString {
    switch (this) {
      case ItemCategory.outer:
        return '아우터';
      case ItemCategory.top:
        return '상의';
      case ItemCategory.pants:
        return '하의';
      case ItemCategory.shoes:
        return '신발';
      case ItemCategory.bag:
        return '가방';
      case ItemCategory.accessory:
        return '악세서리';
    }
  }
}
