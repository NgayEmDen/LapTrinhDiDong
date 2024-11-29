import 'SanPham.dart'; // Giả sử đã triển khai lớp SanPham

class Invoice {
  // Thuộc tính
  String _invoiceId;
  DateTime _saleDate;
  SanPham _soldProduct;
  int _quantityPurchased;
  double _actualSalePrice;
  String _customerName;
  String _customerPhone;

  // Constructor
  Invoice(
    this._invoiceId,
    this._saleDate,
    this._soldProduct,
    this._quantityPurchased,
    this._actualSalePrice,
    this._customerName,
    this._customerPhone,
  ) {
    // Validation
    invoiceId = _invoiceId;
    saleDate = _saleDate;
    quantityPurchased = _quantityPurchased;
    actualSalePrice = _actualSalePrice;
    customerName = _customerName;
    customerPhone = _customerPhone;
  }

  // Getter và Setter với validation
  String get invoiceId => _invoiceId;
  set invoiceId(String value) {
    if (value.isEmpty || !RegExp(r'^HD-\d{3}$').hasMatch(value)) {
      throw ArgumentError(
          'Invoice ID không hợp lệ! Định dạng phải là "HD-XXX".');
    }
    _invoiceId = value;
  }

  DateTime get saleDate => _saleDate;
  set saleDate(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw ArgumentError('Ngày bán không được sau ngày hiện tại.');
    }
    _saleDate = value;
  }

  SanPham get soldProduct => _soldProduct;

  int get quantityPurchased => _quantityPurchased;
  set quantityPurchased(int value) {
    if (value <= 0 || value > _soldProduct.SLTonKho) {
      throw ArgumentError(
          'Số lượng mua phải lớn hơn 0 và không được vượt quá số lượng tồn kho.');
    }
    _quantityPurchased = value;
  }

  double get actualSalePrice => _actualSalePrice;
  set actualSalePrice(double value) {
    if (value <= 0) {
      throw ArgumentError('Giá bán thực tế phải lớn hơn 0.');
    }
    _actualSalePrice = value;
  }

  String get customerName => _customerName;
  set customerName(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Tên khách hàng không được rỗng.');
    }
    _customerName = value;
  }

  String get customerPhone => _customerPhone;
  set customerPhone(String value) {
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      throw ArgumentError(
          'Số điện thoại khách không hợp lệ! Phải là 10 chữ số.');
    }
    _customerPhone = value;
  }

  // Phương thức tính tổng tiền
  double calculateTotal() {
    return _actualSalePrice * _quantityPurchased;
  }

  // Phương thức tính lợi nhuận thực tế
  double calculateActualProfit() {
    return (_actualSalePrice - _soldProduct.giaNhap) * _quantityPurchased;
  }

  // Phương thức hiển thị thông tin hóa đơn
  void displayInvoiceInfo() {
    print('Mã hóa đơn: $_invoiceId');
    print('Ngày bán: ${_saleDate.toIso8601String()}');
    print('Tên điện thoại: ${_soldProduct.tenDT}');
    print('Số lượng mua: $_quantityPurchased');
    print('Giá bán thực tế: $_actualSalePrice');
    print('Tên khách hàng: $_customerName');
    print('Số điện thoại khách: $_customerPhone');
    print('Tổng tiền: ${calculateTotal()}');
    print('Lợi nhuận thực tế: ${calculateActualProfit()}');
  }
}