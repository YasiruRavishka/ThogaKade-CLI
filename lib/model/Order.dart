class Order {
  int? id;
  List<Map<int, int>> items; // Map of [VegetableID , Quantity]
  double total;
  DateTime timestamp;

  Order({
    this.id,
    required this.items,
    required this.total,
    required this.timestamp,
  });

  factory Order.fromJson(Map<String, dynamic> fromJson) {
    return Order(
        id: fromJson['id'] as int,
        items: fromJson['items'] as List<Map<int, int>>,
        total: fromJson['total'] as double,
        timestamp: DateTime.parse(fromJson['timestamp'] as String));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items,
      'total': total,
      'timestamp': timestamp.toIso8601String()
    };
  }
}
