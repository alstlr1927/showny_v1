class FilterShopModel {
  int sort = 0;
  int? minPrice;
  int? maxPrice;
  List<int> styleIdList = [];
  List<int> fitIdList = [];
  List<int> materialIdList = [];
  int flexibility = 1;
  List<int> colorList = [];

  void initFilter() {
    minPrice = null;
    maxPrice = null;
    sort = 0;
    styleIdList = [];
    fitIdList = [];
    materialIdList = [];
    flexibility = 1;
    colorList = [];
  }
}