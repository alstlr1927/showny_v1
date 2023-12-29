import 'package:flutter/cupertino.dart';

class RequestReturnProvider extends ChangeNotifier {
  String? _buyerSelectedItem;
  String? _sellerSelectedItem;
  String? _sizeSelectedItem;
  int _quantity = 0;

  int get quantity => _quantity;
  final List<String> _buyerDropDown = [
    '반품 사유를 선택하세요.',
    '고객단순변심',
    '주문 오류',
    '기타 ) 반품 사유를 입력해주세요.'
  ];
  final List<String> _sellerDropDown = [
    '반품 사유를 선택하세요.',
    '고객단순변심',
    '주문 오류',
    '기타 ) 반품 사유를 입력해주세요.'
  ];
  final List<String> _sizeDropDown = [
    'M',
    'L (품절)',
    'XL',
  ];
  RequestReturnProvider() {
    _buyerSelectedItem = _buyerDropDown[0]; // Initializing with the first value
    _sellerSelectedItem =
        _sellerDropDown[0]; // Initializing with the first value
  }
  int? _selectedIndex = 0;

  int? get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
  String? get buyerSelectedItem => _buyerSelectedItem;
  String? get sellerSelectedItem => _sellerSelectedItem;
  String? get sizeSelectedItem => _sizeSelectedItem;
  List<String> get sellerDropDown => _sellerDropDown;
  List<String> get sizeDropDown => _sizeDropDown;
  List<String> get buyerDropDown => _buyerDropDown;
  void selectItemBuyer(String? value) {
    _buyerSelectedItem = value;
    notifyListeners();
  }

  void selectSizeItem(String? value) {
    _sizeSelectedItem = value;
    notifyListeners();
  }

  void selectItemSeller(String? value) {
    _sellerSelectedItem = value;
    notifyListeners();
  }

  void increment() {
    _quantity++;
    notifyListeners(); // Notify all the listening widgets of the change.
  }

  void decrement() {
    if (_quantity > 0) {
      _quantity--;
      notifyListeners(); // Notify all the listening widgets of the change.
    }
  }
}
