class Product {
  String _productId;
  String _productName;
  String _manufacturer;
  double _purchasePrice;
  double _salePrice;
  int _stockQuantity;
  bool _status;

  Product(this._productId, this._productName, this._manufacturer, this._purchasePrice,
      this._salePrice, this._stockQuantity, this._status);

  // Getter
  String get productId => _productId;
  String get productName => _productName;
  String get manufacturer => _manufacturer;
  double get purchasePrice => _purchasePrice;
  double get salePrice => _salePrice;
  int get stockQuantity => _stockQuantity;
  bool get status => _status;

  // Setter
  set productId(String id) {
    if (id.isEmpty || !RegExp(r'^DT-\d{3}$').hasMatch(id)) {
      throw ArgumentError(
          'Product ID không hợp lệ! Định dạng phải là "DT-XXX".');
    }
    _productId = id;
  }

  set productName(String name) {
    if (name.isNotEmpty) {
      _productName = name;
    }
  }

  set manufacturer(String brand) {
    if (brand.isNotEmpty) {
      _manufacturer = brand;
    }
  }

  set purchasePrice(double price) {
    if (price > 0) {
      _purchasePrice = price;
    }
  }

  set salePrice(double price) {
    if (price > _purchasePrice) {
      _salePrice = price;
    }
  }

  set stockQuantity(int quantity) {
    _stockQuantity = quantity;
  }

  set status(bool isActive) {
    _status = isActive;
  }

  // Methods
  double potentialProfit(double salePrice, double purchasePrice) {
    return salePrice - purchasePrice;
  }

  void displayInfo() {
    print('Mã điện thoại: $_productId');
    print('Tên điện thoại: $_productName');
    print('Hãng sản xuất: $_manufacturer');
    print('Giá nhập: $_purchasePrice');
    print('Giá bán: $_salePrice');
    print('Số lượng tồn kho: $_stockQuantity');
    print('Trạng thái: ${_status ? 'Còn kinh doanh' : 'Ngừng kinh doanh'}');
  }

  bool canBeSold() {
    return _stockQuantity > 0 && _status;
  }
}