import '../models/CuaHangQL.dart';
import '../models/HoaDon.dart';
import '../models/SanPham.dart';

void main() {
  // Tạo một cửa hàng
  Store store = Store('Store A', '123 ABC Street');

  // Kiểm tra quản lý thông tin điện thoại
  print('\n--- Quản lý điện thoại ---');
  Product phone1 = Product(
    'DT-001',
    'iPhone 14',
    'Apple',
    20000000,
    25000000,
    10,
    true,
  );

  Product phone2 = Product(
    'DT-002',
    'Samsung Galaxy S23',
    'Samsung',
    18000000,
    22000000,
    5,
    true,
  );

  store.addNewProduct(phone1);
  store.addNewProduct(phone2);

  // Cập nhật thông tin điện thoại
  Product updatedPhone = Product(
    'DT-001',
    'iPhone 14 Pro',
    'Apple',
    23000000,
    28000000,
    8,
    true,
  );
  store.updateProductInfo('DT-001', updatedPhone);

  // Hiển thị danh sách điện thoại
  store.displayProductList();

  // Kiểm tra ngừng kinh doanh
  store.stopSellingProduct('DT-002');

  // Tìm kiếm điện thoại
  var searchPhone = store.searchProduct(id: 'DT-001');
  if (searchPhone != null) {
    print('Tìm thấy điện thoại: ${searchPhone.productName}');
  }

  // Kiểm tra quản lý hóa đơn
  print('\n--- Quản lý hóa đơn ---');
  Invoice invoice1 = Invoice(
    'HD-001',
    DateTime.now(),
    phone1,
    2,
    28000000,
    'Nguyen Van A',
    '0901234567',
  );

  store.createNewInvoice(invoice1);

  Invoice invoice2 = Invoice(
    'HD-002',
    DateTime.now(),
    phone1,
    1,
    28000000,
    'Tran Van B',
    '0909876543',
  );

  store.createNewInvoice(invoice2);

  // Hiển thị danh sách hóa đơn
  store.displayInvoiceList();

  // Tìm kiếm hóa đơn
  var searchInvoice = store.searchInvoice(id: 'HD-001');
  if (searchInvoice.isNotEmpty) {
    print('Tìm thấy hóa đơn: ${searchInvoice[0].invoiceId}');
  }

  // Kiểm tra thống kê
  print('\n--- Thống kê ---');
  DateTime fromDate = DateTime.now().subtract(Duration(days: 30));
  DateTime toDate = DateTime.now();

  double revenue = store.calculateTotalRevenue(fromDate, toDate);
  print('Tổng doanh thu: $revenue');

  double profit = store.calculateTotalProfit(fromDate, toDate);
  print('Tổng lợi nhuận: $profit');

  var topSellingProducts = store.getTopSellingProducts(1);
  print('Top điện thoại bán chạy: ${topSellingProducts.map((p) => p.productName).join(', ')}');

  var stockProducts = store.getStockStatistics();
  print('Sản phẩm tồn kho: ${stockProducts.map((p) => p.productName).join(', ')}');
}