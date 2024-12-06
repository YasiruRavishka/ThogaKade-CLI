class Vegetable {
  int? id;
  String name;
  double pricePerKg;
  int availableQuantity;
  DateTime expDate;

  Vegetable({
    this.id,
    required this.name,
    required this.pricePerKg,
    required this.availableQuantity,
    required this.expDate,
  });

  factory Vegetable.fromJson(Map<String, dynamic> fromJson) {
    return Vegetable(
        id: fromJson['id'] as int,
        name: fromJson['name'] as String,
        pricePerKg: fromJson['price_per_kg'] as double,
        availableQuantity: fromJson['quantity'] as int,
        expDate: DateTime.parse(fromJson['exp_date'] as String));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price_per_kg': pricePerKg,
      'quantity': availableQuantity,
      'exp_date': expDate.toString().substring(0, 10)
    };
  }

  bool isExpired() {
    return DateTime.now().isAfter(expDate);
  }
}
