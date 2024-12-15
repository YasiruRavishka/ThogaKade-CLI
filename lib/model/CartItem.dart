class CartItem {
  int itemId;
  int itemQty;

  CartItem({required this.itemId, required this.itemQty});

  factory CartItem.fromJson(Map<String, dynamic> fromJson) {
    return CartItem(
        itemId: fromJson['item_id'] as int,
        itemQty: fromJson['item_qty'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'item_id': itemId, 'item_qty': itemQty};
  }
}
