const menu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];
  if (price == null) {
    throw ArgumentError('$name is not on the menu');
  }
  return OrderItem(name, price, qty);
}

double total(List<OrderItem> items) =>
    items.fold(0.0, (sum, item) => sum + item.subtotal);

String line(String label, double amount) =>
    label.padRight(19) + amount.toStringAsFixed(2).padLeft(6);

void printReceipt(List<OrderItem> items, {String? customer}) {
  final subtotal = total(items);
  final discount = subtotal >= 300 ? subtotal * 0.10 : 0.0;

  print('Order for ${customer ?? 'Guest'}');
  for (final item in items) {
    print(line('${item.qty} x ${item.name}', item.subtotal));
  }
  print(line('Subtotal', subtotal));
  if (discount > 0) {
    print(line('Discount 10%', -discount));
  }
  print(line('Total', subtotal - discount));
}

void main() {
  // First order: should total 328.50
  printReceipt([
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ]);

  print('');

  // Second order: below 300, so no discount line
  printReceipt([
    orderOf('Adobo rice', 2),
    orderOf('Iced tea', 1),
  ], customer: 'Juan');
}