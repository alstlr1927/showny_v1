class FilterMinishopModel {
  int sort = 0;
  int? minPrice;
  int? maxPrice;
  int? categoryId;
  int? isNew;

  bool isWear = false;
  bool isTransaction = false;

  void initFilter() {
    sort = 0;
    minPrice = null;
    maxPrice = null;
    categoryId = null;
    isNew = null;
    isWear = false;
    isTransaction = false;
  }
}