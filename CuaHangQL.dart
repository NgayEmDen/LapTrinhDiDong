import 'HoaDon.dart';
import 'SanPham.dart';

class Store {
  // Thuộc tính private
  String _storeName;
  String _address;
  List<SanPham> _productList = [];
  List<HoaDon> _invoiceList = [];

  // Constructor
  Store(this._storeName, this._address);

  // Getter và Setter
  String get storeName => _storeName;
  set storeName(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Tên cửa hàng không được rỗng.');
    }
    _storeName = value;
  }

  String get address => _address;
  set address(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Địa chỉ không được rỗng.');
    }
    _address = value;
  }

  // Phương thức quản lý điện thoại
  void addNewProduct(SanPham product) {
    _productList.add(product);
    print('Đã thêm điện thoại mới: ${product.tenDT}');
  }

  void updateProductInfo(String productId, SanPham newInfo) {
    for (var product in _productList) {
      if (product.maDT == productId) {
        product.tenDT = newInfo.tenDT;
        product.hangSX = newInfo.hangSX;
        product.giaNhap = newInfo.giaNhap;
        product.giaBan = newInfo.giaBan;
        product.SLTonKho = newInfo.SLTonKho;
        product.trangThai = newInfo.trangThai;
        print('Đã cập nhật thông tin điện thoại: $productId');
        return;
      }
    }
    print('Không tìm thấy điện thoại với mã: $productId');
  }

  void stopSellingProduct(String productId) {
    for (var product in _productList) {
      if (product.maDT == productId) {
        product.trangThai = false;
        print('Đã ngừng kinh doanh điện thoại: $productId');
        return;
      }
    }
    print('Không tìm thấy điện thoại với mã: $productId');
  }

  SanPham? searchProduct({String? id, String? name, String? brand}) {
    var result = _productList.where(
      (product) =>
          (id != null && product.maDT == id) ||
          (name != null && product.tenDT == name) ||
          (brand != null && product.hangSX == brand),
    );
    return result.isNotEmpty ? result.first : null;
  }

  void displayProductList() {
    for (var product in _productList) {
      product.hienThiThongTin();
    }
  }

  // Phương thức quản lý hóa đơn
  void createNewInvoice(HoaDon invoice) {
    var product = invoice.dienThoaiDuocBan;
    if (invoice.soLuongMua <= product.SLTonKho) {
      product.SLTonKho -= invoice.soLuongMua;
      _invoiceList.add(invoice);
      print('Đã tạo hóa đơn mới: ${invoice.maHoaDon}');
    } else {
      print('Không đủ số lượng tồn kho để tạo hóa đơn.');
    }
  }

  List<HoaDon> searchInvoice({String? id, DateTime? date, String? customerName}) {
    return _invoiceList.where((invoice) {
      return (id != null && invoice.maHoaDon == id) ||
          (date != null && invoice.ngayBan == date) ||
          (customerName != null && invoice.tenKhachHang == customerName);
    }).toList();
  }

  void displayInvoiceList() {
    for (var invoice in _invoiceList) {
      invoice.hienThiThongTinHoaDon();
    }
  }

  // Phương thức thống kê
  double calculateTotalRevenue(DateTime fromDate, DateTime toDate) {
    return _invoiceList
        .where(
            (invoice) => invoice.ngayBan.isAfter(fromDate) && invoice.ngayBan.isBefore(toDate))
        .fold(0.0, (total, invoice) => total + invoice.tinhTongTien());
  }

  double calculateTotalProfit(DateTime fromDate, DateTime toDate) {
    return _invoiceList
        .where(
            (invoice) => invoice.ngayBan.isAfter(fromDate) && invoice.ngayBan.isBefore(toDate))
        .fold(0.0, (total, invoice) => total + invoice.tinhLoiNhuanThucTe());
  }

  List<SanPham> getTopSellingProducts(int quantity) {
    var topSellingList = List<SanPham>.from(_productList);
    topSellingList.sort((a, b) => b.SLTonKho.compareTo(a.SLTonKho));
    return topSellingList.take(quantity).toList();
  }

  List<SanPham> getStockStatistics() {
    return _productList.where((product) => product.SLTonKho > 0).toList();
  }
}